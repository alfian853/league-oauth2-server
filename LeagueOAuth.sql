/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE IF NOT EXISTS `apl-oauth` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `apl-oauth`;

DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `access_token` varchar(150) NOT NULL DEFAULT '',
  `expires` datetime DEFAULT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `client_id` varchar(80) NOT NULL DEFAULT '',
  `user_id` int(11) unsigned DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`access_token`),
  KEY `client_id` (`client_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `oauth_access_tokens_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `oauth_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `oauth_access_tokens_ibfk_3` FOREIGN KEY (`client_id`) REFERENCES `oauth_clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
REPLACE INTO `oauth_access_tokens` (`access_token`, `expires`, `scope`, `client_id`, `user_id`, `revoked`, `created_at`, `updated_at`) VALUES
	('1a354df5bc3c66ec9a91a1277e6aef05dba2c869dd5e7e27479ad5d7e710beabe9a2c9d2d4ffdcbe', '2019-04-20 15:33:21', '', 'test', 1, 0, '2019-04-20 14:33:21', '2019-04-20 14:33:21'),
	('442854985cefe4cf3a683eb2e49f184c17f840689c7160347666684321cc391df12926034e10e01c', '2019-04-20 15:31:58', '', 'test', 1, 0, '2019-04-20 14:31:58', '2019-04-20 14:31:58'),
	('5d6bc6dfe402f3afdc8520b27f02c4603d4ba237ca695ca13a7c4404ad7fb87d8d77c09ad6e6ff93', '2019-04-20 15:31:49', '', 'test', 1, 0, '2019-04-20 14:31:49', '2019-04-20 14:31:49'),
	('82785b8d8d1f207cfbd316b17bd925658fa05558d95394c1352946ca5eb6fee872a931aad3e79659', '2019-04-20 15:34:15', '', 'test', 1, 0, '2019-04-20 14:34:15', '2019-04-20 14:34:15');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;

DROP TABLE IF EXISTS `oauth_authorization_codes`;
CREATE TABLE IF NOT EXISTS `oauth_authorization_codes` (
  `authorization_code` varchar(150) NOT NULL DEFAULT '',
  `expires` datetime DEFAULT NULL,
  `redirect_url` varchar(255) DEFAULT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `client_id` varchar(80) NOT NULL DEFAULT '',
  `user_id` int(11) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`authorization_code`),
  KEY `client_id` (`client_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `oauth_authorization_codes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `oauth_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `oauth_authorization_codes_ibfk_3` FOREIGN KEY (`client_id`) REFERENCES `oauth_clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*!40000 ALTER TABLE `oauth_authorization_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_authorization_codes` ENABLE KEYS */;

DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `client_id` varchar(80) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `client_secret` varchar(255) DEFAULT NULL,
  `redirect_uri` varchar(255) DEFAULT NULL,
  `grant_types` varchar(80) DEFAULT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`client_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `oauth_clients_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `oauth_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
REPLACE INTO `oauth_clients` (`client_id`, `name`, `client_secret`, `redirect_uri`, `grant_types`, `scope`, `user_id`, `created_at`, `updated_at`) VALUES
	('test', 'test', 'secret', 'http://www.test.com', 'password,client_credentials,authorization_code,implicit,refresh_token', '', NULL, NULL, NULL);
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;

DROP TABLE IF EXISTS `oauth_jwt`;
CREATE TABLE IF NOT EXISTS `oauth_jwt` (
  `client_id` varchar(80) NOT NULL DEFAULT '',
  `subject` varchar(80) DEFAULT NULL,
  `public_key` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*!40000 ALTER TABLE `oauth_jwt` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_jwt` ENABLE KEYS */;

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `refresh_token` varchar(150) NOT NULL DEFAULT '',
  `expires` datetime DEFAULT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `client_id` varchar(80) NOT NULL DEFAULT '',
  `user_id` int(11) unsigned DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`refresh_token`),
  KEY `client_id` (`client_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `oauth_refresh_tokens_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `oauth_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `oauth_refresh_tokens_ibfk_3` FOREIGN KEY (`client_id`) REFERENCES `oauth_clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
REPLACE INTO `oauth_refresh_tokens` (`refresh_token`, `expires`, `scope`, `client_id`, `user_id`, `revoked`, `created_at`, `updated_at`) VALUES
	('01650083d3f649a664a478a02e319b20e9788031f979c87513f771377d836076230471c6e7fab4f1', '2019-05-20 14:31:49', NULL, 'test', 1, 0, '2019-04-20 14:31:49', '2019-04-20 14:31:49'),
	('156c3f315b5a02b2c075bff9e4c9a3b3dd1dbc0feee394f50456025e827fc77c24a1d7f7069b4500', '2019-05-20 14:34:15', NULL, 'test', 1, 0, '2019-04-20 14:34:15', '2019-04-20 14:34:15'),
	('15c19711dabac760b54fbc562dd0ba671b4a0dcd8909dd0767db9c45efbe483ba58212f7ae4f9857', '2019-05-20 14:31:58', NULL, 'test', 1, 0, '2019-04-20 14:31:58', '2019-04-20 14:31:58'),
	('ee8a3fe3d393e58a58d715d95cf825e087385bfdbfc9ee1e1d128bff1bdc8e74ec07b7a00973c434', '2019-05-20 14:33:21', NULL, 'test', 1, 0, '2019-04-20 14:33:21', '2019-04-20 14:33:21');
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;

DROP TABLE IF EXISTS `oauth_scopes`;
CREATE TABLE IF NOT EXISTS `oauth_scopes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `scope` varchar(80) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `scope` (`scope`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*!40000 ALTER TABLE `oauth_scopes` DISABLE KEYS */;
REPLACE INTO `oauth_scopes` (`id`, `scope`, `is_default`, `created_at`, `updated_at`) VALUES
	(1, 'profile', NULL, NULL, NULL);
/*!40000 ALTER TABLE `oauth_scopes` ENABLE KEYS */;

DROP TABLE IF EXISTS `oauth_users`;
CREATE TABLE IF NOT EXISTS `oauth_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(150) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `scope` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

/*!40000 ALTER TABLE `oauth_users` DISABLE KEYS */;
REPLACE INTO `oauth_users` (`id`, `username`, `password`, `scope`, `created_at`, `updated_at`) VALUES
	(1, 'abc', 'abc', NULL, NULL, NULL);
/*!40000 ALTER TABLE `oauth_users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
