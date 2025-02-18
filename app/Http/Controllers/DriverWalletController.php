<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\DriverWallet;

class DriverWalletController extends Controller
{
    // Create Wallet on Driver Registration
    public function createWallet($driverId) {
        $wallet = DriverWallet::create(['driver_id' => $driverId, 'balance' => 0]);
        return response()->json(['message' => 'Wallet Created', 'wallet' => $wallet]);
    }

    // Deduct Money from Wallet
    public function deductFromWallet(Request $request) {
        $wallet = DriverWallet::where('driver_id', $request->driver_id)->first();
        if (!$wallet || $wallet->balance < $request->amount) {
            return response()->json(['error' => 'Insufficient Balance'], 400);
        }
        $wallet->balance -= $request->amount;
        $wallet->save();
        return response()->json(['message' => 'Amount Deducted', 'wallet' => $wallet]);
    }

    // Add Money to Wallet
    public function addMoney(Request $request) {
        $wallet = DriverWallet::where('driver_id', $request->driver_id)->first();
        if (!$wallet) {
            return response()->json(['error' => 'Wallet not found'], 404);
        }
        $wallet->balance += $request->amount;
        $wallet->save();
        return response()->json(['message' => 'Money Added', 'wallet' => $wallet]);
    }

    // Check Minimum Balance Before Ride
    public function checkMinimumBalance(Request $request) {
        $wallet = DriverWallet::where('driver_id', $request->driver_id)->first();
        if (!$wallet || $wallet->balance < 50) { // Minimum balance required
            return response()->json(['error' => 'Minimum balance required'], 400);
        }
        return response()->json(['message' => 'Eligible for Ride']);
    }
}
