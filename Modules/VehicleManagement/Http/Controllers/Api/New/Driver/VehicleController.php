<?php

namespace Modules\VehicleManagement\Http\Controllers\Api\New\Driver;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\JsonResponse;
use Illuminate\Routing\Controller;
use Modules\VehicleManagement\Http\Requests\VehicleApiStoreUpdateRequest;
use Modules\VehicleManagement\Interfaces\VehicleInterface;
use Modules\VehicleManagement\Service\Interface\VehicleServiceInterface;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Request;
use Modules\UserManagement\Entities\UserAccount;
use App\Models\PaymentStatus;
use Modules\TransactionManagement\Entities\Transaction;
//
class VehicleController extends Controller
{
    protected $vehicleService;


    public function __construct(VehicleServiceInterface $vehicleService)
    {
        $this->vehicleService = $vehicleService;
    }

    public function store(VehicleApiStoreUpdateRequest $request)
    {
        // Check if wallet already exists for this driver
        $existingWallet = UserAccount::where('user_id', $request->driver_id)->first();

        if (!$existingWallet) {
            // Create new wallet
            $wallet = UserAccount::create(['user_id' => $request->driver_id]);
        }

        if ($this->vehicleService->findOneBy(['driver_id' => $request->driver_id])) {
            return response()->json(responseFormatter(constant: VEHICLE_DRIVER_EXISTS_403), 403);
        }

        $this->vehicleService->create(data: $request->validated());

        return response()->json(responseFormatter(VEHICLE_CREATE_200), 200);
    }

    public function getPaymentStatus(Request $request) {
        try {
            // Validate input
            $request->validate([
                'phone_number' => 'required|string',
                'amount' => 'required|numeric',
                'driver_id' => 'required'
            ]);

            // Generate unique external reference using current timestamp
            $externalReference = time();

            // API URL for payment collection
            $collectUrl = 'https://api.primenetpay.com:9001/api/v2/transaction/collect';

            // API Headers
            $headers = [
                'X-Authorization: oVIr8pifqq0BwduzDhVRqUxmU5bqzV25Rn1eGxELHZwFep7dRB72smz4JXDTM38y',
                'Content-Type: application/json'
            ];

            // Payment request data
            $data = [
                "payer_number" => $request->phone_number,
                "account_number" => $request->phone_number,
                "external_reference" => $externalReference,
                "payment_narration" => "Test Payment",
                "currency" => "ZMW",
                "amount" => $request->amount
            ];

            // Send payment request
            $response = $this->sendCurlRequest($collectUrl, $headers, $data);

            // Store transaction in database
            PaymentStatus::create([
                'driver_id' => $request->driver_id,
                'external_reference' => $externalReference,
                'amount' => $request->amount,
                'status' => 'pending'
            ]);

            return response()->json(['message' => 'Payment Initiated', 'transaction_id' => $externalReference]);

        } catch (\Exception $e) {
            return response()->json(['error' => 'Payment request failed', 'details' => $e->getMessage()], 500);
        }
    }

    // Function to check payment status
    public function checkPaymentStatus() {
        try {
            // Get pending transactions
            $pendingPayments = PaymentStatus::where('status', 'pending')->get();

            foreach ($pendingPayments as $payment) {
                $externalReference = $payment->external_reference;

                // Transaction status API URL
                $statusUrl = "https://api.primenetpay.com:9001/api/v2/transaction/status/$externalReference";

                // API Headers
                $headers = [
                    'X-Authorization: oVIr8pifqq0BwduzDhVRqUxmU5bqzV25Rn1eGxELHZwFep7dRB72smz4JXDTM38y',
                    'Content-Type: application/json'
                ];

                // Send status check request
                $response = $this->sendCurlRequest($statusUrl, $headers, [], 'GET');

                // Check response
                if (isset($response['final_status']) &&
                    $response['final_status'] === 300) {

                    // Update driver's wallet
                    $updateWalletBalance = UserAccount::where('user_id', $payment->driver_id)->first();

                    if (!$updateWalletBalance) {
                        // Create new wallet if it doesn't exist
                        UserAccount::create([
                            'user_id' => $payment->driver_id,
                            'wallet_balance' => $payment->amount
                        ]);
                    } else {
                        // Update wallet balance by adding the new amount
                        $updateWalletBalance->wallet_balance += $payment->amount;
                        $updateWalletBalance->save();
                    }

                    // Update transaction status
                    $payment->update(['status' => 'success']);

                    // Delete the transaction from the table
                    $payment->delete();

                    $adminAccount = UserAccount::where('user_id', $payment->driver_id)->first();

                    $adminTransaction3 = new Transaction();
                    $adminTransaction3->attribute = 'add_wallet';
                    $adminTransaction3->credit = $payment->amount;
                    $adminTransaction3->balance = $adminAccount->wallet_balance;
                    $adminTransaction3->user_id = $payment->driver_id;
                    $adminTransaction3->account = 'add_wallet';
                    $adminTransaction3->save();
                }
            }

            return response()->json(['message' => 'Payment Status Checked']);

        } catch (\Exception $e) {
            return response()->json(['error' => 'Payment status check failed', 'details' => $e->getMessage()], 500);
        }
    }

    // Function to send cURL request
    private function sendCurlRequest($url, $headers, $data = [], $method = 'POST') {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $method);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        if ($method === 'POST') {
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
        }

        $response = curl_exec($ch);
        curl_close($ch);

        return json_decode($response, true);
    }

    public function update(int|string $id, VehicleApiStoreUpdateRequest $request)
    {
        $this->vehicleService->updatedBy(criteria:['driver_id'=> $id], data: $request->validated());
        return response()->json(responseFormatter(VEHICLE_UPDATE_200), 200);
    }
}
