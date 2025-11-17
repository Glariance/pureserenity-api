

-- Dumping data for table serenity.categories: ~5 rows (approximately)
INSERT INTO `categories` (`id`, `parent_id`, `name`, `slug`, `description`, `status`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'Wellness', 'wellness', '<p>Wellness</p>', 1, '2025-11-13 16:54:23', '2025-11-13 16:54:23'),
	(2, NULL, 'Relaxation', 'relaxation', '<p>Relaxation</p>', 1, '2025-11-13 16:54:51', '2025-11-13 16:54:51'),
	(3, NULL, 'Home Comfort', 'home-comfort', '<p>Home Comfort</p>', 1, '2025-11-13 16:55:16', '2025-11-13 16:55:16'),
	(4, NULL, 'Spiritual Balance', 'spiritual-balance', '<p>Spiritual Balance</p>', 1, '2025-11-13 16:56:49', '2025-11-13 16:56:49'),
	(5, NULL, 'Shop Pet Essentials', 'shop-pet-essentials', '<p>Shop Pet Essentials</p>', 1, '2025-11-13 16:57:18', '2025-11-13 16:57:18');



-- Dumping data for table serenity.cms_pages: ~2 rows (approximately)
INSERT INTO `cms_pages` (`id`, `page_title`, `page_slug`, `page_meta_title`, `page_meta_keyword`, `page_meta_description`, `created_at`, `updated_at`) VALUES
	(1, 'Home', 'home', 'Home | Pure Serenity', 'PureSerenity', 'Pure Serenity Shop', '2025-11-04 12:22:39', '2025-11-04 12:22:39'),
	(2, 'About Us', 'about-us', 'About Us', 'About Us', 'About Us', '2025-11-07 18:32:16', '2025-11-07 18:32:16');



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



-- Dumping data for table serenity.cms_page_section_fields: ~49 rows (approximately)
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


-- Dumping data for table serenity.roles: ~2 rows (approximately)
INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'admin', '2025-11-03 16:18:20', '2025-11-03 16:18:20'),
	(2, 'user', '2025-11-03 16:18:20', '2025-11-03 16:18:20');


-- Dumping data for table serenity.users: ~1 rows (approximately)
INSERT INTO `users` (`id`, `name`, `email`, `image`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `role_id`) VALUES
	(1, 'Admin', 'admin@mail.com', NULL, NULL, '$2y$12$E7mucrHd5J/u4R9T3CdhbuiZz8WDo5mZORoiR8hr9a1WrKGmnXAaS', NULL, '2025-11-03 16:18:20', '2025-11-03 16:18:20', 1);

