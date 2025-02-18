-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 05, 2024 at 05:31 PM
-- Server version: 10.11.10-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u468281061_mighty`
--

-- --------------------------------------------------------

--
-- Table structure for table `additional_fees`
--

CREATE TABLE `additional_fees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `app_settings`
--

CREATE TABLE `app_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `site_name` varchar(255) DEFAULT NULL,
  `site_email` varchar(255) DEFAULT NULL,
  `site_logo` varchar(255) DEFAULT NULL,
  `site_favicon` varchar(255) DEFAULT NULL,
  `site_description` longtext DEFAULT NULL,
  `site_copyright` varchar(255) DEFAULT NULL,
  `facebook_url` varchar(255) DEFAULT NULL,
  `instagram_url` varchar(255) DEFAULT NULL,
  `twitter_url` varchar(255) DEFAULT NULL,
  `linkedin_url` varchar(255) DEFAULT NULL,
  `language_option` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`language_option`)),
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `help_support_url` varchar(255) DEFAULT NULL,
  `notification_settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`notification_settings`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_settings`
--

INSERT INTO `app_settings` (`id`, `site_name`, `site_email`, `site_logo`, `site_favicon`, `site_description`, `site_copyright`, `facebook_url`, `instagram_url`, `twitter_url`, `linkedin_url`, `language_option`, `contact_email`, `contact_number`, `help_support_url`, `notification_settings`, `created_at`, `updated_at`) VALUES
(1, 'JayKay Rides', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '[\"en\"]', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `driver_id` bigint(20) UNSIGNED DEFAULT NULL,
  `rider_id` bigint(20) UNSIGNED DEFAULT NULL,
  `complaint_by` varchar(255) DEFAULT NULL COMMENT 'rider, driver',
  `subject` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `ride_request_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` varchar(255) DEFAULT 'pending' COMMENT 'pending, investigation, resolved',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `complaint_comments`
--

CREATE TABLE `complaint_comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `complaint_id` bigint(20) UNSIGNED NOT NULL,
  `added_by` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `comment` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `coupon_type` varchar(255) DEFAULT NULL COMMENT 'all,first_ride,region_wise,service_wise',
  `usage_limit_per_rider` bigint(20) UNSIGNED DEFAULT NULL,
  `discount_type` varchar(255) DEFAULT NULL COMMENT 'fixed,percentage',
  `discount` double DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `minimum_amount` double DEFAULT NULL,
  `maximum_discount` double DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `region_ids` text DEFAULT NULL,
  `service_ids` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT 'driver' COMMENT 'driver',
  `is_required` tinyint(4) DEFAULT NULL,
  `has_expiry_date` tinyint(4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `name`, `type`, `is_required`, `has_expiry_date`, `status`, `created_at`, `updated_at`) VALUES
(1, 'License', 'driver', 1, 1, 1, '2024-12-01 17:51:57', '2024-12-01 17:51:57');

-- --------------------------------------------------------

--
-- Table structure for table `driver_documents`
--

CREATE TABLE `driver_documents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `document_id` bigint(20) UNSIGNED DEFAULT NULL,
  `driver_id` bigint(20) UNSIGNED DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `is_verified` tinyint(4) DEFAULT 0 COMMENT '0-pending,1-approved,2-rejected',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `driver_documents`
--

INSERT INTO `driver_documents` (`id`, `document_id`, `driver_id`, `expire_date`, `is_verified`, `created_at`, `updated_at`) VALUES
(1, 1, 4, '2035-12-14', 1, '2024-12-01 17:52:39', '2024-12-01 17:54:03'),
(2, 1, 6, '2024-12-01', 0, '2024-12-01 19:21:27', '2024-12-01 19:21:27');

-- --------------------------------------------------------

--
-- Table structure for table `driver_services`
--

CREATE TABLE `driver_services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `driver_id` bigint(20) UNSIGNED DEFAULT NULL,
  `service_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  `uuid` char(36) DEFAULT NULL,
  `collection_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `disk` varchar(255) NOT NULL,
  `conversions_disk` varchar(255) DEFAULT NULL,
  `size` bigint(20) UNSIGNED NOT NULL,
  `manipulations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`manipulations`)),
  `custom_properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`custom_properties`)),
  `generated_conversions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`generated_conversions`)),
  `responsive_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`responsive_images`)),
  `order_column` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `media`
--

INSERT INTO `media` (`id`, `model_type`, `model_id`, `uuid`, `collection_name`, `name`, `file_name`, `mime_type`, `disk`, `conversions_disk`, `size`, `manipulations`, `custom_properties`, `generated_conversions`, `responsive_images`, `order_column`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\Service', 1, '62de1d74-05a0-4fb1-bf70-ce6eab041abd', 'service_image', 'aviator-logo', 'aviator-logo.jpg', 'image/jpeg', 'public', 'public', 15026, '[]', '[]', '[]', '[]', 1, '2024-12-01 17:46:53', '2024-12-01 17:46:53'),
(2, 'App\\Models\\DriverDocument', 1, 'f746c1ac-0e3f-449f-abe2-c20a6e773bbd', 'driver_document', 'FB_IMG_1733073962421', 'FB_IMG_1733073962421.jpg', 'image/jpeg', 'public', 'public', 23495, '[]', '[]', '[]', '[]', 2, '2024-12-01 17:52:39', '2024-12-01 17:52:39'),
(3, 'App\\Models\\DriverDocument', 2, '328f24f2-d125-4aa7-8b61-6c7a274f3ee4', 'driver_document', 'IMG-20241129-WA0003', 'IMG-20241129-WA0003.jpg', 'image/jpeg', 'public', 'public', 234798, '[]', '[]', '[]', '[]', 3, '2024-12-01 19:21:27', '2024-12-01 19:21:27');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2022_04_28_130817_create_user_details_table', 1),
(6, '2022_04_29_063151_create_regions_table', 1),
(7, '2022_04_29_063230_create_services_table', 1),
(8, '2022_04_29_064239_create_ride_requests_table', 1),
(9, '2022_04_29_064325_create_driver_services_table', 1),
(10, '2022_04_29_064758_create_complaints_table', 1),
(11, '2022_04_29_064809_create_reviews_table', 1),
(12, '2022_05_02_061025_create_ride_request_histories_table', 1),
(13, '2022_05_02_102753_create_payment_gateways_table', 1),
(14, '2022_05_02_102825_create_payments_table', 1),
(15, '2022_05_02_120722_create_permission_tables', 1),
(16, '2022_05_04_100102_create_media_table', 1),
(17, '2022_05_18_095512_create_coupons_table', 1),
(18, '2022_05_18_095624_create_wallets_table', 1),
(19, '2022_05_18_096432_create_wallet_histories_table', 1),
(20, '2022_05_23_084042_create_notifications_table', 1),
(21, '2022_05_23_094130_create_settings_table', 1),
(22, '2022_05_23_104508_create_app_settings_table', 1),
(23, '2022_06_09_074731_create_additional_fees_table', 1),
(24, '2022_06_13_125956_create_documents_table', 1),
(25, '2022_06_13_130010_create_driver_documents_table', 1),
(26, '2022_08_05_071122_create_sos_table', 1),
(27, '2022_08_05_113139_create_ride_request_ratings_table', 1),
(28, '2022_08_08_052703_create_withdraw_requests_table', 1),
(29, '2022_08_08_090613_create_user_bank_accounts_table', 1),
(30, '2022_12_10_091040_alter_services_table', 2),
(31, '2022_12_12_082101_alter_users_table', 2),
(32, '2022_12_20_100326_create_complaint_comments_table', 3),
(33, '2023_01_13_071123_add_last_location_update_at_in_users_table', 4),
(34, '2023_01_13_071835_alter_ride_requests_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(2, 'App\\Models\\User', 3),
(3, 'App\\Models\\User', 4),
(3, 'App\\Models\\User', 5),
(3, 'App\\Models\\User', 6);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rider_id` bigint(20) UNSIGNED NOT NULL,
  `ride_request_id` bigint(20) UNSIGNED NOT NULL,
  `datetime` datetime DEFAULT NULL,
  `total_amount` double DEFAULT 0,
  `admin_commission` double DEFAULT 0,
  `received_by` varchar(255) DEFAULT NULL,
  `driver_fee` double DEFAULT 0,
  `driver_tips` double DEFAULT 0,
  `driver_commission` double DEFAULT 0,
  `fleet_commission` double DEFAULT 0,
  `payment_type` varchar(255) DEFAULT 'cash',
  `txn_id` varchar(255) DEFAULT NULL,
  `payment_status` varchar(255) DEFAULT NULL COMMENT 'pending, paid, failed',
  `transaction_detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`transaction_detail`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_gateways`
--

CREATE TABLE `payment_gateways` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1 COMMENT '0- InActive, 1- Active',
  `is_test` tinyint(4) DEFAULT 1 COMMENT '0-  No, 1- Yes',
  `test_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`test_value`)),
  `live_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`live_value`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `parent_id`, `created_at`, `updated_at`) VALUES
(1, 'role', 'web', NULL, '2022-11-02 06:05:42', NULL),
(2, 'role add', 'web', 1, '2022-11-02 06:05:42', NULL),
(3, 'role list', 'web', 1, '2022-11-02 06:05:42', NULL),
(4, 'permission', 'web', NULL, '2022-11-02 06:05:42', NULL),
(5, 'permission add', 'web', 4, '2022-11-02 06:05:42', NULL),
(6, 'permission list', 'web', 4, '2022-11-02 06:05:42', NULL),
(7, 'region', 'web', NULL, '2022-11-02 06:05:42', NULL),
(8, 'region list', 'web', 7, '2022-11-02 06:05:42', NULL),
(9, 'region add', 'web', 7, '2022-11-02 06:05:42', NULL),
(10, 'region edit', 'web', 7, '2022-11-02 06:05:42', NULL),
(11, 'region delete', 'web', 7, '2022-11-02 06:05:42', NULL),
(12, 'service', 'web', NULL, '2022-11-02 06:05:42', NULL),
(13, 'service list', 'web', 12, '2022-11-02 06:05:42', NULL),
(14, 'service add', 'web', 12, '2022-11-02 06:05:42', NULL),
(15, 'service edit', 'web', 12, '2022-11-02 06:05:42', NULL),
(16, 'service delete', 'web', 12, '2022-11-02 06:05:42', NULL),
(17, 'driver', 'web', NULL, '2022-11-02 06:05:42', NULL),
(18, 'driver list', 'web', 17, '2022-11-02 06:05:42', NULL),
(19, 'driver add', 'web', 17, '2022-11-02 06:05:42', NULL),
(20, 'driver edit', 'web', 17, '2022-11-02 06:05:42', NULL),
(21, 'driver delete', 'web', 17, '2022-11-02 06:05:42', NULL),
(22, 'rider', 'web', NULL, '2022-11-02 06:05:42', NULL),
(23, 'rider list', 'web', 22, '2022-11-02 06:05:42', NULL),
(24, 'rider add', 'web', 22, '2022-11-02 06:05:42', NULL),
(25, 'rider edit', 'web', 22, '2022-11-02 06:05:42', NULL),
(26, 'rider delete', 'web', 22, '2022-11-02 06:05:42', NULL),
(27, 'riderequest', 'web', NULL, '2022-11-02 06:05:42', NULL),
(28, 'riderequest list', 'web', 27, '2022-11-02 06:05:42', NULL),
(29, 'riderequest show', 'web', 27, '2022-11-02 06:05:42', NULL),
(30, 'riderequest delete', 'web', 27, '2022-11-02 06:05:42', NULL),
(31, 'pending driver', 'web', 17, '2022-11-02 06:05:42', NULL),
(32, 'document', 'web', NULL, '2022-11-02 06:05:42', NULL),
(33, 'document list', 'web', 32, '2022-11-02 06:05:42', NULL),
(34, 'document add', 'web', 32, '2022-11-02 06:05:42', NULL),
(35, 'document edit', 'web', 32, '2022-11-02 06:05:42', NULL),
(36, 'document delete', 'web', 32, '2022-11-02 06:05:42', NULL),
(37, 'driverdocument', 'web', NULL, '2022-11-02 06:05:42', NULL),
(38, 'driverdocument list', 'web', 37, '2022-11-02 06:05:42', NULL),
(39, 'driverdocument add', 'web', 37, '2022-11-02 06:05:42', NULL),
(40, 'driverdocument edit', 'web', 37, '2022-11-02 06:05:42', NULL),
(41, 'driverdocument delete', 'web', 37, '2022-11-02 06:05:42', NULL),
(42, 'coupon', 'web', NULL, '2022-11-02 06:05:42', NULL),
(43, 'coupon list', 'web', 42, '2022-11-02 06:05:42', NULL),
(44, 'coupon add', 'web', 42, '2022-11-02 06:05:42', NULL),
(45, 'coupon edit', 'web', 42, '2022-11-02 06:05:42', NULL),
(46, 'coupon delete', 'web', 42, '2022-11-02 06:05:42', NULL),
(47, 'additionalfees', 'web', NULL, '2022-11-02 06:05:42', NULL),
(48, 'additionalfees list', 'web', 47, '2022-11-02 06:05:42', NULL),
(49, 'additionalfees add', 'web', 47, '2022-11-02 06:05:42', NULL),
(50, 'additionalfees edit', 'web', 47, '2022-11-02 06:05:42', NULL),
(51, 'additionalfees delete', 'web', 47, '2022-11-02 06:05:42', NULL),
(52, 'sos', 'web', NULL, '2022-11-02 06:05:42', NULL),
(53, 'sos list', 'web', 52, '2022-11-02 06:05:42', NULL),
(54, 'sos add', 'web', 52, '2022-11-02 06:05:42', NULL),
(55, 'sos edit', 'web', 52, '2022-11-02 06:05:42', NULL),
(56, 'sos delete', 'web', 52, '2022-11-02 06:05:42', NULL),
(57, 'complaint', 'web', NULL, '2022-11-02 06:05:42', NULL),
(58, 'complaint list', 'web', 57, '2022-11-02 06:05:42', NULL),
(59, 'complaint add', 'web', 57, '2022-11-02 06:05:42', NULL),
(60, 'complaint edit', 'web', 57, '2022-11-02 06:05:42', NULL),
(61, 'complaint delete', 'web', 57, '2022-11-02 06:05:42', NULL),
(62, 'pages', 'web', NULL, '2022-11-02 06:05:42', NULL),
(63, 'terms condition', 'web', 62, '2022-11-02 06:05:42', NULL),
(64, 'privacy policy', 'web', 62, '2022-11-02 06:05:42', NULL),
(65, 'driver show', 'web', 17, '2022-12-23 06:05:42', NULL),
(66, 'rider show', 'web', 22, '2022-12-23 06:05:42', NULL),
(67, 'complaint show', 'web', 57, '2022-12-23 06:05:42', NULL),
(68, 'driverearning list', 'web', 17, '2023-01-17 06:05:42', NULL),
(69, 'driver location', 'web', 17, '2023-01-17 06:05:42', NULL),
(70, 'dispatch add', 'web', 27, '2023-09-14 02:05:42', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 2, 'auth_token', '3e1f9a19aaa80e5213d7b5504182e3ad099e025914cbb33f062c291d5bd7b193', '[\"*\"]', NULL, '2024-12-01 15:45:09', '2024-12-01 15:45:09'),
(2, 'App\\Models\\User', 2, 'auth_token', 'c62601075dadc545942837ebd7245efcc8700ef9c61ba41dae0f1cfc67803407', '[\"*\"]', '2024-12-01 16:26:08', '2024-12-01 16:02:45', '2024-12-01 16:26:08'),
(3, 'App\\Models\\User', 2, 'auth_token', '1989de749edd804b3d21258e94147ccc768e7ed06f3028ccd77fe16705828156', '[\"*\"]', '2024-12-01 16:36:02', '2024-12-01 16:26:59', '2024-12-01 16:36:02'),
(4, 'App\\Models\\User', 3, 'auth_token', 'a2179967ec776639be376e33a334b05116dce945aafcb00b6c96219ada322dac', '[\"*\"]', NULL, '2024-12-01 16:59:27', '2024-12-01 16:59:27'),
(5, 'App\\Models\\User', 4, 'auth_token', 'd3f6e5127aecca08c31917a701e7716290b435747b5fd61ea67586ea82c090e1', '[\"*\"]', NULL, '2024-12-01 17:47:59', '2024-12-01 17:47:59'),
(6, 'App\\Models\\User', 5, 'auth_token', 'bc4fad9f78c722d82b79e516ae893fff638eb039c4121f5bcc3a715dbd3afb64', '[\"*\"]', NULL, '2024-12-01 17:50:46', '2024-12-01 17:50:46'),
(7, 'App\\Models\\User', 4, 'auth_token', 'a8f665711784b1854b9e507827649db132854954cae69efc28f0ec961bf1cb45', '[\"*\"]', '2024-12-01 17:55:21', '2024-12-01 17:51:25', '2024-12-01 17:55:21'),
(8, 'App\\Models\\User', 6, 'auth_token', '0f257659756d02d9d97d66b2bbc1994a73b72b2e7b187eda07b8a9c6e6658d60', '[\"*\"]', NULL, '2024-12-01 19:18:37', '2024-12-01 19:18:37'),
(9, 'App\\Models\\User', 6, 'auth_token', '75e52d15dfe20c684559ec0b00a7876e77fc31a794bfb3926b6bf54aa99d5545', '[\"*\"]', '2024-12-01 19:21:29', '2024-12-01 19:19:48', '2024-12-01 19:21:29');

-- --------------------------------------------------------

--
-- Table structure for table `regions`
--

CREATE TABLE `regions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `distance_unit` varchar(255) DEFAULT 'km' COMMENT 'km,mile',
  `coordinates` polygon DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1,
  `timezone` varchar(255) DEFAULT 'UTC',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `regions`
--

INSERT INTO `regions` (`id`, `name`, `distance_unit`, `coordinates`, `status`, `timezone`, `created_at`, `updated_at`) VALUES
(1, 'zambia', 'km', 0x000000000103000000010000000500000059f22eea605953409e5b005bc0a13c4059f22eea005f53408e0b7b590fa23c4020f22e2a0c5f5340389eb89272963c401af22e7a2b595340bafe6b6c2d963c4059f22eea605953409e5b005bc0a13c40, 1, 'America/Argentina/Mendoza', '2024-12-01 17:45:30', '2024-12-01 17:45:30');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `driver_id` bigint(20) UNSIGNED DEFAULT NULL,
  `rider_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ride_request_id` bigint(20) UNSIGNED DEFAULT NULL,
  `driver_rating` double DEFAULT 0,
  `rider_rating` double DEFAULT 0,
  `driver_review` text DEFAULT NULL,
  `rider_review` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ride_requests`
--

CREATE TABLE `ride_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rider_id` bigint(20) UNSIGNED DEFAULT NULL,
  `service_id` bigint(20) UNSIGNED DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `is_schedule` tinyint(1) DEFAULT 0 COMMENT '0-regular, 1-schedule',
  `ride_attempt` int(11) DEFAULT 0,
  `distance_unit` varchar(255) DEFAULT NULL,
  `total_amount` double DEFAULT 0,
  `subtotal` double DEFAULT 0,
  `extra_charges_amount` double DEFAULT 0,
  `driver_id` bigint(20) UNSIGNED DEFAULT NULL,
  `riderequest_in_driver_id` bigint(20) UNSIGNED DEFAULT NULL,
  `riderequest_in_datetime` datetime DEFAULT NULL,
  `start_latitude` varchar(255) DEFAULT NULL,
  `start_longitude` varchar(255) DEFAULT NULL,
  `start_address` text DEFAULT NULL,
  `end_latitude` varchar(255) DEFAULT NULL,
  `end_longitude` varchar(255) DEFAULT NULL,
  `end_address` text DEFAULT NULL,
  `distance` double DEFAULT NULL,
  `base_distance` double DEFAULT NULL,
  `duration` double DEFAULT NULL,
  `seat_count` double DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `base_fare` double DEFAULT NULL,
  `minimum_fare` double DEFAULT NULL,
  `per_distance` double DEFAULT NULL,
  `per_distance_charge` double DEFAULT NULL,
  `per_minute_drive` double DEFAULT NULL,
  `per_minute_drive_charge` double DEFAULT NULL,
  `extra_charges` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`extra_charges`)),
  `coupon_discount` double DEFAULT NULL,
  `coupon_code` bigint(20) UNSIGNED DEFAULT NULL,
  `coupon_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`coupon_data`)),
  `otp` varchar(255) DEFAULT NULL,
  `cancel_by` enum('rider','driver','auto') DEFAULT NULL,
  `cancelation_charges` double DEFAULT NULL,
  `waiting_time` double DEFAULT NULL,
  `waiting_time_limit` double DEFAULT NULL,
  `tips` double DEFAULT NULL,
  `per_minute_waiting` double DEFAULT NULL,
  `per_minute_waiting_charge` double DEFAULT NULL,
  `payment_type` varchar(255) DEFAULT NULL,
  `is_driver_rated` tinyint(1) DEFAULT 0,
  `is_rider_rated` tinyint(1) DEFAULT 0,
  `cancelled_driver_ids` text DEFAULT NULL,
  `service_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`service_data`)),
  `max_time_for_find_driver_for_ride_request` double DEFAULT NULL,
  `is_ride_for_other` tinyint(1) DEFAULT 0 COMMENT '0-self, 1-other',
  `other_rider_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`other_rider_data`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ride_request_histories`
--

CREATE TABLE `ride_request_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ride_request_id` bigint(20) UNSIGNED NOT NULL,
  `datetime` datetime DEFAULT NULL,
  `history_type` varchar(255) DEFAULT NULL,
  `history_message` varchar(255) DEFAULT NULL,
  `history_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`history_data`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ride_request_ratings`
--

CREATE TABLE `ride_request_ratings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ride_request_id` bigint(20) UNSIGNED NOT NULL,
  `rider_id` bigint(20) UNSIGNED DEFAULT NULL,
  `driver_id` bigint(20) UNSIGNED DEFAULT NULL,
  `rating` double NOT NULL DEFAULT 0,
  `comment` text DEFAULT NULL,
  `rating_by` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `status` tinyint(4) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', 1, '2022-11-02 06:05:42', NULL),
(2, 'rider', 'web', 1, '2022-11-02 06:05:42', NULL),
(3, 'driver', 'web', 1, '2022-11-02 06:05:42', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1);

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `region_id` bigint(20) UNSIGNED DEFAULT NULL,
  `capacity` bigint(20) UNSIGNED DEFAULT 1,
  `base_fare` double DEFAULT NULL,
  `minimum_fare` double DEFAULT NULL,
  `minimum_distance` double DEFAULT NULL,
  `per_distance` double DEFAULT NULL,
  `per_minute_drive` double DEFAULT NULL,
  `per_minute_wait` double DEFAULT NULL,
  `waiting_time_limit` double DEFAULT NULL,
  `cancellation_fee` double DEFAULT NULL,
  `payment_method` enum('cash_wallet','cash','wallet') NOT NULL DEFAULT 'cash',
  `commission_type` varchar(255) DEFAULT NULL COMMENT 'fixed, percentage',
  `admin_commission` double DEFAULT 0,
  `fleet_commission` double DEFAULT 0,
  `status` tinyint(4) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id`, `name`, `region_id`, `capacity`, `base_fare`, `minimum_fare`, `minimum_distance`, `per_distance`, `per_minute_drive`, `per_minute_wait`, `waiting_time_limit`, `cancellation_fee`, `payment_method`, `commission_type`, `admin_commission`, `fleet_commission`, `status`, `description`, `created_at`, `updated_at`) VALUES
(1, 'staff1', 1, 1400, 50, 50, 10, 5, 2, 2, 2, 100, 'cash_wallet', 'fixed', 10, 0, 1, 'tst', '2024-12-01 17:46:53', '2024-12-01 17:46:53');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `type`, `value`) VALUES
(1, 'CURRENCY_CODE', 'CURRENCY', 'ZMW'),
(2, 'CURRENCY_POSITION', 'CURRENCY', 'left'),
(3, 'ONESIGNAL_APP_ID', 'ONESIGNAL', 'fc233d8e-ef77-427c-bca8-cbf504ccd984'),
(4, 'ONESIGNAL_REST_API_KEY', 'ONESIGNAL', 'os_v2_app_7qrt3dxpo5bhzpfizp2qjtgzqs2aiemzgt4uyvf4x6r224efmzzudh5ftirgqhzgi2hjgqmimjtn6acvg6co4l6j6kswul7ubwrd3yi'),
(5, 'DISTANCE_RADIUS', 'DISTANCE', '50'),
(6, 'ONESIGNAL_DRIVER_APP_ID', 'ONESIGNAL', '889676e4-0f53-485c-8681-86d52b3547b0'),
(7, 'ONESIGNAL_DRIVER_REST_API_KEY', 'ONESIGNAL', 'os_v2_app_rclhnzapknefzbubq3kswnkhwan7jdvianme3o4atnuwlcwcm3yv6ejk46j6ftbg2gafvwbldhlpu5kamcq34y5trwjab4xou7vrdoi'),
(8, 'RIDE_FOR_OTHER', 'RIDE', '0'),
(9, 'FIREBASE_SERVER_KEY', 'FIREBASE', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sos`
--

CREATE TABLE `sos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `region_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `added_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `contact_number` varchar(255) DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `address` text DEFAULT NULL,
  `user_type` varchar(255) DEFAULT NULL,
  `player_id` varchar(255) DEFAULT NULL,
  `service_id` bigint(20) UNSIGNED DEFAULT NULL,
  `fleet_id` bigint(20) UNSIGNED DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `last_notification_seen` timestamp NULL DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `is_online` tinyint(4) DEFAULT 0,
  `is_available` tinyint(4) DEFAULT 1,
  `is_verified_driver` tinyint(4) DEFAULT 0,
  `uid` varchar(255) DEFAULT NULL,
  `fcm_token` text DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `login_type` varchar(255) DEFAULT NULL,
  `timezone` varchar(255) DEFAULT 'UTC',
  `last_location_update_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `username`, `password`, `contact_number`, `gender`, `email_verified_at`, `address`, `user_type`, `player_id`, `service_id`, `fleet_id`, `latitude`, `longitude`, `remember_token`, `last_notification_seen`, `status`, `is_online`, `is_available`, `is_verified_driver`, `uid`, `fcm_token`, `display_name`, `login_type`, `timezone`, `last_location_update_at`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'Admin', 'admin@admin.com', 'admin', '$2y$10$v3mThprXjetTBwZYRqnfQefh6y2bsQ4rsHpj2LnrXnZBab6BqVcpu', '+919876543210', NULL, NULL, NULL, 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', 0, 1, 0, NULL, NULL, 'Admin', NULL, 'UTC', NULL, '2022-11-02 06:05:42', NULL),
(2, 'Rahul', 'sahu', 'rahulsa667@gmail.com', 'rahulsa667', '$2y$10$a8pwdBdslsl7O4jc4GIub.NZlqfV6uSvigX4UQEXr.jK6rDRBQtZ2', '+917379891917', NULL, NULL, NULL, 'rider', '4cb9b40b-35d9-4ac2-b2a9-cba8616d1aa3', NULL, NULL, '28.6113486', '77.4560045', NULL, NULL, 'active', 0, 1, 0, NULL, NULL, 'Rahul sahu', NULL, 'UTC', '2024-12-01 16:36:02', '2024-12-01 15:45:09', '2024-12-01 16:36:02'),
(3, 'Danny', 'Chanda', 'dani.legacy101@gmail.com', 'danny', '$2y$10$ELoa9fp53Zc2rV3TAR76quYEIUXbrOivJjoRu5oF7LVwp64I8sPva', '+260966230603', NULL, NULL, NULL, 'rider', 'b4566faf-fae4-4d77-9668-60fd77740fef', NULL, NULL, NULL, NULL, NULL, NULL, 'active', 0, 1, 0, NULL, NULL, 'Danny Chanda', NULL, 'UTC', NULL, '2024-12-01 16:59:27', '2024-12-01 16:59:27'),
(4, 'Rahul', 'Shau', 'rahulsa66@gmail.com', 'ahau', '$2y$10$Yl4vsT48.5//4XvNEU1Ajuz0OUnwYGPaBdjviv1qNp/yKj7eFRQNa', '+26064946895', 'male', NULL, NULL, 'driver', 'afd4bf2b-764a-4122-86e5-b8ac216d7fa6', 1, NULL, NULL, NULL, NULL, NULL, 'active', 0, 1, 1, 'UbNZ66SFhaRU9M7Z0uwMebmhjP33', NULL, 'Rahul Shau', NULL, 'UTC', NULL, '2024-12-01 17:47:59', '2024-12-01 17:55:21'),
(5, 'Rahul', 'Shau', 'rahul@gmail.com', 'sahu21', '$2y$10$y1WjS5siCLQLc4Jkj8bzAuegX0YSoDSv38slt9rmqHx1jf2FcFMiu', '+2602356890', 'male', NULL, NULL, 'driver', 'afd4bf2b-764a-4122-86e5-b8ac216d7fa6', 1, NULL, NULL, NULL, NULL, NULL, 'active', 0, 1, 0, NULL, NULL, 'Rahul Shau', NULL, 'UTC', NULL, '2024-12-01 17:50:46', '2024-12-01 17:53:39'),
(6, 'D', 'C', 'jaykayrides@gmail.com', '007', '$2y$10$wlToUL8aOkxatjBRvyPMTu6eJzE/R4cqXTspiW4Qg6yz.8EO4YgZi', '+260966230606', NULL, NULL, NULL, 'driver', 'e34bbf51-f5a0-4d4c-b0b7-a4e0a0f67ff3', 1, NULL, NULL, NULL, NULL, NULL, 'pending', 0, 1, 0, 'cRIQdV56GrZqpxMgU8OF5dtJ3b33', NULL, 'D C', NULL, 'UTC', NULL, '2024-12-01 19:18:37', '2024-12-01 19:19:51');

-- --------------------------------------------------------

--
-- Table structure for table `user_bank_accounts`
--

CREATE TABLE `user_bank_accounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `bank_code` varchar(255) DEFAULT NULL,
  `account_holder_name` varchar(255) DEFAULT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_bank_accounts`
--

INSERT INTO `user_bank_accounts` (`id`, `user_id`, `bank_name`, `bank_code`, `account_holder_name`, `account_number`, `created_at`, `updated_at`) VALUES
(1, 4, NULL, NULL, NULL, NULL, '2024-12-01 17:53:17', '2024-12-01 17:53:17'),
(2, 5, NULL, NULL, NULL, NULL, '2024-12-01 17:53:39', '2024-12-01 17:53:39');

-- --------------------------------------------------------

--
-- Table structure for table `user_details`
--

CREATE TABLE `user_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `car_model` varchar(255) DEFAULT NULL,
  `car_color` varchar(255) DEFAULT NULL,
  `car_plate_number` varchar(255) DEFAULT NULL,
  `car_production_year` varchar(255) DEFAULT NULL,
  `work_address` text DEFAULT NULL,
  `home_address` text DEFAULT NULL,
  `work_latitude` varchar(255) DEFAULT NULL,
  `work_longitude` varchar(255) DEFAULT NULL,
  `home_latitude` varchar(255) DEFAULT NULL,
  `home_longitude` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_details`
--

INSERT INTO `user_details` (`id`, `user_id`, `car_model`, `car_color`, `car_plate_number`, `car_production_year`, `work_address`, `home_address`, `work_latitude`, `work_longitude`, `home_latitude`, `home_longitude`, `created_at`, `updated_at`) VALUES
(1, 4, 'MK', 'White', '7293783', '2018', NULL, NULL, NULL, NULL, NULL, NULL, '2024-12-01 17:47:59', '2024-12-01 17:47:59'),
(2, 5, 'MK', 'White', '7293783', '2018', NULL, NULL, NULL, NULL, NULL, NULL, '2024-12-01 17:50:46', '2024-12-01 17:50:46'),
(3, 6, 'Toyota', 'White', 'Abc123', '2005', NULL, NULL, NULL, NULL, NULL, NULL, '2024-12-01 19:18:37', '2024-12-01 19:18:37');

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  `online_received` double DEFAULT NULL,
  `collected_cash` double DEFAULT NULL,
  `manual_received` double DEFAULT NULL,
  `total_withdrawn` double DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wallets`
--

INSERT INTO `wallets` (`id`, `user_id`, `total_amount`, `online_received`, `collected_cash`, `manual_received`, `total_withdrawn`, `currency`, `created_at`, `updated_at`) VALUES
(1, 4, 0, NULL, NULL, NULL, NULL, NULL, '2024-12-01 17:47:59', '2024-12-01 17:47:59'),
(2, 5, 0, NULL, NULL, NULL, NULL, NULL, '2024-12-01 17:50:46', '2024-12-01 17:50:46'),
(3, 6, 0, NULL, NULL, NULL, NULL, NULL, '2024-12-01 19:18:37', '2024-12-01 19:18:37');

-- --------------------------------------------------------

--
-- Table structure for table `wallet_histories`
--

CREATE TABLE `wallet_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT 'credit,debit',
  `transaction_type` varchar(255) DEFAULT NULL COMMENT 'credit- ,debit',
  `currency` varchar(255) DEFAULT NULL,
  `amount` double DEFAULT 0,
  `balance` double DEFAULT 0,
  `datetime` datetime DEFAULT NULL,
  `ride_request_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` text DEFAULT NULL,
  `data` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_requests`
--

CREATE TABLE `withdraw_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` double DEFAULT 0,
  `currency` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT 0 COMMENT '0-requested,1-approved,2-decline',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `additional_fees`
--
ALTER TABLE `additional_fees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `app_settings`
--
ALTER TABLE `app_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`id`),
  ADD KEY `complaints_rider_id_foreign` (`rider_id`),
  ADD KEY `complaints_ride_request_id_foreign` (`ride_request_id`);

--
-- Indexes for table `complaint_comments`
--
ALTER TABLE `complaint_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `complaint_comments_complaint_id_foreign` (`complaint_id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `driver_documents`
--
ALTER TABLE `driver_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `driver_documents_driver_id_foreign` (`driver_id`),
  ADD KEY `driver_documents_document_id_foreign` (`document_id`);

--
-- Indexes for table `driver_services`
--
ALTER TABLE `driver_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `driver_services_driver_id_foreign` (`driver_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `media_uuid_unique` (`uuid`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  ADD KEY `media_order_column_index` (`order_column`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_rider_id_foreign` (`rider_id`),
  ADD KEY `payments_ride_request_id_foreign` (`ride_request_id`);

--
-- Indexes for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `regions`
--
ALTER TABLE `regions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviews_rider_id_foreign` (`rider_id`),
  ADD KEY `reviews_ride_request_id_foreign` (`ride_request_id`);

--
-- Indexes for table `ride_requests`
--
ALTER TABLE `ride_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ride_requests_rider_id_foreign` (`rider_id`);

--
-- Indexes for table `ride_request_histories`
--
ALTER TABLE `ride_request_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ride_request_histories_ride_request_id_foreign` (`ride_request_id`);

--
-- Indexes for table `ride_request_ratings`
--
ALTER TABLE `ride_request_ratings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ride_request_ratings_ride_request_id_foreign` (`ride_request_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `services_region_id_foreign` (`region_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sos`
--
ALTER TABLE `sos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sos_region_id_foreign` (`region_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- Indexes for table `user_bank_accounts`
--
ALTER TABLE `user_bank_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_bank_accounts_user_id_foreign` (`user_id`);

--
-- Indexes for table `user_details`
--
ALTER TABLE `user_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wallets_user_id_foreign` (`user_id`);

--
-- Indexes for table `wallet_histories`
--
ALTER TABLE `wallet_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wallet_histories_user_id_foreign` (`user_id`),
  ADD KEY `wallet_histories_ride_request_id_foreign` (`ride_request_id`);

--
-- Indexes for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `withdraw_requests_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `additional_fees`
--
ALTER TABLE `additional_fees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_settings`
--
ALTER TABLE `app_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `complaint_comments`
--
ALTER TABLE `complaint_comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `driver_documents`
--
ALTER TABLE `driver_documents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `driver_services`
--
ALTER TABLE `driver_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `regions`
--
ALTER TABLE `regions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ride_requests`
--
ALTER TABLE `ride_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ride_request_histories`
--
ALTER TABLE `ride_request_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ride_request_ratings`
--
ALTER TABLE `ride_request_ratings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `sos`
--
ALTER TABLE `sos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_bank_accounts`
--
ALTER TABLE `user_bank_accounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_details`
--
ALTER TABLE `user_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `wallet_histories`
--
ALTER TABLE `wallet_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_ride_request_id_foreign` FOREIGN KEY (`ride_request_id`) REFERENCES `ride_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `complaints_rider_id_foreign` FOREIGN KEY (`rider_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `complaint_comments`
--
ALTER TABLE `complaint_comments`
  ADD CONSTRAINT `complaint_comments_complaint_id_foreign` FOREIGN KEY (`complaint_id`) REFERENCES `complaints` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `driver_documents`
--
ALTER TABLE `driver_documents`
  ADD CONSTRAINT `driver_documents_document_id_foreign` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `driver_documents_driver_id_foreign` FOREIGN KEY (`driver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `driver_services`
--
ALTER TABLE `driver_services`
  ADD CONSTRAINT `driver_services_driver_id_foreign` FOREIGN KEY (`driver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ride_request_id_foreign` FOREIGN KEY (`ride_request_id`) REFERENCES `ride_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `payments_rider_id_foreign` FOREIGN KEY (`rider_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ride_request_id_foreign` FOREIGN KEY (`ride_request_id`) REFERENCES `ride_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_rider_id_foreign` FOREIGN KEY (`rider_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ride_requests`
--
ALTER TABLE `ride_requests`
  ADD CONSTRAINT `ride_requests_rider_id_foreign` FOREIGN KEY (`rider_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ride_request_histories`
--
ALTER TABLE `ride_request_histories`
  ADD CONSTRAINT `ride_request_histories_ride_request_id_foreign` FOREIGN KEY (`ride_request_id`) REFERENCES `ride_requests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ride_request_ratings`
--
ALTER TABLE `ride_request_ratings`
  ADD CONSTRAINT `ride_request_ratings_ride_request_id_foreign` FOREIGN KEY (`ride_request_id`) REFERENCES `ride_requests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_region_id_foreign` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sos`
--
ALTER TABLE `sos`
  ADD CONSTRAINT `sos_region_id_foreign` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_bank_accounts`
--
ALTER TABLE `user_bank_accounts`
  ADD CONSTRAINT `user_bank_accounts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wallets`
--
ALTER TABLE `wallets`
  ADD CONSTRAINT `wallets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wallet_histories`
--
ALTER TABLE `wallet_histories`
  ADD CONSTRAINT `wallet_histories_ride_request_id_foreign` FOREIGN KEY (`ride_request_id`) REFERENCES `ride_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `wallet_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  ADD CONSTRAINT `withdraw_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
