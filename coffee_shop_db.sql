-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2025-11-26 17:27:26
-- 伺服器版本： 10.4.32-MariaDB
-- PHP 版本： 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `coffee_shop_db`
--

-- --------------------------------------------------------

--
-- 資料表結構 `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_number` varchar(20) DEFAULT NULL,
  `customer_phone` varchar(20) NOT NULL,
  `product_details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`product_details`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `orders`
--

INSERT INTO `orders` (`id`, `order_number`, `customer_phone`, `product_details`, `created_at`) VALUES
(2, 'BN39382833', '16975485', '[{\"id\":\"2\",\"name\":\"Colombia Huila\",\"image\":\"default.jpg\",\"price\":140,\"quantity\":5},{\"id\":\"5\",\"name\":\"Sumatra Mandheling\",\"image\":\"default.jpg\",\"price\":145,\"quantity\":6}]', '2025-11-21 07:36:22'),
(3, 'BN39608071', '12345678', '[{\"id\":\"2\",\"name\":\"Colombia Huila\",\"image\":\"default.jpg\",\"price\":140,\"quantity\":4},{\"id\":\"3\",\"name\":\"Guatemala Antigua\",\"image\":\"default.jpg\",\"price\":150,\"quantity\":3}]', '2025-11-21 07:40:08'),
(4, 'BN20251121WSNTN0VY', '15935485', '[{\"id\":\"2\",\"name\":\"Colombia Huila\",\"image\":\"default.jpg\",\"price\":140,\"quantity\":7},{\"id\":\"5\",\"name\":\"Sumatra Mandheling\",\"image\":\"default.jpg\",\"price\":145,\"quantity\":5},{\"id\":\"3\",\"name\":\"Guatemala Antigua\",\"image\":\"default.jpg\",\"price\":150,\"quantity\":4}]', '2025-11-21 07:53:57'),
(5, 'BN2025112123WDGZAC', '12345678', '[{\"id\":\"2\",\"name\":\"Colombia Huila\",\"image\":\"default.jpg\",\"price\":140,\"quantity\":14},{\"id\":\"5\",\"name\":\"Sumatra Mandheling\",\"image\":\"default.jpg\",\"price\":145,\"quantity\":5},{\"id\":\"3\",\"name\":\"Guatemala Antigua\",\"image\":\"default.jpg\",\"price\":150,\"quantity\":4}]', '2025-11-21 07:54:17'),
(6, 'BN40495948', '12345678', '[{\"id\":\"2\",\"name\":\"Colombia Huila\",\"image\":\"default.jpg\",\"price\":140,\"quantity\":14},{\"id\":\"5\",\"name\":\"Sumatra Mandheling\",\"image\":\"default.jpg\",\"price\":145,\"quantity\":5},{\"id\":\"3\",\"name\":\"Guatemala Antigua\",\"image\":\"default.jpg\",\"price\":150,\"quantity\":4}]', '2025-11-21 07:54:55'),
(7, 'BN40732443', '234567890', '[{\"id\":\"1\",\"name\":\"Yirgacheffe G1 Ethiopia\",\"image\":\"default.jpg\",\"price\":160,\"quantity\":9},{\"id\":\"2\",\"name\":\"Colombia Huila\",\"image\":\"default.jpg\",\"price\":140,\"quantity\":4},{\"id\":\"3\",\"name\":\"Guatemala Antigua\",\"image\":\"default.jpg\",\"price\":150,\"quantity\":5}]', '2025-11-21 07:58:52'),
(8, 'BN202511269DE46A3D', '12345678', '[{\"id\":\"1\",\"name\":\"Test Product\",\"price\":\"100.00\",\"qty\":1}]', '2025-11-26 10:14:54'),
(9, 'BN52268215', '159352746', '[{\"id\":\"2\",\"name\":\"Colombia Huila\",\"image\":\"default.jpg\",\"price\":140,\"quantity\":8},{\"id\":\"5\",\"name\":\"Sumatra Mandheling\",\"image\":\"default.jpg\",\"price\":145,\"quantity\":6},{\"id\":\"3\",\"name\":\"Guatemala Antigua\",\"image\":\"default.jpg\",\"price\":150,\"quantity\":5},{\"id\":\"1\",\"name\":\"Yirgacheffe G1 Ethiopia\",\"image\":\"default.jpg\",\"price\":160,\"quantity\":5}]', '2025-11-26 02:17:48'),
(10, 'BN63131382', '15935746', '[{\"id\":\"2\",\"name\":\"Colombia Huila\",\"image\":\"default.jpg\",\"price\":140,\"quantity\":11},{\"id\":\"5\",\"name\":\"Sumatra Mandheling\",\"image\":\"default.jpg\",\"price\":145,\"quantity\":4},{\"id\":\"3\",\"name\":\"Guatemala Antigua\",\"image\":\"default.jpg\",\"price\":150,\"quantity\":5}]', '2025-11-26 05:18:51'),
(11, 'BN66822308', '15935786', '[{\"id\":\"2\",\"name\":\"Colombia Huila\",\"image\":\"default.jpg\",\"price\":140,\"quantity\":8},{\"id\":\"1\",\"name\":\"Yirgacheffe G1 Ethiopia\",\"image\":\"default.jpg\",\"price\":160,\"quantity\":5},{\"id\":\"7\",\"name\":\"Jazz Night Blend\",\"image\":\"default.jpg\",\"price\":165,\"quantity\":6}]', '2025-11-26 06:20:22');

-- --------------------------------------------------------

--
-- 資料表結構 `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `category` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- 傾印資料表的資料 `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `image_url`, `category`) VALUES
(1, 'Yirgacheffe G1 Ethiopia', 'Bright citrus, lemon and jasmine notes with classic Ethiopian characteristics. Washed process for a clean taste.', 160.00, 'yirgacheffe.jpg', 'classic'),
(2, 'Colombia Huila', 'Balanced nutty and chocolate notes with subtle fruity acidity. Smooth and round body.', 140.00, 'colombia.jpg', 'classic'),
(3, 'Guatemala Antigua', 'Rich chocolate, spice and slight smoky notes. Complex with a sweet finish.', 150.00, 'guatemala.jpg', 'classic'),
(4, 'Kenya AA', 'Bold blackcurrant and grapefruit acidity. Full-bodied with a wine-like finish.', 170.00, 'kenya_aa.jpg', 'classic'),
(5, 'Sumatra Mandheling', 'Earthy, chocolate and spicy notes. Low acidity with a smooth, heavy body.', 145.00, 'mandheling.jpg', 'classic'),
(6, 'Morning Overture Blend', 'The perfect breakfast coffee with mild acidity and milk chocolate notes. Energizing and well-balanced.', 155.00, 'morning_blend.jpg', 'blend'),
(7, 'Jazz Night Blend', 'Dark roast blend with rich dark chocolate, caramel and roasted nut flavors. Perfect for evening relaxation.', 165.00, 'jazz_night.jpg', 'blend'),
(8, 'Honey Process Blend', 'Honey processed beans create a honey-like sweetness, tropical fruit notes, and a creamy body.', 175.00, 'honey_blend.jpg', 'blend'),
(9, 'Espresso No.1 Blend', 'Specifically crafted for espresso with rich caramel sweetness, nutty notes, and dense crema.', 160.00, 'espresso_no1.jpg', 'blend'),
(10, 'Geisha Reserve Blend', 'A luxurious blend containing precious Geisha beans, featuring delicate jasmine and peach notes.', 220.00, 'geisha_blend.jpg', 'blend'),
(11, 'Vanilla Hazelnut Flavored', 'Smooth vanilla and roasted hazelnut flavors combined for a sweet, delightful experience.', 150.00, 'vanilla_hazelnut.jpg', 'flavor'),
(12, 'Caramel Cream Flavored', 'Rich caramel aroma with a creamy, smooth texture. Like enjoying a dessert in a cup.', 150.00, 'caramel_cream.jpg', 'flavor'),
(13, 'Colombia Decaf', 'Naturally water-processed to remove caffeine while retaining characteristic nutty and chocolate notes.', 180.00, 'decaf_colombia.jpg', 'flavor'),
(14, 'Ethiopian Natural Process', 'Natural process delivers bold strawberry and blueberry aromas. Wild and sweet flavor profile.', 165.00, 'ethiopian_natural.jpg', 'flavor'),
(15, 'Cloud Estate Honey Process', 'From high-altitude cloud-shrouded estates. Honey process creates complex honey and brown sugar sweetness.', 190.00, 'cloud_estate.jpg', 'flavor');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_number` (`order_number`);

--
-- 資料表索引 `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
