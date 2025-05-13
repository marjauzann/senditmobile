-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 19, 2024 at 12:31 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sendit_v2`
--

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
(45, '2014_10_12_000000_create_users_table', 1),
(46, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(47, '2019_08_19_000000_create_failed_jobs_table', 1),
(48, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(49, '2024_12_11_031046_create_pemesanans_table', 1),
(50, '2024_12_11_031105_create_payments_table', 1),
(51, '2024_12_15_193850_add_no_hp_penerima_to_pemesanans_table', 2),
(52, '2024_12_15_194150_add_jenis_paket_to_pemesanans_table', 3),
(53, '2024_12_15_194409_add_keterangan_to_pemesanans_table', 4),
(54, '2024_12_15_200225_add_nama_pengirim_to_pemesanans_table', 5),
(55, '2024_12_15_201110_add_no_hp_pengirim_to_pemesanans_table', 6),
(56, '2024_12_17_024010_add_api_token_to_users_table', 7),
(57, '2024_12_17_053358_add_price_and_payment_method_to_pemesanans_table', 8),
(58, '2024_12_17_054639_add_price_and_payment_method_to_pemesanans_table', 9);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id_payment` bigint(20) UNSIGNED NOT NULL,
  `metode_pembayaran` varchar(255) NOT NULL,
  `id_user` bigint(20) UNSIGNED NOT NULL,
  `harga` bigint(20) NOT NULL,
  `id_pemesanan` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id_payment`, `metode_pembayaran`, `id_user`, `harga`, `id_pemesanan`, `created_at`, `updated_at`) VALUES
(1, 'Transfer Bank', 1, 100000, 1, '2024-12-11 03:41:13', '2024-12-11 03:41:13'),
(2, 'OVO', 2, 150000, 2, '2024-12-11 03:41:13', '2024-12-11 03:41:13'),
(3, 'GoPay', 1, 200000, 3, '2024-12-11 03:41:13', '2024-12-11 03:41:13'),
(4, 'Dana', 2, 50000, 4, '2024-12-11 03:41:13', '2024-12-11 03:41:13'),
(5, 'Cash', 1, 120000, 5, '2024-12-11 03:41:13', '2024-12-11 03:41:13');

-- --------------------------------------------------------

--
-- Table structure for table `pemesanans`
--

CREATE TABLE `pemesanans` (
  `id_pemesanan` bigint(20) UNSIGNED NOT NULL,
  `id_user` bigint(20) UNSIGNED NOT NULL,
  `jarak` int(11) NOT NULL,
  `lokasi_jemput` varchar(255) NOT NULL,
  `lokasi_tujuan` varchar(255) NOT NULL,
  `status` enum('On Progress','Selesai') NOT NULL DEFAULT 'On Progress',
  `nama_penerima` varchar(255) NOT NULL,
  `id_kurir` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `no_hp_penerima` varchar(15) DEFAULT NULL,
  `jenis_paket` varchar(255) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `nama_pengirim` varchar(255) DEFAULT NULL,
  `no_hp_pengirim` varchar(255) DEFAULT NULL,
  `total_harga` decimal(10,2) DEFAULT NULL,
  `metode_pembayaran` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pemesanans`
--

INSERT INTO `pemesanans` (`id_pemesanan`, `id_user`, `jarak`, `lokasi_jemput`, `lokasi_tujuan`, `status`, `nama_penerima`, `id_kurir`, `created_at`, `updated_at`, `no_hp_penerima`, `jenis_paket`, `keterangan`, `nama_pengirim`, `no_hp_pengirim`, `total_harga`, `metode_pembayaran`) VALUES
(1, 1, 10, 'Jl. Merdeka', 'Jl. Mangga', 'On Progress', 'Ahmad', 3, '2024-12-11 03:41:10', '2024-12-11 03:41:10', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 2, 15, 'Jl. Kuningan', 'Jl. Apel', 'On Progress', 'Siti', 4, '2024-12-11 03:41:10', '2024-12-11 03:41:10', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 1, 20, 'Jl. Merdeka', 'Jl. Rambutan', 'Selesai', 'Fajar', 3, '2024-12-11 03:41:10', '2024-12-11 03:41:10', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 2, 5, 'Jl. Kuningan', 'Jl. Durian', 'Selesai', 'Rina', 4, '2024-12-11 03:41:10', '2024-12-11 03:41:10', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 1, 12, 'Jl. Merdeka', 'Jl. Pisang', 'On Progress', 'Putri', 3, '2024-12-11 03:41:10', '2024-12-11 03:41:10', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 1, 10, 'a', 'a', 'On Progress', 'Tes A', 3, '2024-12-15 12:33:22', '2024-12-15 12:33:22', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 1, 10, 'tes2', 'tes2', 'On Progress', 'Tes A', 3, '2024-12-15 12:40:32', '2024-12-15 12:40:32', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 1, 10, 'tes', 'tes', 'On Progress', 'Tes A', 3, '2024-12-15 12:42:38', '2024-12-15 12:42:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 1, 10, 'tes2', 'tes2', 'On Progress', 'Tes A', 3, '2024-12-15 13:00:58', '2024-12-15 13:00:58', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 1, 10, 'cek3', 'cek3', 'On Progress', 'Tes A', 3, '2024-12-15 13:09:14', '2024-12-15 13:09:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 1, 10, 'tesdee', 'tesdee', 'On Progress', 'awaw', 3, '2024-12-15 13:11:56', '2024-12-19 01:14:32', '1234211231', 'Lainnya', 'ceawea', 'tess3', '4123123123', NULL, NULL),
(12, 1, 10, 'Cimahi', 'Bojongsoang', 'On Progress', 'Tes A', 3, '2024-12-15 13:18:24', '2024-12-15 13:18:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 1, 10, 'Cimahi', 'Bojongsoang', 'On Progress', 'Nizar', 3, '2024-12-15 13:18:33', '2024-12-15 13:18:57', '081322314912', 'Lainnya', 'Mantap', 'Marjauza Naswansyah', '081311181888', NULL, NULL),
(14, 1, 10, 'Jl. Contoh 1', 'Jl. Contoh 2', 'On Progress', 'John Doe', 2, '2024-12-16 22:48:40', '2024-12-19 03:00:16', '08123456789', 'Dokumen', 'Segera', 'Jane Doe', '08987654321', 150000.00, 'Transfer Bank'),
(15, 1, 10, 'mantap', 'tes2', 'On Progress', 'asdwae', 3, '2024-12-19 02:41:58', '2024-12-19 02:42:16', '2312312323', 'Buku', 'cek', 'cekcek', '1231223232', NULL, NULL),
(16, 1, 10, 'margaasih', 'kopo', 'On Progress', 'matthew', 3, '2024-12-19 03:08:42', '2024-12-19 03:09:08', '081329912831', 'Lainnya', 'obat', 'marjauza n', '081311181822', 45000.00, 'QRIS'),
(17, 1, 10, 'fixbener', 'fix', 'On Progress', 'fix2', 3, '2024-12-19 03:15:11', '2024-12-19 03:16:06', '088211232241', 'Lainnya', 'obat', 'fix1', '081322412222', 60000.00, 'Cash'),
(18, 1, 10, 'fix2', 'fix2', 'On Progress', 'Tes A', 3, '2024-12-19 03:22:00', '2024-12-19 03:22:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 1, 10, 'bismillahfix', 'bismillahfix', 'On Progress', 'semoga', 3, '2024-12-19 03:27:35', '2024-12-19 03:27:55', '88881112312', 'Obat-obatan', 'Obat-obatan', 'bismil', '8888111222', 45000.00, 'OVO'),
(20, 1, 10, 'udah', 'udah', 'On Progress', 'udah1', 3, '2024-12-19 03:43:23', '2024-12-19 03:45:08', '2222222222', 'Buku', 'Buku', 'udah1', '091231213121', 60000.00, 'OVO'),
(21, 1, 10, 'ges', 'ges', 'On Progress', 'ges2', 3, '2024-12-19 03:46:47', '2024-12-19 03:49:03', '1231231231', 'Lainnya', 'yaudah', 'ges', '1231231231', 45000.00, 'Cash'),
(22, 1, 10, 'udahinimah', 'udah', 'On Progress', 'dah5', 3, '2024-12-19 03:56:05', '2024-12-19 03:58:50', '1231241231', 'Lainnya', 'yes udh', 'dah4', '0912312312', 60000.00, 'Dana'),
(23, 1, 10, 'sudah', 'sudah', 'On Progress', 'sudah8', 3, '2024-12-19 04:21:36', '2024-12-19 04:21:56', '0123123121', 'Baju', 'Baju', 'sudah7', '0812312312', 60000.00, 'GoPay');

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
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(255) NOT NULL,
  `alamat` text NOT NULL,
  `no_hp` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `role` enum('admin','kurir','pemesan') NOT NULL DEFAULT 'pemesan',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `api_token` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `nama`, `alamat`, `no_hp`, `email`, `username`, `password`, `email_verified_at`, `remember_token`, `role`, `created_at`, `updated_at`, `api_token`) VALUES
(1, 'Andi Wijaya', 'Jl. Merdeka No.1', '081234567890', 'andi@gmail.com', 'andiwijaya', 'password123', NULL, NULL, 'pemesan', '2024-12-11 03:41:04', '2024-12-11 03:41:04', NULL),
(2, 'Budi Santoso', 'Jl. Kuningan No.2', '081298765432', 'budi@gmail.com', 'budisantoso', 'password456', NULL, NULL, 'pemesan', '2024-12-11 03:41:04', '2024-12-11 03:41:04', NULL),
(3, 'Citra Dewi', 'Jl. Sudirman No.3', '082123456789', 'citra@gmail.com', 'citradewi', 'password789', NULL, NULL, 'kurir', '2024-12-11 03:41:04', '2024-12-11 03:41:04', NULL),
(4, 'Dani Pratama', 'Jl. Thamrin No.4', '083123456780', 'dani@gmail.com', 'danipratama', 'password012', NULL, NULL, 'kurir', '2024-12-11 03:41:04', '2024-12-11 03:41:04', NULL),
(5, 'Eka Sari', 'Jl. Gatot Subroto No.5', '084123456781', 'eka@gmail.com', 'ekasari', 'password345', NULL, NULL, 'admin', '2024-12-11 03:41:04', '2024-12-11 03:41:04', NULL),
(6, 'naswan', '123 Main St', '08123456789', 'naswan@gmail.com', 'naswan', '$2y$12$rOn9ul3GCpzXlMdHaPF0EuqAt15STnRzKUhWxzy6KcmzReEj2qa.e', NULL, NULL, 'admin', '2024-12-16 19:50:42', '2024-12-19 02:07:20', '1mj8Q77Syjw4eZFqE3sSluLM3akKh0JvzEDGfLBAUp8POCtUhZlQyLzS1aTS'),
(7, 'hasan', 'jl hasan', '081231231231', 'hasan@gmail.com', 'hasan', '$2y$12$AyX/Lls8S.qBmG2aceSwxORniciSDdNDFJizqMjKDPySqEC3u038O', NULL, NULL, 'admin', '2024-12-16 20:32:03', '2024-12-19 01:52:04', 'AU5VPj8hv7Ne4IqLn6K3AFNpkgrB4ju6xXZXMymt0WH5wTzQEDofFFugHGLD'),
(8, 'amar', 'jl maar 1', '081311124412', 'amar@gmail.com', 'amar', '$2y$12$cqwDacj2DMlcPBCANY/SPegW7tsuuAbKddyMnnQkP8etLstlS48YC', NULL, NULL, 'admin', '2024-12-19 01:53:41', '2024-12-19 01:53:48', '4cOMWoPNPMT223oXwnbrKie5lWRQbrYQdshJcyLhNuJ2Td4jSkMnGkumlsNS'),
(9, 'ujang', 'jl ujang 2', '081344215521', 'ujang@gmail.com', 'ujang', '$2y$12$NwGR/ge9cjSIRMZn1TulIuC2ol7SSvQnFerkzz7fyJj/sWrNLjcZC', NULL, NULL, 'admin', '2024-12-19 01:56:18', '2024-12-19 01:56:37', 'TBLhuCBoG2RaNWrsJVthu00Pq0uXTP9vo3EEPmWK4Pugsx5mOJF1KvdwZB2h'),
(10, 'mamat', 'jl mamat 1', '081311121141', 'mamat@gmail.com', 'mamat', '$2y$12$qR.q3xs8Bxc4sAJZvETqju4hRWvef4TK6f/ssnpampsQHjkOn0cXm', NULL, NULL, 'admin', '2024-12-19 02:05:23', '2024-12-19 02:05:35', 'xu80rTPobinbRUfWNv5KnsDf4YSpDlOLWShC0dCx2shtJLFHnDVz445cHvhr'),
(11, 'teslagi', 'jl teslagi 1', '0813224111', 'teslagi@gmail.com', 'teslagi', '$2y$12$L7ZgxrKFWTG08fY7ttH5Qe/ePKROvtHFuYuhB1R9m4mN8gendRLS.', NULL, NULL, 'admin', '2024-12-19 02:15:46', '2024-12-19 02:15:59', 'RPsw1e6ru2cyblfWOjdQWjLOTf15opTwWDdVi20cp0hEzX2wfo0e75rt7zMa');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id_payment`),
  ADD KEY `payments_id_user_foreign` (`id_user`),
  ADD KEY `payments_id_pemesanan_foreign` (`id_pemesanan`);

--
-- Indexes for table `pemesanans`
--
ALTER TABLE `pemesanans`
  ADD PRIMARY KEY (`id_pemesanan`),
  ADD KEY `pemesanans_id_user_foreign` (`id_user`),
  ADD KEY `pemesanans_id_kurir_foreign` (`id_kurir`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_api_token_unique` (`api_token`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id_payment` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pemesanans`
--
ALTER TABLE `pemesanans`
  MODIFY `id_pemesanan` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_id_pemesanan_foreign` FOREIGN KEY (`id_pemesanan`) REFERENCES `pemesanans` (`id_pemesanan`) ON DELETE CASCADE,
  ADD CONSTRAINT `payments_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

--
-- Constraints for table `pemesanans`
--
ALTER TABLE `pemesanans`
  ADD CONSTRAINT `pemesanans_id_kurir_foreign` FOREIGN KEY (`id_kurir`) REFERENCES `users` (`id_user`) ON DELETE CASCADE,
  ADD CONSTRAINT `pemesanans_id_user_foreign` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
