-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Hazırlanma Vaxtı: 31 Okt, 2019 saat 14:56
-- Server versiyası: 10.1.28-MariaDB
-- PHP Versiyası: 7.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Verilənlər Bazası: `testdb`
--

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `_admins`
--

CREATE TABLE `_admins` (
  `admin_id` bigint(20) UNSIGNED NOT NULL,
  `admin_username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Sxemi çıxarılan cedvel `_admins`
--

INSERT INTO `_admins` (`admin_id`, `admin_username`, `admin_password`, `admin_status`, `admin_token`, `created_at`) VALUES
(1, 'kenan@gmail.com', '00a1f187721c63501356bf791e69382c', 'active', '874851e0399b17af36ea97b6c72d12a7d6def0c6cde4a977ba0bd38508f627735b8e26c66bdaf52eb8cdb7801d50bb0e8edd1fd7d5ec03176b404da543d086eb', '2019-10-31 07:02:40');

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `_categories`
--

CREATE TABLE `_categories` (
  `cat_id` int(11) NOT NULL,
  `cat_name` varchar(50) NOT NULL,
  `image` varchar(255) NOT NULL,
  `cat_status` int(11) NOT NULL DEFAULT '1',
  `subcategory_id` text NOT NULL,
  `created_id` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Sxemi çıxarılan cedvel `_categories`
--

INSERT INTO `_categories` (`cat_id`, `cat_name`, `image`, `cat_status`, `subcategory_id`, `created_id`, `updated_at`, `deleted_at`) VALUES
(1, 'test1', '', 1, '[1,2,3]', '2019-10-25 09:51:03', NULL, NULL),
(2, 'test2', '', 1, '[4,5,6]', '2019-10-25 09:51:03', NULL, NULL),
(3, 'test3', '', 1, '[7,8]', '2019-10-25 09:51:03', NULL, NULL),
(4, 'test4', '', 1, '[9,10]', '2019-10-25 09:51:03', NULL, NULL),
(5, 'test5', '', 1, 'null', '2019-10-25 09:51:03', NULL, NULL);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `_chats`
--

CREATE TABLE `_chats` (
  `chat_id` int(11) NOT NULL,
  `chat_sender_id` int(11) NOT NULL,
  `chat_text` text NOT NULL,
  `chat_sender_to` int(11) NOT NULL,
  `chat_sender_type` varchar(11) NOT NULL,
  `chat_send_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `chat_viewed_at` timestamp NULL DEFAULT NULL,
  `chat_deleted_at` timestamp NULL DEFAULT NULL,
  `chat_file_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Sxemi çıxarılan cedvel `_chats`
--

INSERT INTO `_chats` (`chat_id`, `chat_sender_id`, `chat_text`, `chat_sender_to`, `chat_sender_type`, `chat_send_at`, `chat_viewed_at`, `chat_deleted_at`, `chat_file_path`) VALUES
(1, 1, 'vhgjuohsciodhvoisdnhvuiosdnhvuiosnhd', 14, 'editor', '2019-10-25 15:33:15', '2019-10-26 05:01:51', NULL, NULL),
(2, 1, 'vhgjuohsciodhvoisdnhvuiosdnhvuiosnhd', 14, 'editor', '2019-10-25 15:33:15', '2019-10-26 05:01:51', NULL, NULL),
(3, 14, 'vhgjuohsciodhvoisdnhvuiosdnhvuiosnhd', 1, 'user', '2019-10-25 15:33:15', NULL, NULL, NULL),
(4, 1, 'demo test', 17, 'editor', '2019-10-26 09:29:13', '2019-10-26 05:34:30', NULL, NULL);

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `_sub_categories`
--

CREATE TABLE `_sub_categories` (
  `subcategory_id` int(11) NOT NULL,
  `subcategory_name` varchar(50) NOT NULL,
  `subcategory_type` varchar(20) NOT NULL DEFAULT 'money_out',
  `elements` text NOT NULL,
  `image` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Sxemi çıxarılan cedvel `_sub_categories`
--

INSERT INTO `_sub_categories` (`subcategory_id`, `subcategory_name`, `subcategory_type`, `elements`, `image`, `description`) VALUES
(1, 'webmoney', 'money_in', '[{\"type\":\"input\", \"placeholder\": \"Prefix\",\"value\": \"\", \"info\": \"\"}]', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', 'wsdfsfasf'),
(2, 'bonuspay', 'money_in', '[{\"type\":\"input\", \"placeholder\": \"Prefix\",\"value\": \"\", \"info\": \"\"}]', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', 'asf'),
(3, 'demo3', 'money_out', '[{\"type\":\"input\", \"placeholder\": \"Prefix\",\"value\": \"\", \"info\": \"\"}]', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', 'sdfsdf'),
(4, 'demo4', 'money_in', '[{\"type\":\"input\", \"placeholder\": \"Amount\",\"value\": \"\", \"info\": \"\"},{\"type\":\"select\",\"placeholder\": \"Prefix\",\"value\": \"\", \"inside\" : [{\"key\": \"0\", \"value\":\"055\"}, {\"key\":\"\",\"value\":\"\"}]}]', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', 'sdfsdf'),
(5, 'demo5', 'money_out', '[{\"type\":\"input\", \"placeholder\": \"Amount\",\"value\": \"\", \"info\": \"\"},{\"type\":\"select\",\"placeholder\": \"Prefix\",\"value\": \"\", \"inside\" : [{\"key\": \"0\", \"value\":\"055\"}, {\"key\":\"\",\"value\":\"\"}]}]', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', 'sdfsdf'),
(6, 'demo6', 'money_out', '[{\"type\":\"input\", \"placeholder\": \"Amount\",\"value\": \"\", \"info\": \"\"},{\"type\":\"select\",\"placeholder\": \"Prefix\",\"value\": \"\", \"inside\" : [{\"key\": \"0\", \"value\":\"055\"}, {\"key\":\"\",\"value\":\"\"}]}]', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', 'sdfsd'),
(7, 'demo7', 'money_out', '[{\"type\":\"input\", \"placeholder\": \"Amount\",\"value\": \"\", \"info\": \"\"},{\"type\":\"select\",\"placeholder\": \"Prefix\",\"value\": \"\",\"info\": \"\",\"inside\" : [{\"key\": \"0\", \"value\":\"055\"}, {\"key\":\"\",\"value\":\"\"}]}]', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', 'sdf'),
(8, 'demo8', 'money_out', '[{\"type\":\"input\", \"placeholder\": \"Amount\",\"value\": \"\", \"info\": \"\"},{\"type\":\"select\",\"placeholder\": \"Prefix\",\"value\": \"\", \"inside\" : [{\"key\": \"0\", \"value\":\"055\"}, {\"key\":\"\",\"value\":\"\"}]}]', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', 'sdf'),
(9, 'demo9', 'money_out', '[{\"type\":\"input\", \"placeholder\": \"Amount\",\"value\": \"1234567\", \"info\": \"\"},{\"type\":\"input\", \"placeholder\": \"Amount\",\"value\": \"\", \"info\": \"\"},{\"type\":\"select\",\"placeholder\": \"Prefix\",\"value\": \"\",\"info\": \"\",\"inside\" : [{\"key\": \"0\", \"value\":\"055\"}, {\"key\":\"\",\"value\":\"\"}]}]', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', 'sdf'),
(10, 'demo10', 'money_out', '[{\"type\":\"input\",\"name\":\"key\", \"placeholder\": \"Amount\",\"value\": \"12345567dfv\", \"info\": \"\"},{\"type\":\"select\",\"placeholder\": \"Prefix\",\"value\": \"\",\"info\": \"\",\"inside\" : [{\"key\": \"0\", \"value\":\"055\"}, {\"key\":\"\",\"value\":\"\"}]}]', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', 'sdf');

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `_transactions`
--

CREATE TABLE `_transactions` (
  `transaction_id` int(11) NOT NULL,
  `transaction_user_id` int(11) NOT NULL,
  `transaction_number` varchar(255) NOT NULL,
  `transaction_type` varchar(15) NOT NULL,
  `transaction_status` varchar(11) NOT NULL DEFAULT 'Pending',
  `transaction_category_id` int(11) NOT NULL,
  `transaction_amount` float(10,2) NOT NULL,
  `transaction_title` varchar(255) NOT NULL,
  `transaction_description` varchar(255) NOT NULL,
  `transaction_icon` varchar(255) NOT NULL,
  `transaction_elements` text NOT NULL,
  `transaction_currency` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Sxemi çıxarılan cedvel `_transactions`
--

INSERT INTO `_transactions` (`transaction_id`, `transaction_user_id`, `transaction_number`, `transaction_type`, `transaction_status`, `transaction_category_id`, `transaction_amount`, `transaction_title`, `transaction_description`, `transaction_icon`, `transaction_elements`, `transaction_currency`, `created_at`) VALUES
(1, 14, '7781572011977', 'money_out', 'success', 2, 10.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"10.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-25 13:59:37'),
(2, 14, '6711572012212', 'money_out', 'success', 2, 10.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"10.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-25 14:03:32'),
(3, 17, '5251572086815', 'money_in', 'deleted', 2, 10.55, 'demo2', '123456432', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"10.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 10:46:55'),
(4, 17, '9561572087253', 'money_out', 'deleted', 2, 10.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"10.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 10:54:13'),
(5, 17, '1871572089330', 'money_out', 'pending', 2, 10.55, 'demo2', '1wefaefdfg werterger t345ty erg ery5  he', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"10.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:28:50'),
(6, 17, '7781572089351', 'money_out', 'deleted', 2, 10.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"10.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:29:11'),
(7, 17, '8001572089395', 'money_out', 'deleted', 2, 10.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"10.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:29:55'),
(8, 17, '9891572089409', 'money_out', 'deleted', 2, 10.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"10.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:30:09'),
(9, 17, '1321572089502', 'money_out', 'deleted', 2, 10.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"10.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:31:42'),
(10, 17, '2291572089510', 'money_out', 'deleted', 2, 10.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"10.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:31:50'),
(11, 17, '6951572089530', 'money_out', 'deleted', 2, 4.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"4.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:32:10'),
(12, 17, '1231572089573', 'money_out', 'deleted', 2, 4.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"4.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:32:53'),
(13, 17, '4631572089583', 'money_out', 'success', 2, 4.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"4.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:33:03'),
(14, 17, '9881572089643', 'money_out', 'success', 2, 4.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"4.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:34:03'),
(15, 17, '1531572089695', 'money_out', 'success', 2, 4.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"4.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:34:55'),
(16, 17, '5341572089708', 'money_out', 'success', 2, 4.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"4.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:35:08'),
(17, 17, '5851572089847', 'money_out', 'success', 2, 4.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"4.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:37:27'),
(18, 17, '8651572089854', 'money_out', 'success', 2, 4.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"4.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:37:34'),
(19, 17, '2171572089898', 'money_out', 'success', 2, 4.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"4.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:38:18'),
(20, 17, '801572089909', 'money_out', 'success', 2, 4.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"4.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:38:29'),
(21, 17, '7331572090006', 'money_out', 'success', 2, 4.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"4.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:40:06'),
(22, 17, '1201572090012', 'money_out', 'success', 2, 4.55, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"4.55\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:40:12'),
(23, 17, '5111572090030', 'money_out', 'success', 2, 3.56, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"3.56\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:40:30'),
(24, 17, '6031572090057', 'money_out', 'success', 2, 3.56, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"3.56\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:40:57'),
(25, 17, '3411572090068', 'money_out', 'success', 2, 3.56, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"3.56\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:41:08'),
(26, 17, '8411572090110', 'money_out', 'success', 2, 3.56, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"3.56\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:41:50'),
(27, 17, '131572090258', 'money_out', 'success', 2, 3.56, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"3.56\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:44:18'),
(28, 17, '1721572090259', 'money_out', 'success', 2, 3.56, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"3.56\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:44:19'),
(29, 17, '2151572090260', 'money_out', 'success', 2, 3.56, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"3.56\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:44:20'),
(30, 17, '6231572090261', 'money_out', 'success', 2, 3.56, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"3.56\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:44:21'),
(31, 17, '5061572090262', 'money_out', 'success', 2, 3.56, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"3.56\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:44:22'),
(32, 17, '271572090262', 'money_out', 'success', 2, 3.56, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"3.56\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:44:22'),
(33, 17, '8151572090268', 'money_out', 'success', 2, 1234.56, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"1234.56\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:44:28'),
(34, 17, '7611572090280', 'money_in', 'success', 2, 1334234.50, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"1334234.56\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:44:40'),
(35, 17, '5321572090308', 'money_in', 'success', 2, 8334234.50, 'demo2', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"amount\",\"placeholder\":\"Amount\",\"value\":\"8334234.56\",\"info\":null},{\"type\":\"select\",\"name\":\"prefix\",\"placeholder\":\"Prefix\",\"value\":null,\"info\":null,\"inside\":[{\"key\":\"0\",\"value\":\"055\"},{\"key\":null,\"value\":null}]}]', 'ruble', '2019-10-26 11:45:08'),
(36, 18, '2751572099121', 'money_in', 'deleted', 2, 0.00, 'bonuspay', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"key\",\"placeholder\":\"Bonuspay key\",\"value\":\"123456\",\"info\":null},{\"type\":\"input\",\"name\":\"description\",\"placeholder\":\"Description\",\"value\":\"dbdfndfgndfgndfgn\",\"info\":null}]', 'ruble', '2019-10-26 14:12:01'),
(37, 18, '991572099178', 'money_in', 'success', 2, 0.00, 'bonuspay', 'asfsdvsdvsdvsdv', 'https://halberdbastion.com/sites/default/files/styles/medium/public/2018-04/azercell-azerbaijan-logo.png?itok=aeSjtuaG', '[{\"type\":\"input\",\"name\":\"key\",\"placeholder\":\"Bonuspay key\",\"value\":\"123456\",\"info\":null},{\"type\":\"input\",\"name\":\"description\",\"placeholder\":\"Description\",\"value\":\"dbdfndfgndfgndfgn\",\"info\":null}]', 'ruble', '2019-10-26 14:12:58');

-- --------------------------------------------------------

--
-- Cədvəl üçün cədvəl strukturu `_users`
--

CREATE TABLE `_users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_username` varchar(255) NOT NULL,
  `user_surname` varchar(255) NOT NULL,
  `user_balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `user_email` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_token` varchar(255) DEFAULT NULL,
  `user_gender` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_verify_code` varchar(6) DEFAULT NULL,
  `user_status` varchar(15) NOT NULL DEFAULT 'disabled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Sxemi çıxarılan cedvel `_users`
--

INSERT INTO `_users` (`user_id`, `user_name`, `user_username`, `user_surname`, `user_balance`, `user_email`, `user_password`, `user_token`, `user_gender`, `created_at`, `updated_at`, `user_verify_code`, `user_status`) VALUES
(12, 'jafar', 'jabbarlijafawdw2r', 'jabbarli', '72.25', 'jabbarli2@gmail.com', '25d55ad283aa400af464c76d713c07ad', NULL, 0, '2019-10-24 12:15:02', NULL, '472448', 'deleted'),
(17, 'Kenan', 'kenanAbilzade', 'Abilzade', '330134.28', 'kenanabilzade27@gmail.com', '150920ccedc34d24031cdd3711e43310', '7afe3a0e52637483176bede1b4bb64205514836235049c34f19256e2d551aba7abb474c3c18cfa4845a67133527195ac096fd4c25309983d1732a5357a2ecb9c', 1, '2019-10-26 09:25:44', NULL, '199379', 'active'),
(18, 'Samir', 'Samirhasanli', 'Hesenlee', '0.00', 'djeffcbbrl@gmail.com', 'c8837b23ff8aaa8a2dde915473ce0991', '0466ba4aa251f52829b9179a21285b230fd932beb875748c95b5bd11c9dbb7a6d1a73a2d91b67efe9b1bd419490f03fe7254f39fcda676eeb6f0ceb5208bb94f', 1, '2019-10-26 13:46:37', NULL, '905377', 'waiting');

--
-- Indexes for dumped tables
--

--
-- Cədvəl üçün indekslər `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Cədvəl üçün indekslər `_admins`
--
ALTER TABLE `_admins`
  ADD PRIMARY KEY (`admin_id`);

--
-- Cədvəl üçün indekslər `_categories`
--
ALTER TABLE `_categories`
  ADD PRIMARY KEY (`cat_id`);

--
-- Cədvəl üçün indekslər `_chats`
--
ALTER TABLE `_chats`
  ADD PRIMARY KEY (`chat_id`);

--
-- Cədvəl üçün indekslər `_sub_categories`
--
ALTER TABLE `_sub_categories`
  ADD PRIMARY KEY (`subcategory_id`);

--
-- Cədvəl üçün indekslər `_transactions`
--
ALTER TABLE `_transactions`
  ADD PRIMARY KEY (`transaction_id`),
  ADD UNIQUE KEY `transaction_number` (`transaction_number`),
  ADD KEY `transaction_category_id` (`transaction_category_id`);

--
-- Cədvəl üçün indekslər `_users`
--
ALTER TABLE `_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email` (`user_email`),
  ADD UNIQUE KEY `user_username` (`user_username`),
  ADD UNIQUE KEY `user_token` (`user_token`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- Cədvəl üçün AUTO_INCREMENT `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Cədvəl üçün AUTO_INCREMENT `_admins`
--
ALTER TABLE `_admins`
  MODIFY `admin_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Cədvəl üçün AUTO_INCREMENT `_categories`
--
ALTER TABLE `_categories`
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Cədvəl üçün AUTO_INCREMENT `_chats`
--
ALTER TABLE `_chats`
  MODIFY `chat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Cədvəl üçün AUTO_INCREMENT `_sub_categories`
--
ALTER TABLE `_sub_categories`
  MODIFY `subcategory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Cədvəl üçün AUTO_INCREMENT `_transactions`
--
ALTER TABLE `_transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- Cədvəl üçün AUTO_INCREMENT `_users`
--
ALTER TABLE `_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
