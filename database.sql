drop DATABASE if not exists book_store;
CREATE DATABASE book_store;
USE book_store;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `app_label` VARCHAR(100) NOT NULL,
  `model` VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `app` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `applied` DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `content_type_id` INT NOT NULL,
  `codename` VARCHAR(100) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
);

CREATE TABLE IF NOT EXISTS `accounts_customuser` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `password` VARCHAR(128) NOT NULL,
  `last_login` DATETIME NULL,
  `is_superuser` BINARY NOT NULL,
  `username` VARCHAR(150) NOT NULL UNIQUE,
  `first_name` VARCHAR(150) NOT NULL,
  `last_name` VARCHAR(150) NOT NULL,
  `email` VARCHAR(254) NOT NULL,
  `is_staff` BINARY NOT NULL,
  `is_active` BINARY NOT NULL,
  `date_joined` DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS `account_emailaddress` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `verified` BINARY NOT NULL,
  `primary` BINARY NOT NULL,
  `user_id` INT NOT NULL,
  `email` VARCHAR(254) NOT NULL UNIQUE,
  FOREIGN KEY (`user_id`) REFERENCES `accounts_customuser` (`id`)
);

CREATE TABLE IF NOT EXISTS `account_emailconfirmation` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `created` DATETIME NOT NULL,
  `sent` DATETIME NULL,
  `key` VARCHAR(64) NOT NULL UNIQUE,
  `email_address_id` INT NOT NULL,
  FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`)
);

CREATE TABLE IF NOT EXISTS `books_book` (
  `id` CHAR(32) NOT NULL PRIMARY KEY,
  `title` VARCHAR(200) NOT NULL,
  `author` VARCHAR(200) NOT NULL,
  `price` DECIMAL NOT NULL,
  `cover` VARCHAR(100) NOT NULL,
  `date_creation` DATETIME NOT NULL,
  `publisher_id` INT NULL,
  FOREIGN KEY (`publisher_id`) REFERENCES `accounts_customuser` (`id`)
);

CREATE TABLE IF NOT EXISTS `books_review` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `review` VARCHAR(255) NOT NULL,
  `author_id` INT NOT NULL,
  `book_id` CHAR(32) NOT NULL,
  `date` DATETIME NOT NULL,
  FOREIGN KEY (`author_id`) REFERENCES `accounts_customuser` (`id`),
  FOREIGN KEY (`book_id`) REFERENCES `books_book` (`id`)
);

CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `object_id` TEXT NULL,
  `object_repr` VARCHAR(200) NOT NULL,
  `action_flag` SMALLINT UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` TEXT NOT NULL,
  `content_type_id` INT NULL,
  `user_id` INT NOT NULL,
  `action_time` DATETIME NOT NULL,
  FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  FOREIGN KEY (`user_id`) REFERENCES `accounts_customuser` (`id`)
);

CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `group_id` INT NOT NULL,
  `permission_id` INT NOT NULL,
  FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
);

CREATE TABLE IF NOT EXISTS `accounts_customuser_groups` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `customuser_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  FOREIGN KEY (`customuser_id`) REFERENCES `accounts_customuser` (`id`),
  FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
);

CREATE TABLE IF NOT EXISTS `accounts_customuser_user_permissions` (
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `customuser_id` INT NOT NULL,
  `permission_id` INT NOT NULL,
  FOREIGN KEY (`customuser_id`) REFERENCES `accounts_customuser` (`id`),
  FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
);

INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('contenttypes','0001_initial','2025-05-13 15:00:38.031071');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('contenttypes','0002_remove_content_type_name','2025-05-13 15:00:38.216118');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('auth','0001_initial','2025-05-13 15:00:38.598290');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('auth','0002_alter_permission_name_max_length','2025-05-13 15:00:38.772549');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('auth','0003_alter_user_email_max_length','2025-05-13 15:00:38.940723');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('auth','0004_alter_user_username_opts','2025-05-13 15:00:39.116298');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('auth','0005_alter_user_last_login_null','2025-05-13 15:00:39.265276');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('auth','0006_require_contenttypes_0002','2025-05-13 15:00:39.415356');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('auth','0007_alter_validators_add_error_messages','2025-05-13 15:00:39.563713');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('auth','0008_alter_user_username_max_length','2025-05-13 15:00:39.717696');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('auth','0009_alter_user_last_name_max_length','2025-05-13 15:00:39.884513');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('auth','0010_alter_group_name_max_length','2025-05-13 15:00:40.044100');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('auth','0011_update_proxy_permissions','2025-05-13 15:00:40.198628');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('auth','0012_alter_user_first_name_max_length','2025-05-13 15:00:40.374621');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('accounts','0001_initial','2025-05-13 15:00:40.756243');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('account','0001_initial','2025-05-13 15:00:41.174239');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('account','0002_email_max_length','2025-05-13 15:00:41.358591');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('admin','0001_initial','2025-05-13 15:00:41.723069');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('admin','0002_logentry_remove_auto_add','2025-05-13 15:00:41.903106');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('admin','0003_logentry_add_action_flag_choices','2025-05-13 15:00:42.075498');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('books','0001_initial','2025-05-13 15:00:42.262460');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('books','0002_review','2025-05-13 15:00:42.639392');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('books','0003_book_cover','2025-05-13 15:00:42.807159');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('books','0004_alter_book_cover','2025-05-13 15:00:42.978167');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('books','0005_alter_book_options','2025-05-13 15:00:43.152609');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('books','0006_alter_book_options','2025-05-13 15:00:43.311878');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('books','0007_book_date_creation','2025-05-13 15:00:43.554779');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('books','0008_alter_review_options_review_date','2025-05-13 15:00:43.770988');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('books','0009_book_publisher','2025-05-13 15:00:44.190063');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('sessions','0001_initial','2025-05-13 15:00:44.516189');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('sites','0001_initial','2025-05-13 15:00:44.687803');
INSERT INTO django_migrations (`app`, `name`, `applied`) VALUES('sites','0002_alter_domain_unique','2025-05-13 15:00:44.851992');
CREATE TABLE IF NOT EXISTS `django_content_type` (`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT, `app_label` VARCHAR(100) NOT NULL, `model` VARCHAR(100) NOT NULL);
INSERT INTO django_content_type (`app_label`, `model`) VALUES('admin','logentry');
INSERT INTO django_content_type (`app_label`, `model`) VALUES('auth','permission');
INSERT INTO django_content_type (`app_label`, `model`) VALUES('auth','group');
INSERT INTO django_content_type (`app_label`, `model`) VALUES('contenttypes','contenttype');
INSERT INTO django_content_type (`app_label`, `model`) VALUES('sessions','session');
INSERT INTO django_content_type (`app_label`, `model`) VALUES('sites','site');
INSERT INTO django_content_type (`app_label`, `model`) VALUES('account','emailaddress');
INSERT INTO django_content_type (`app_label`, `model`) VALUES('account','emailconfirmation');
INSERT INTO django_content_type (`app_label`, `model`) VALUES('accounts','customuser');
INSERT INTO django_content_type (`app_label`, `model`) VALUES('books','book');
INSERT INTO django_content_type (`app_label`, `model`) VALUES('books','review');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(1,'add_logentry','Can add log entry');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(1,'change_logentry','Can change log entry');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(1,'delete_logentry','Can delete log entry');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(1,'view_logentry','Can view log entry');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(2,'add_permission','Can add permission');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(2,'change_permission','Can change permission');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(2,'delete_permission','Can delete permission');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(2,'view_permission','Can view permission');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(3,'add_group','Can add group');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(3,'change_group','Can change group');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(3,'delete_group','Can delete group');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(3,'view_group','Can view group');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(4,'add_contenttype','Can add content type');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(4,'change_contenttype','Can change content type');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(4,'delete_contenttype','Can delete content type');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(4,'view_contenttype','Can view content type');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(5,'add_session','Can add session');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(5,'change_session','Can change session');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(5,'delete_session','Can delete session');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(5,'view_session','Can view session');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(6,'add_site','Can add site');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(6,'change_site','Can change site');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(6,'delete_site','Can delete site');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(6,'view_site','Can view site');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(7,'add_emailaddress','Can add email address');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(7,'change_emailaddress','Can change email address');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(7,'delete_emailaddress','Can delete email address');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(7,'view_emailaddress','Can view email address');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(8,'add_emailconfirmation','Can add email confirmation');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(8,'change_emailconfirmation','Can change email confirmation');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(8,'delete_emailconfirmation','Can delete email confirmation');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(8,'view_emailconfirmation','Can view email confirmation');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(9,'add_customuser','Can add user');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(9,'change_customuser','Can change user');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(9,'delete_customuser','Can delete user');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(9,'view_customuser','Can view user');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(10,'add_book','Can add book');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(10,'change_book','Can change book');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(10,'delete_book','Can delete book');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(10,'view_book','Can view book');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(11,'add_review','Can add review');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(11,'change_review','Can change review');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(11,'delete_review','Can delete review');
INSERT INTO auth_permission (`content_type_id`,`codename`,`name`) VALUES(11,'view_review','Can view review');
CREATE TABLE IF NOT EXISTS `django_session` (`session_key` VARCHAR(40) NOT NULL PRIMARY KEY, `session_data` text NOT NULL, `expire_date` DATETIME NOT NULL);
CREATE TABLE IF NOT EXISTS `django_site` (`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT, `name` VARCHAR(50) NOT NULL, `domain` VARCHAR(100) NOT NULL UNIQUE);
INSERT INTO django_site VALUES(1,'example.com','example.com');
CREATE TABLE IF NOT EXISTS sqlite_sequence(name VARCHAR(150) NOT NULL,sep int NOT NULL);  
INSERT INTO sqlite_sequence VALUES('django_migrations',32);
INSERT INTO sqlite_sequence VALUES('django_content_type',11);
INSERT INTO sqlite_sequence VALUES('auth_permission',44);
INSERT INTO sqlite_sequence VALUES('auth_group',0);
INSERT INTO sqlite_sequence VALUES('account_emailaddress',0);
INSERT INTO sqlite_sequence VALUES('django_admin_log',0);
INSERT INTO sqlite_sequence VALUES('books_review',0);
INSERT INTO sqlite_sequence VALUES('django_site',1);
CREATE UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq` ON `django_content_type` (`app_label`, `model`);
CREATE UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` ON `auth_group_permissions` (`group_id`, `permission_id`);
CREATE INDEX `auth_group_permissions_group_id_b120cbf9` ON `auth_group_permissions` (`group_id`);
CREATE INDEX `auth_group_permissions_permission_id_84c5c92e` ON `auth_group_permissions` (`permission_id`);
CREATE UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq` ON `auth_permission` (`content_type_id`, `codename`);
CREATE INDEX `auth_permission_content_type_id_2f476e4b` ON `auth_permission` (`content_type_id`);
CREATE UNIQUE INDEX `accounts_customuser_groups_customuser_id_group_id_c074bdcb_uniq` ON `accounts_customuser_groups` (`customuser_id`, `group_id`);
CREATE INDEX `accounts_customuser_groups_customuser_id_bc55088e` ON `accounts_customuser_groups` (`customuser_id`);
CREATE INDEX `accounts_customuser_groups_group_id_86ba5f9e` ON `accounts_customuser_groups` (`group_id`);
CREATE INDEX `accounts_customuser_user_permissions_customuser_id_0deaefae` ON `accounts_customuser_user_permissions` (`customuser_id`);
CREATE INDEX `accounts_customuser_user_permissions_permission_id_aea3d0e5` ON `accounts_customuser_user_permissions` (`permission_id`);
CREATE INDEX `account_emailconfirmation_email_address_id_5b7f8c58` ON `account_emailconfirmation` (`email_address_id`);
CREATE INDEX `account_emailaddress_user_id_2c513194` ON `account_emailaddress` (`user_id`);
CREATE INDEX `django_admin_log_content_type_id_c4bce8eb` ON `django_admin_log` (`content_type_id`);
CREATE INDEX `django_admin_log_user_id_c564eba6` ON `django_admin_log` (`user_id`);
CREATE INDEX `books_review_author_id_58d55ec1` ON `books_review` (`author_id`);
CREATE INDEX `books_review_book_id_a67a4c60` ON `books_review` (`book_id`);
CREATE INDEX `books_book_publisher_id_189e6c56` ON `books_book` (`publisher_id`);
CREATE INDEX `django_session_expire_date_a5c62663` ON `django_session` (`expire_date`);
