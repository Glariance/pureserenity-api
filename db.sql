-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.43 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table serenity.blogs
CREATE TABLE IF NOT EXISTS `blogs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_keyword` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` enum('draft','published','archived') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `blogs_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.blogs: ~0 rows (approximately)

-- Dumping structure for table serenity.blog_tag
CREATE TABLE IF NOT EXISTS `blog_tag` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `blog_id` bigint unsigned NOT NULL,
  `tag_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_tag_blog_id_foreign` (`blog_id`),
  KEY `blog_tag_tag_id_foreign` (`tag_id`),
  CONSTRAINT `blog_tag_blog_id_foreign` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blog_tag_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.blog_tag: ~0 rows (approximately)

-- Dumping structure for table serenity.brands
CREATE TABLE IF NOT EXISTS `brands` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `brands_name_unique` (`name`),
  UNIQUE KEY `brands_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.brands: ~0 rows (approximately)

-- Dumping structure for table serenity.cache
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.cache: ~0 rows (approximately)

-- Dumping structure for table serenity.cache_locks
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.cache_locks: ~0 rows (approximately)

-- Dumping structure for table serenity.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_name_unique` (`name`),
  UNIQUE KEY `categories_slug_unique` (`slug`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.categories: ~0 rows (approximately)

-- Dumping structure for table serenity.cms_pages
CREATE TABLE IF NOT EXISTS `cms_pages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `page_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `page_meta_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_meta_keyword` text COLLATE utf8mb4_unicode_ci,
  `page_meta_description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cms_pages_page_slug_unique` (`page_slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.cms_pages: ~0 rows (approximately)
INSERT INTO `cms_pages` (`id`, `page_title`, `page_slug`, `page_meta_title`, `page_meta_keyword`, `page_meta_description`, `created_at`, `updated_at`) VALUES
	(1, 'Home', 'home', 'Home | Pure Serenity', 'PureSerenity', 'Pure Serenity Shop', '2025-11-04 12:22:39', '2025-11-04 12:22:39'),
	(2, 'About Us', 'about-us', 'About Us', 'About Us', 'About Us', '2025-11-07 18:32:16', '2025-11-07 18:32:16');

-- Dumping structure for table serenity.cms_page_sections
CREATE TABLE IF NOT EXISTS `cms_page_sections` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cms_page_id` bigint unsigned NOT NULL,
  `section_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `section_type` enum('single','repeater') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'single',
  `section_sort_order` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_page_sections_cms_page_id_foreign` (`cms_page_id`),
  CONSTRAINT `cms_page_sections_cms_page_id_foreign` FOREIGN KEY (`cms_page_id`) REFERENCES `cms_pages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.cms_page_sections: ~8 rows (approximately)
INSERT INTO `cms_page_sections` (`id`, `cms_page_id`, `section_name`, `section_type`, `section_sort_order`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Hero Slider', 'repeater', 1, '2025-11-04 12:24:48', '2025-11-04 12:24:48'),
	(2, 1, 'Home About', 'single', 2, '2025-11-04 12:37:07', '2025-11-04 12:37:07'),
	(3, 1, 'Home Why Chose Us', 'single', 3, '2025-11-04 12:40:10', '2025-11-04 12:40:10'),
	(4, 1, 'Home Signature Collections', 'single', 4, '2025-11-04 12:56:42', '2025-11-04 12:56:42'),
	(5, 1, 'Home Journey Today', 'single', 5, '2025-11-04 13:15:27', '2025-11-04 13:15:27'),
	(6, 1, 'Home Discover Ritual', 'single', 6, '2025-11-04 13:30:35', '2025-11-04 13:30:35'),
	(7, 1, 'Home People Saying', 'single', 7, '2025-11-04 13:46:26', '2025-11-04 13:46:26'),
	(8, 1, 'Home Featured Products', 'single', 8, '2025-11-04 13:51:58', '2025-11-04 13:51:58');

-- Dumping structure for table serenity.cms_page_section_fields
CREATE TABLE IF NOT EXISTS `cms_page_section_fields` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cms_page_section_id` bigint unsigned NOT NULL,
  `field_group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `field_type` enum('text','textarea','image','number','boolean','select') COLLATE utf8mb4_unicode_ci NOT NULL,
  `field_value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cms_page_section_fields_cms_page_section_id_foreign` (`cms_page_section_id`),
  CONSTRAINT `cms_page_section_fields_cms_page_section_id_foreign` FOREIGN KEY (`cms_page_section_id`) REFERENCES `cms_page_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.cms_page_section_fields: ~46 rows (approximately)
INSERT INTO `cms_page_section_fields` (`id`, `cms_page_section_id`, `field_group`, `field_name`, `field_type`, `field_value`, `created_at`, `updated_at`) VALUES
	(3, 1, 'Group_1', 'Title', 'text', 'Morning Rituals', '2025-11-04 12:27:16', '2025-11-06 13:24:45'),
	(4, 1, 'Group_1', 'Heading', 'text', 'Ease into the day with mindful energy', '2025-11-04 12:27:16', '2025-11-06 13:25:33'),
	(5, 1, 'Group_1', 'Description', 'textarea', '<p>Layer aromatherapy, sunrise lamps, and guided journaling to greet each morning feeling grounded and bright.</p>', '2025-11-04 12:27:16', '2025-11-04 12:28:26'),
	(6, 1, 'Group_1', 'Banner', 'image', 'cms_fields/1762277306_banner1.jpg', '2025-11-04 12:27:16', '2025-11-04 12:28:27'),
	(7, 1, 'Group_2', 'Title', 'text', 'Twilight Retreat', '2025-11-04 12:28:35', '2025-11-04 12:30:31'),
	(8, 1, 'Group_2', 'Heading', 'text', 'Wind down with calming essentials', '2025-11-04 12:28:35', '2025-11-04 12:30:31'),
	(9, 1, 'Group_2', 'Description', 'textarea', '<p>Create a sanctuary after sunset with plush textures, herbal teas, and soft light curated for deep relaxation.</p>', '2025-11-04 12:28:35', '2025-11-04 12:30:31'),
	(10, 1, 'Group_2', 'Banner', 'image', 'cms_fields/1762277431_banner2.jpg', '2025-11-04 12:28:35', '2025-11-04 12:30:31'),
	(11, 1, 'Group_3', 'Title', 'text', 'Gifted Serenity', '2025-11-04 12:28:40', '2025-11-04 12:30:31'),
	(12, 1, 'Group_3', 'Heading', 'text', 'Share curated calm with someone special', '2025-11-04 12:28:40', '2025-11-04 12:30:31'),
	(13, 1, 'Group_3', 'Description', 'textarea', '<p>From small gestures to statement bundles, discover gifts that help your favorite people breathe a little easier.</p>', '2025-11-04 12:28:40', '2025-11-04 12:30:31'),
	(14, 1, 'Group_3', 'Banner', 'image', 'cms_fields/1762277431_banner3.jpg', '2025-11-04 12:28:40', '2025-11-04 12:30:31'),
	(15, 2, NULL, 'Title', 'text', 'About Pure Serenity', '2025-11-04 12:37:45', '2025-11-04 12:38:16'),
	(16, 2, NULL, 'Heading', 'text', 'At Pure Serenity, we believe every woman deserves to feel beautiful and confident at any age.', '2025-11-04 12:37:45', '2025-11-04 12:38:16'),
	(17, 2, NULL, 'Description', 'textarea', '<p>Our products blend natural ingredients with proven science to help reduce wrinkles, firm skin, and bring back your radiant glow.</p>', '2025-11-04 12:37:45', '2025-11-04 12:38:16'),
	(18, 2, NULL, 'Image', 'image', 'cms_sections/j7F7y9dMENofVwmaeybOHvgho3AZlOV4hFIIFKca.jpg', '2025-11-04 12:37:45', '2025-11-04 12:38:16'),
	(19, 3, NULL, 'Heading', 'text', 'Why Choose Pure Serenity', '2025-11-04 12:42:53', '2025-11-04 12:44:52'),
	(20, 3, NULL, 'Description', 'textarea', '<p>We help you find peace and balance with carefully selected wellness products</p>', '2025-11-04 12:42:53', '2025-11-04 12:44:52'),
	(21, 3, NULL, 'Box 1 - Heading', 'text', 'Curated Selection', '2025-11-04 12:42:53', '2025-11-04 12:44:52'),
	(22, 3, NULL, 'Box 1 - Description', 'textarea', '<p>Handpicked products for your wellness journey</p>', '2025-11-04 12:42:53', '2025-11-04 12:44:52'),
	(23, 3, NULL, 'Box 2 - Heading', 'text', 'Peaceful Living', '2025-11-04 12:42:53', '2025-11-04 12:44:52'),
	(24, 3, NULL, 'Box 2 - Description', 'textarea', '<p>Create balance and harmony in daily life</p>', '2025-11-04 12:42:53', '2025-11-04 12:44:52'),
	(25, 3, NULL, 'Box 3 - Heading', 'text', 'Natural Wellness', '2025-11-04 12:42:53', '2025-11-04 12:44:52'),
	(26, 3, NULL, 'Box 3 - Description', 'textarea', '<p>Products that nurture mind, body, and spirit</p>', '2025-11-04 12:42:53', '2025-11-04 12:44:52'),
	(27, 3, NULL, 'Image 1', 'image', 'cms_sections/armEmk62pxT7XiXzYSVBH6V9qpv1TFds4Iez2sJG.jpg', '2025-11-04 12:43:50', '2025-11-04 12:44:52'),
	(28, 3, NULL, 'Image 2', 'image', 'cms_sections/ctCL316ZVN7RYugO6D0rKU39Qm3B3VcPC5c22iQn.jpg', '2025-11-04 12:43:50', '2025-11-04 12:44:52'),
	(29, 4, NULL, 'Title', 'text', 'Signature Collections', '2025-11-04 12:57:15', '2025-11-04 12:57:28'),
	(30, 4, NULL, 'Heading', 'text', 'Shop by the mood you want to create', '2025-11-04 12:57:15', '2025-11-04 12:57:28'),
	(31, 4, NULL, 'Description', 'textarea', '<p>Browse bundles curated for every moment of your day&mdash;from sunrise energizers to twilight rituals.</p>', '2025-11-04 12:57:15', '2025-11-04 12:57:28'),
	(32, 5, NULL, 'Heading', 'text', 'Start Your Wellness Journey Today', '2025-11-04 13:15:59', '2025-11-04 13:16:18'),
	(33, 5, NULL, 'Description', 'textarea', '<p>Discover products that bring calm and positivity into your everyday life</p>', '2025-11-04 13:15:59', '2025-11-04 13:16:18'),
	(34, 6, NULL, 'Title', 'text', 'Just For You', '2025-11-04 13:35:31', '2025-11-04 13:36:27'),
	(35, 6, NULL, 'Heading', 'text', 'Discover the ritual that fits your flow', '2025-11-04 13:35:31', '2025-11-04 13:36:27'),
	(36, 6, NULL, 'Description', 'textarea', '<p>Our mood matcher highlights products that support what you need most today&mdash;focus, restoration, or cozy comfort.</p>', '2025-11-04 13:35:31', '2025-11-04 13:36:27'),
	(37, 6, NULL, 'Box 1 - Heading', 'text', 'Elevate Energy', '2025-11-04 13:35:31', '2025-11-04 13:36:27'),
	(38, 6, NULL, 'Box 1 - Description', 'textarea', '<ul>\r\n	<li>Citrus mists</li>\r\n	<li>Motivational journals</li>\r\n	<li>Bright light therapy</li>\r\n</ul>', '2025-11-04 13:35:31', '2025-11-04 13:36:27'),
	(39, 6, NULL, 'Box 2 - Heading', 'text', 'Nightly Wind Down', '2025-11-04 13:35:31', '2025-11-04 13:36:27'),
	(40, 6, NULL, 'Box 2 - Description', 'textarea', '<ul>\r\n	<li>Silk sleep masks</li>\r\n	<li>Chamomile infusions</li>\r\n	<li>Weighted blankets</li>\r\n</ul>', '2025-11-04 13:35:31', '2025-11-04 13:36:27'),
	(41, 6, NULL, 'Box 3 - Heading', 'text', 'Self-Care Sunday', '2025-11-04 13:35:31', '2025-11-04 13:36:27'),
	(42, 6, NULL, 'Box 3 - Description', 'textarea', '<ul>\r\n	<li>Bath soaks</li>\r\n	<li>Facial rollers</li>\r\n	<li>Restorative playlists</li>\r\n</ul>', '2025-11-04 13:35:31', '2025-11-04 13:36:27'),
	(43, 7, NULL, 'Title', 'text', 'What People Are Saying', '2025-11-04 13:49:23', '2025-11-04 13:50:01'),
	(44, 7, NULL, 'Heading', 'text', 'Loved by our wellness community', '2025-11-04 13:49:23', '2025-11-04 13:50:01'),
	(45, 7, NULL, 'Description', 'textarea', '<p>We listen closely to the Pure Serenity community to keep refining every box, recommendation, and ritual guide we share.</p>', '2025-11-04 13:49:23', '2025-11-04 13:50:01'),
	(46, 7, NULL, 'Image 1', 'image', 'cms_sections/IRavYGbALuElwrTxHiRcqRweHXDWFSh4TgV8Cm0e.jpg', '2025-11-04 13:49:23', '2025-11-04 13:50:02'),
	(47, 7, NULL, 'Image 2', 'image', 'cms_sections/UP7B7s6U7AB7eHIpR7QTwhmMMskQcmySAB3XfD2K.jpg', '2025-11-04 13:49:23', '2025-11-04 13:50:02'),
	(48, 7, NULL, 'Image 3', 'image', 'cms_sections/9xLU1S7M7fGpd387wnHCRXNu1g2FEmW47MyaYaB3.jpg', '2025-11-04 13:49:23', '2025-11-04 13:50:02'),
	(49, 8, NULL, 'Title', 'text', 'Featured Products', '2025-11-04 13:52:22', '2025-11-04 13:52:39'),
	(50, 8, NULL, 'Heading', 'text', 'Fresh ideas to inspire your rituals', '2025-11-04 13:52:22', '2025-11-04 13:52:39'),
	(51, 8, NULL, 'Description', 'textarea', '<p>Explore a trio of customer-favorite essentials ready to elevate your daily calm.</p>', '2025-11-04 13:52:22', '2025-11-04 13:52:39');

-- Dumping structure for table serenity.comments
CREATE TABLE IF NOT EXISTS `comments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `commentable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `commentable_id` bigint unsigned NOT NULL,
  `parent_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_commentable_type_commentable_id_index` (`commentable_type`,`commentable_id`),
  KEY `comments_parent_id_foreign` (`parent_id`),
  KEY `comments_user_id_foreign` (`user_id`),
  CONSTRAINT `comments_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.comments: ~0 rows (approximately)

-- Dumping structure for table serenity.contact_inquiries
CREATE TABLE IF NOT EXISTS `contact_inquiries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.contact_inquiries: ~0 rows (approximately)

-- Dumping structure for table serenity.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table serenity.general_settings
CREATE TABLE IF NOT EXISTS `general_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `general_settings_key_unique` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.general_settings: ~0 rows (approximately)

-- Dumping structure for table serenity.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.jobs: ~0 rows (approximately)

-- Dumping structure for table serenity.job_batches
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.job_batches: ~0 rows (approximately)

-- Dumping structure for table serenity.media
CREATE TABLE IF NOT EXISTS `media` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `media_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mediaable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mediaable_id` bigint unsigned NOT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `media_mediaable_type_mediaable_id_index` (`mediaable_type`,`mediaable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.media: ~0 rows (approximately)

-- Dumping structure for table serenity.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.migrations: ~24 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '0001_01_01_000000_create_users_table', 1),
	(2, '0001_01_01_000001_create_cache_table', 1),
	(3, '0001_01_01_000002_create_jobs_table', 1),
	(4, '2025_03_07_174825_create_roles_table', 1),
	(5, '2025_03_11_005549_create_smtp_settings_table', 1),
	(6, '2025_03_11_005632_create_settings_table', 1),
	(7, '2025_03_12_174255_create_general_settings_table', 1),
	(8, '2025_03_14_165559_create_cms_pages_table', 1),
	(9, '2025_03_14_165622_create_cms_page_sections_table', 1),
	(10, '2025_03_14_165724_create_cms_page_section_fields_table', 1),
	(11, '2025_03_20_004833_create_newsletters_table', 1),
	(12, '2025_03_20_181115_add_soft_delete_column_in_news_letter', 1),
	(13, '2025_03_24_225725_create_contact_inquiries_table', 1),
	(14, '2025_03_26_185938_create_tags_table', 1),
	(15, '2025_03_26_185947_create_blogs_table', 1),
	(16, '2025_03_26_185955_create_media_table', 1),
	(17, '2025_03_26_191914_create_blog_tag_table', 1),
	(18, '2025_03_28_163339_create_comments_table', 1),
	(19, '2025_04_28_194922_create_categories_table', 1),
	(20, '2025_04_28_194931_create_brands_table', 1),
	(21, '2025_04_30_231701_create_product_attributes_table', 1),
	(22, '2025_04_30_231719_create_product_attribute_options_table', 1),
	(23, '2025_04_30_231739_create_products_table', 1),
	(24, '2025_04_30_231747_create_product_variations_table', 1);

-- Dumping structure for table serenity.newsletters
CREATE TABLE IF NOT EXISTS `newsletters` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_subscribed` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `newsletters_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.newsletters: ~0 rows (approximately)

-- Dumping structure for table serenity.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.password_reset_tokens: ~0 rows (approximately)

-- Dumping structure for table serenity.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `base_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `stock` int NOT NULL DEFAULT '0',
  `has_variations` tinyint(1) NOT NULL DEFAULT '0',
  `category_id` bigint unsigned NOT NULL,
  `brand_id` bigint unsigned NOT NULL,
  `has_discount` tinyint(1) NOT NULL DEFAULT '0',
  `discount_type` enum('fixed','percentage') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_value` decimal(10,2) DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `new` tinyint(1) NOT NULL DEFAULT '0',
  `top` tinyint(1) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_category_id_foreign` (`category_id`),
  KEY `products_brand_id_foreign` (`brand_id`),
  KEY `products_created_by_foreign` (`created_by`),
  CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `products_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.products: ~0 rows (approximately)

-- Dumping structure for table serenity.product_attributes
CREATE TABLE IF NOT EXISTS `product_attributes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.product_attributes: ~0 rows (approximately)

-- Dumping structure for table serenity.product_attribute_options
CREATE TABLE IF NOT EXISTS `product_attribute_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `attribute_id` bigint unsigned NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_attribute_options_attribute_id_foreign` (`attribute_id`),
  CONSTRAINT `product_attribute_options_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `product_attributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.product_attribute_options: ~0 rows (approximately)

-- Dumping structure for table serenity.product_variations
CREATE TABLE IF NOT EXISTS `product_variations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `option_ids` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `attribute_option_index` varchar(191) COLLATE utf8mb4_unicode_ci GENERATED ALWAYS AS (json_unquote(json_extract(`option_ids`,_utf8mb4'$[0]'))) STORED,
  PRIMARY KEY (`id`),
  KEY `product_variations_product_id_foreign` (`product_id`),
  CONSTRAINT `product_variations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.product_variations: ~0 rows (approximately)

-- Dumping structure for table serenity.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.roles: ~2 rows (approximately)
INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'admin', '2025-11-03 16:18:20', '2025-11-03 16:18:20'),
	(2, 'user', '2025-11-03 16:18:20', '2025-11-03 16:18:20');

-- Dumping structure for table serenity.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.sessions: ~3 rows (approximately)
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
	('dIKvoEIdwUqaQD8q1KGnY7JG21lLgP0cyaswLQAB', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiU2pmUzMyelFHOUt1TUF0WHFuQzloTjhQR1JEOWN2UU5PUXo3MGROYSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MDoiaHR0cDovL2xvY2FsaG9zdDo4MDAwL2FkbWluL2Ntcy9hYm91dC11cyI7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjMzOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvYWRtaW4vbG9naW4iO3M6NToicm91dGUiO3M6MTE6ImFkbWluLmxvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1762880904),
	('XL2jjjr19VyZXeoeHt7EQzju2rf91o078sLiyaxa', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoic05OMlo1SHNFd2pzMXVLSjgwVzZyMUIyZVZrTzRhS2JFSjJmcVBSTyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDA6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hZG1pbi9jbXMvYWJvdXQtdXMiO3M6NToicm91dGUiO3M6MTU6ImFkbWluLmNtcy5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1762558337),
	('xr7VxPIQPI9dEf6cUkex7hSTGrYKiKVUemnVlYgW', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoidzlaTzAyYjBIaWhJNWtDbnBBR3N5RFNvbThUd3JEY0VIczhHUTZoNiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9tZWRpYS9jbXNfZmllbGRzLzE3NjIyNzc0MzFfYmFubmVyMy5qcGciO3M6NToicm91dGUiO3M6MTE6Im1lZGlhLmFzc2V0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo2NDoiaHR0cDovL2xvY2FsaG9zdDo4MDAwL2FkbWluL2Ntcy9zZWN0aW9uLzEvZmllbGRzP189MTc2MjM4MTcyODY5NyI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1762459065);

-- Dumping structure for table serenity.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.settings: ~0 rows (approximately)

-- Dumping structure for table serenity.smtp_settings
CREATE TABLE IF NOT EXISTS `smtp_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `mail_driver` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_host` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_port` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_encryption` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_from_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.smtp_settings: ~0 rows (approximately)

-- Dumping structure for table serenity.tags
CREATE TABLE IF NOT EXISTS `tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.tags: ~0 rows (approximately)

-- Dumping structure for table serenity.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table serenity.users: ~0 rows (approximately)
INSERT INTO `users` (`id`, `name`, `email`, `image`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `role_id`) VALUES
	(1, 'Admin', 'admin@mail.com', NULL, NULL, '$2y$12$E7mucrHd5J/u4R9T3CdhbuiZz8WDo5mZORoiR8hr9a1WrKGmnXAaS', NULL, '2025-11-03 16:18:20', '2025-11-03 16:18:20', 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
