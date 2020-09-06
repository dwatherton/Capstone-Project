-- MySQL dump 10.17  Distrib 10.3.23-MariaDB, for debian-linux-gnueabihf (armv7l)
--
-- Host: localhost    Database: ew_db
-- ------------------------------------------------------
-- Server version	10.3.23-MariaDB-0+deb10u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add page',7,'add_page'),(26,'Can change page',7,'change_page'),(27,'Can delete page',7,'delete_page'),(28,'Can view page',7,'view_page'),(29,'Can add component',8,'add_component'),(30,'Can change component',8,'change_component'),(31,'Can delete component',8,'delete_component'),(32,'Can view component',8,'view_component'),(33,'Can add ip',9,'add_ip'),(34,'Can change ip',9,'change_ip'),(35,'Can delete ip',9,'delete_ip'),(36,'Can view ip',9,'view_ip');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$216000$GdTZ35X8s6WF$JPeUcGG1LFsh+uuGTLA3ZTkRhgyQF4lGIbWnTAug4j4=','2020-09-06 19:47:18.120826',1,'Django-admin','','','WebBlockheads@gmail.com',1,1,'2020-07-26 23:10:55.588790'),(2,'pbkdf2_sha256$216000$50RaOsKZBloB$SGig+EGwjo5+PhTj95yqsvcBAjn+dpjhyjschnukJVA=','2020-09-06 19:41:04.017338',1,'jxreynolds1','','','jxreynolds1@ualr.edu',1,1,'2019-12-01 23:25:03.322657'),(3,'pbkdf2_sha256$150000$SYQPSQ0fL07g$tlciRYz9bJceGKCyVWplQ6HTlowaQpRbqENrtd7c7k0=','2019-12-09 21:35:33.375219',1,'gxkim2','','','gxkim2@easywebadmin.com',1,1,'2019-12-03 01:04:13.155415'),(4,'pbkdf2_sha256$150000$eCm6ALD288JT$s8tIjDrE7bmzQ/Wx4Tb6H0Q5jYcIrGlD7DeoDsTaj6E=','2019-12-03 14:55:05.193851',1,'dwatherton','','','dwatherton@easywebadmin.com',1,1,'2019-12-03 14:45:50.043631'),(5,'pbkdf2_sha256$150000$8C70ZCQzeD5f$OCYPFFoe93OcsiQaMxVUaC1RicZV3O5tAjbrrLr8Guc=','2019-12-03 19:40:43.232345',1,'shane','','','shane@easywebadmin.com',1,1,'2019-12-03 18:54:02.454232'),(6,'pbkdf2_sha256$150000$rUla6hzdwRjr$9YnN/0niZ7jEnvvh4P/AGpyxq7Ya2F3XoicPn0X26Ww=','2019-12-11 16:03:39.864754',1,'abaker','','','abaker@easywebadmin.com',1,1,'2019-12-03 20:23:48.665220');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2020-07-26 23:23:42.329837','Welcome_Message','Component object (Welcome_Message)',1,'[{\"added\": {}}]',8,1),(2,'2020-07-26 23:23:53.164435','Resource_Links','Component object (Resource_Links)',1,'[{\"added\": {}}]',8,1),(3,'2020-07-26 23:24:02.031211','Program_Links','Component object (Program_Links)',1,'[{\"added\": {}}]',8,1),(4,'2020-07-26 23:24:39.408695','Undergraduate','Page object (Undergraduate)',1,'[{\"added\": {}}]',7,1),(5,'2020-07-26 23:24:52.374446','Site_Info','Page object (Site_Info)',1,'[{\"added\": {}}]',7,1),(6,'2020-07-26 23:25:04.994985','Opportunities_for_Students','Page object (Opportunities_for_Students)',1,'[{\"added\": {}}]',7,1),(7,'2020-07-26 23:25:15.871806','Graduate','Page object (Graduate)',1,'[{\"added\": {}}]',7,1),(8,'2020-07-26 23:25:32.155167','FAQs','Page object (FAQs)',1,'[{\"added\": {}}]',7,1),(9,'2020-07-26 23:25:46.670459','Faculty_and_Staff','Page object (Faculty_and_Staff)',1,'[{\"added\": {}}]',7,1),(10,'2020-07-26 23:25:56.510997','Facilities','Page object (Facilities)',1,'[{\"added\": {}}]',7,1),(11,'2020-07-26 23:26:07.181878','Department_News','Page object (Department_News)',1,'[{\"added\": {}}]',7,1),(12,'2020-07-26 23:26:19.350375','Contact_Us','Page object (Contact_Us)',1,'[{\"added\": {}}]',7,1),(13,'2020-07-26 23:26:29.729926','About','Page object (About)',1,'[{\"added\": {}}]',7,1),(14,'2020-09-06 19:30:00.380664','visitors','Page object (visitors)',1,'[{\"added\": {}}]',7,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(8,'easy_web','component'),(9,'easy_web','ip'),(7,'easy_web','page'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-07-26 23:08:30.572076'),(2,'auth','0001_initial','2020-07-26 23:08:30.995455'),(3,'admin','0001_initial','2020-07-26 23:08:32.452303'),(4,'admin','0002_logentry_remove_auto_add','2020-07-26 23:08:32.721647'),(5,'admin','0003_logentry_add_action_flag_choices','2020-07-26 23:08:32.754077'),(6,'contenttypes','0002_remove_content_type_name','2020-07-26 23:08:33.016537'),(7,'auth','0002_alter_permission_name_max_length','2020-07-26 23:08:33.147619'),(8,'auth','0003_alter_user_email_max_length','2020-07-26 23:08:33.182100'),(9,'auth','0004_alter_user_username_opts','2020-07-26 23:08:33.204327'),(10,'auth','0005_alter_user_last_login_null','2020-07-26 23:08:33.348133'),(11,'auth','0006_require_contenttypes_0002','2020-07-26 23:08:33.397500'),(12,'auth','0007_alter_validators_add_error_messages','2020-07-26 23:08:33.429842'),(13,'auth','0008_alter_user_username_max_length','2020-07-26 23:08:33.600176'),(14,'auth','0009_alter_user_last_name_max_length','2020-07-26 23:08:33.733043'),(15,'auth','0010_alter_group_name_max_length','2020-07-26 23:08:33.773352'),(16,'auth','0011_update_proxy_permissions','2020-07-26 23:08:33.811296'),(17,'easy_web','0001_initial','2020-07-26 23:08:33.866548'),(18,'easy_web','0002_component','2020-07-26 23:08:33.917203'),(19,'sessions','0001_initial','2020-07-26 23:08:33.992853'),(20,'auth','0012_alter_user_first_name_max_length','2020-09-06 19:21:28.892703'),(21,'easy_web','0003_ip','2020-09-06 19:21:28.964360');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('5bjdxwt84gg3c3erc1r5xn63vq32xk3i','.eJxVjEEOwiAQRe_C2hCgHaAu3fcMZIYBWzWQlHZlvLtt0oVu_3vvv0XAbZ3C1tISZhZXocXldyOMz1QOwA8s9ypjLesykzwUedImx8rpdTvdv4MJ27TXSM6h8QiRtLLGGk8MnHL2HWQNxGpQnSWXsgFroCPNg-7VsNsMiL34fAHpDDe8:1kF0dC:znVyxtpEb2rJR0gGuJ43hAcoNOec1NqNqi7kxzg9s7A','2020-09-06 21:47:18.130888'),('mcacr7dx83srv9tir97dn13pbbjmxzth','NDVkZDJjYTlhMTViNzFkMjU4MzgzOTNiNGY1MjBhYzI4NGZiM2E4ODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5NDBkYWI0NmI5MTFlY2NkOTdjNmU2ODJhZWU1N2NiMTgwN2I3OWUzIn0=','2020-07-27 01:16:37.022123');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easy_web_component`
--

DROP TABLE IF EXISTS `easy_web_component`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easy_web_component` (
  `name` varchar(50) NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easy_web_component`
--

LOCK TABLES `easy_web_component` WRITE;
/*!40000 ALTER TABLE `easy_web_component` DISABLE KEYS */;
INSERT INTO `easy_web_component` VALUES ('Program_Links','<li class=\"menu-item\"><a class=\"link\" href=\"/view/undergraduate\" aria-current=\"page\">Undergraduate</a></li>\r\n<li class=\"menu-item\"><a class=\"link\" href=\"/view/graduate\">Graduate</a></li>'),('Resource_Links','<li class=\"menu-item\"><a class=\"link\" href=\"/view/opportunities_for_students\">Student Opportunities</a></li>\r\n<li class=\"menu-item\"><a class=\"link\" href=\"/view/faculty_and_staff\">Faculty & Staff</a></li>\r\n<li class=\"menu-item\"><a class=\"link\" href=\"/view/facilities\">Facilities</a></li>\r\n<li class=\"menu-item\"><a class=\"link\" href=\"/view/faqs\">FAQ’s</a></li>\r\n<li class=\"menu-item\"><a class=\"link\" href=\"/view/about\">About</a></li>'),('Welcome_Message','<h2>Welcome to the UALR Computer Science Department</h2>\r\n<p>Check out the opportunities listed below!</p>\r\n<p>If you have any questions or concerns, feel free to send an email from the <a class=\"link\" href=\"/view/contact_us\">Contact Page.</a></p>');
/*!40000 ALTER TABLE `easy_web_component` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easy_web_ip`
--

DROP TABLE IF EXISTS `easy_web_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easy_web_ip` (
  `timestamp` datetime(6) NOT NULL,
  `ip_address` char(39) NOT NULL,
  `visit_count` int(11) NOT NULL,
  `country` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `lat` decimal(6,4) NOT NULL,
  `lon` decimal(6,4) NOT NULL,
  PRIMARY KEY (`ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easy_web_ip`
--

LOCK TABLES `easy_web_ip` WRITE;
/*!40000 ALTER TABLE `easy_web_ip` DISABLE KEYS */;
INSERT INTO `easy_web_ip` VALUES ('2020-09-06 19:34:59.985079','127.0.0.1',1,'None','None',0.0000,0.0000),('2020-09-06 19:40:59.423372','71.238.234.38',2,'United States','Little Rock',34.7386,-92.4231);
/*!40000 ALTER TABLE `easy_web_ip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `easy_web_page`
--

DROP TABLE IF EXISTS `easy_web_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `easy_web_page` (
  `name` varchar(50) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `easy_web_page`
--

LOCK TABLES `easy_web_page` WRITE;
/*!40000 ALTER TABLE `easy_web_page` DISABLE KEYS */;
INSERT INTO `easy_web_page` VALUES ('About','<h1 class=\"content-title align-center\">About</h1>\r\n<hr>\r\n<h4>Mission</h4>\r\n<p><span style=\"font-size: 1rem;\">The Department of Computer Science seeks to prepare students for careers as computer specialists in Systems Analysis and programming, to enter careers in computer or software design, and for advanced study in Computer Science.</span></p>\r\n<hr>\r\n<h4>Vision</h4>\r\n<p>Our vision is to be a leader in Computer Science education and research within the state and achieve national prominence in both these areas.</p>\r\n<p>Educationally, we will provide a student-focused learning experience to attract students of high-quality and potential from diverse backgrounds, and enable them to attain their educational aspirations by helping them to learn and pursue lifelong scholarly activities. We will inspire our students to succeed and contribute to society as future leaders of their profession.</p>\r\n<p>Professionally, we will encourage and support academic, professional and personal development. We will support and foster ethical scholarly endeavors aimed at meeting the technological and scientific needs of local industry, government and society. We will strive to establish synergistic relationships across several disciplines, actively involving ourselves in harnessing the advances in computing research for the benefit of humanity. We will focus on multi-disciplinary, collaborative research and education initiatives that strengthen and grow our program.</p>\r\n<p>To accomplish our vision in education and research, we will leverage and complement existing strengths of our department (bolstered by complimentary strengths within UALR) to focus on our five specific, yet deeply interrelated strategic goals.</p>\r\n<hr>\r\n<h4>Strategic Goals</h4>\r\n<ul>\r\n	<li><u><a href=\"#sg1\">Academic Goals</a></u></li>\r\n	<li><u><a href=\"#sg2\">Research Goals</a></u></li>\r\n	<li><u><a href=\"#sg3\">Outreach Goals</a></u></li>\r\n</ul>\r\n<hr>\r\n<h4 id=\"sg1\">Academic Goals</h4>\r\n<ol>\r\n	<li>Increasing enrollment into the undergraduate and graduate programs by 5%*.</li>\r\n	<li>Improving student success through involvement in research and development projects and early intervention.</li>\r\n	<li>Investigate the feasibility of offering a 5-year BS/MS program in Computer Science.</li>\r\n	<li>Reaching out to high schools and attract students with personal interaction (particularly important for GAME option and Mobile Computing).</li>\r\n	<li>Strengthening the image of our Undergraduate GAME option.</li>\r\n	<li>Working and collaborating with departments that have a “creative side” (e.g. theatre, graphics design, etc.)</li>\r\n</ol>\r\n<p><em>*There seems to be a “trend” which is currently in the making. There is a rise of middle class in certain countries (Brazil, China, India, and Turkey, etc). This is resulting in more and more students coming to the United States to study. These students often come to the United States to study in a STEM branch. Meanwhile other countries are restructuring in a way which will result in many students potentially coming to the United States to study (mostly sponsored by their governments). By attracting these students to the programs offered by EIT, not only will the breadth and scope of diversity increase among the student population, but the local students will benefit from increased global perspective and competitiveness.</em>\r\n<br><br><u><a href=\"#\">Back to Top</a></u></p>\r\n<hr>\r\n<h4 id=\"sg2\">Research Goals</h4>\r\n<ol>\r\n	<li>Focusing on submission of proposals for extramural funding.</li>\r\n	<li>Building strength and visibility of our Cyber Security and Mobile Computing (e.g. mobile programming) initiatives.</li>\r\n	<li>Working to enhance our High Performance Computing initiative and complete the paperwork on having it as an official center.</li>\r\n	<li>Enhancing our strength and presence in the medical applications area. UAMS collaborations help, more ties with the Veterans Hospital should help as well.</li>\r\n	<li>Doing the ground work and planning toward receiving the Cyber Security “Research” designation from the Department of Defense as a Center of Academic Excellence.</li>\r\n</ol>\r\n<p><u><a href=\"#\">Back to Top</a></u></p>\r\n<hr>\r\n<h4 id=\"sg3\">Outreach Goals</h4>\r\n<ol>\r\n	<li>Working with high school teachers and school districts to help them with their professional development and curriculum improvement.</li>\r\n	<li>Having our experts appear on local media giving expert opinion on “trendy” topics.</li>\r\n	<li>Working with the constituents from the industry to build and foster relationships that will help placement of our graduates and increase the sense of community.</li>\r\n</ol>\r\n<p><u><a href=\"#\">Back to Top</a></u></p>','2020-07-26 23:26:27.000000','2020-07-26 23:26:28.000000'),('Contact_Us','<h3 class=\"contact-heading\">Contact Us</h3>\r\n<div class=\"contact-form-row\">\r\n	<input id=\"id_name\" class=\"contact-field form-control\" type=\"text\" placeholder=\"Name\" aria-label=\"Name\" name=\"name\">\r\n	<input id=\"id_email\" class=\"contact-field form-control\" type=\"email\" placeholder=\"Email\" aria-label=\"Email\" name=\"email\">\r\n</div>\r\n<textarea id=\"id_question\" class=\"form-control\" placeholder=\"Enter your question/concern...\" aria-label=\"Question\" name=\"question\"></textarea>\r\n<button class=\"contact-button\" type=\"submit\">Submit</button>\r\n<!-- Contact Email Sent Alert Banner Using Bootstrap -->\r\n<div class=\"contact-email-sent-alert alert alert-success\">\r\n	<a href=\"#\" class=\"close\" data-dismiss=\"alert\" aria-label=\"close\">&times;</a>\r\n	<strong>Successfully Sent Contact Email!</strong> An Email has been sent to the site admin\'s containing your contact info, please wait for a reply.\r\n</div>','2020-07-26 23:26:16.000000','2020-07-26 23:26:17.000000'),('Department_News','<h1 class=\"content-title align-center\">Department News</h1>\r\n<p><img src=\"https://ualr.edu/computerscience/files/2019/11/Coding-Night-444x564.jpg\"></p>','2020-07-26 23:26:04.000000','2020-07-26 23:26:05.000000'),('Facilities','<h1 class=\"content-title align-center\">Facilities</h1>\r\n<img src=\"https://ualr.edu/computerscience/files/2019/06/UALR-EIT-2-e1561741604616.jpg\">\r\n<br/><br/>\r\n<h4>EIT Building</h4>\r\n<p>The Department of Computer Science is located within the George W. Donaghey College of Engineering and Technology’s 40 million dollar, six-story 115,000-square-foot, world-class teaching and research facility. The buildings educational features include a two-story, 206-seat auditorium, which provides state-of-the-art technology for conferences and meetings with an advanced audiovisual system as well as twelve terraced classrooms, each including between 36 and 40 student workstations outfitted with a thin-client computing terminal, monitor, and keyboard. The buildings research facilities include a high-performance computing cluster and 150 person capacity state-of-the art graduate research space, detailed below.</p>\r\n<hr/>\r\n<h4>High-performance Computing Clusters</h4>\r\n<p>Argon (the UA Little Rock’s 5.4 cluster) consists of 64 Dell PowerEdge machines (each with 8 Xeon processors and 16GB RAM, for a total of 512 cores), 4TB storage, Gigabit Ethernet, and Infiniband interconnection among computing nodes for minimal IPC latency as well as between computing nodes and a 40TB Lustre parallel file system for fast file access. It has the theoretical peak performance of 5.45Tflops (or 5.45 trillion floating point operations per second). The cluster is built for running large scale distributed-memory multiprocessing with MPI as well as for running large numbers of independent jobs simultaneously. Furthermore, Boron (the 16 machines (192 core with total of 768GB RAM) interconnected with 40Gbps links) have a capability to form a virtual symmetrical multiprocessor (SMP) system ideal for both highly parallelized codes across multiple nodes and large memory solution for numerical simulation and data analysis, and its performance will surpass that of a significantly more expensive SMP system available on the market today. Erbium (our big memory machine) was the most tightly integrated stand‐alone computer in the world as of November 2012! Finally, a 12-core machine with 48GB memory will serve as a “data mover” to assure seamless transfer of tera-scale data to our HPC cluster from collaborating institutions. Available Software Packages includes: R/RMPI, Gaussian03/09, LAMMPS, INTEL Math Kernel Library (MKL) and cluster toolkit, MATLAB, Octave, VASP, COMSOL, and FDTD. For more information, visit at: <a class=\"link\" href=\"https://ualr.edu/crc/\">UALR Computational Research Center</a>.</p>\r\n<hr/>\r\n<h4>Graduate Student Research Space</h4>\r\n<p>UA Little Rock’s EIT building is equipped with a 21,000-square-foot space dedicated graduate student research. The space contains 150 Steel Case workstations and is wired for high-speed internet. This space is located on the fourth and sixth floor of the EIT building, which is co-located with the Department of Computer Science’s faculty offices and the High-Performance Computing Clusters.</p>\r\n<hr/>\r\n<h4>Computer Science Laboratories</h4>\r\n<p>The Computer Science Department also has an electronic-access controlled laboratory (ETAS 355, 20 person capacity).</p>','2020-07-26 23:25:54.000000','2020-07-26 23:25:55.000000'),('Faculty_and_Staff','<h1 class=\"content-title align-center\">Faculty and Staff<br></h1>\r\n<hr>\r\n<h5>Faculty:</h5>\r\n<ul>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/about/faculty-and-staff/albert-baker/\">Al Baker Ph.D.</a> – Interim Department Chair</li>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/about/faculty-and-staff/chia-chu-chiang/\">Chia-Chu Chiang Ph.D.</a> – Professor</li>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/about/faculty-and-staff/ivan-rodriguez-conde/\">Ivan Rodriguez-Conde Ph.D.</a> – Assistant Professor</li>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/about/faculty-and-staff/philip-huff/\">Philip Huff M.S.</a> – Assistant Professor</li>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/about/faculty-and-staff/mariofanna-milanova/\">Mariofanna Milanova Ph.D.</a> – Professor</li>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/about/faculty-and-staff/sean-orme/\">Sean Orme M.S.</a> – Instructor</li>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/about/faculty-and-staff/jan-springer/\">Jan P. Springer Ph.D.</a> – Associate Professor</li>\r\n</ul>\r\n<hr>\r\n<h5>Affiliates:</h5>\r\n<ul>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/about/faculty-and-staff/berk-cetinsaya/\">Berk Cetinsaya M.S.</a> – Lecturer</li>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/about/faculty-and-staff/brian-keltch/\">Brian Keltch M.S. </a> – Lecturer</li>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/about/faculty-and-staff/ramiro-serrano/\">Ramiro Serrano M.S.</a> – Lecturer</li>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/jason-zak-bfa-lecturer/\">Jason Zak B.F.A.</a>&nbsp;– Lecturer</li>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/about/faculty-and-staff/matthew-kennett/\">Matthew Kennett M.S.</a> – Graduate Assistant Lecturer</li>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/faculty-and-staff/mark-barnes-m-s-graduate-assistant/\">Mark Barnes M.S.</a> – Graduate Assistant</li>\r\n</ul>\r\n<hr>\r\n<h5>Collaborators:</h5>\r\n<ul>\r\n	<li><a class=\"link\" href=\"http://eac-ualr.org/team.php#cruzneira\">Carolina Cruz-Neira Ph.D</a>. – Director, EAC</li>\r\n	<li><a class=\"link\" href=\"http://eac-ualr.org/team.php#reiners\">Dirk Reiners Ph.D.</a> – Chief Scientist, EAC</li>\r\n</ul>\r\n<hr>\r\n<h5>Staff:</h5>\r\n<ul>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/about/faculty-and-staff/neff-lankford-administrative-specialist-iii/\">Neffetaria Lankford</a> – Admin Assistant III</li>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/about/faculty-and-staff/seth-cook-graduate-assistant/\">Seth Cook B.S.</a> – Graduate Assistant</li>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/about/faculty-and-staff/bushra-sajid-graduate-assistant/\">Bushra Sajid B.S.</a> – Graduate Assistant</li>\r\n</ul>','2020-07-26 23:25:44.000000','2020-07-26 23:25:45.000000'),('FAQs','<h1 class=\"content-title align-center\">FAQs</h1>\r\n<hr>\r\n<h5><strong>Freshmen Student Questions</strong></h5>\r\n<ol>\r\n	<li><a class=\"link\" href=\"#q1\">What is Computer Science?</a></li>\r\n	<li><a class=\"link\" href=\"#q2\">Is Computer Science the right choice of major for me? </a></li>\r\n	<li><a class=\"link\" href=\"#q3\">Why should I study Computer Science?</a></li>\r\n	<li><a class=\"link\" href=\"#q4\">What languages are used in Computer Science? </a></li>\r\n	<li><a class=\"link\" href=\"#q5\">Do I need to own my own personal computer? </a></li>\r\n	<li><a class=\"link\" href=\"#q6\">What are some career opportunities for Computer Science majors?</a></li>\r\n	<li><a class=\"link\" href=\"#q7\">Some people I know have a technology-related job without studying much Mathematics in their college major. However, I see that a degree in Computer Science involves a lot of Mathematics. Why do you require it?</a></li>\r\n	<li><a class=\"link\" href=\"#q8\">What kind of a student succeeds as a Computer Science major?</a></li>\r\n	<li><a class=\"link\" href=\"#q9\">What are some of the fundamental skills necessary for a Computer Science major? </a></li>\r\n	<li><a class=\"link\" href=\"#q10\">I am ready to look at the Computer Science curriculum, where do I go from here?</a></li>\r\n</ol>\r\n<hr>\r\n<h5><strong>Transfer Student Questions</strong></h5>\r\n<ol><li><a href=\"/view/faqs#q11\">What courses will transfer into UA Little Rock’s Computer Science Department? </a></li><li><a href=\"/view/faqs#q12\">General Education courses</a></li><li><a href=\"/view/faqs#q13\">Mathematics courses</a></li><li><a href=\"/view/faqs#q14\">Computer Science courses</a></li><li><a href=\"/view/faqs#q15\">Summary</a></li></ol>\r\n<p>UA Little Rock Admission page: <a href=\"https://ualr.edu/admissions\" target=\"_new\" rel=\"noopener noreferrer\">https://ualr.edu/admissions</a></p>\r\n<hr>\r\n<h4><strong><a name=\"u1\"></a></strong></h4><ol><a class=\"link\" href=\"#q15\" style=\"font-size: 1rem; background-color: white;\">\r\n</a></ol><a class=\"link\" href=\"#q15\" style=\"font-size: 1rem; background-color: white;\"></a><strong>What is Computer Science?</strong>\r\n<p>Most people often equate the study of Computer Science to the study of computer programming. Edsger Dijkstra – one of the pioneers of the Computer Science discipline once said, Computer Science is no more about computers than astronomy is about telescopes. The study of Computer Science encompasses much more than programming and involves a variety of topics such as analysis and design of algorithms, formal design techniques, design of programming languages, software engineering, assembly language and computer organization, distributed computing, artificial intelligence and mathematical analysis. Computer scientists study how to efficiently organize, store and retrieve data, how to write efficient programs, probe the limits of algorithmic techniques in designing programs to behave intelligently, develop new applications that benefit society and humankind, design complex software programs and design effective interfaces between programs and humans.</p>\r\n<p><a class=\"link\" href=\"#\">Top of Page</a></p>\r\n<hr>\r\n<h4 id=\"q2\"><strong>Is Computer Science the right choice of major for me?</strong></h4>\r\n<p>At UA Little Rock, we have the Management Information Systems major that is focused on the development of computer applications in a business environment and the effective use of computer resources to meet business objectives. Within our college at UA Little Rock, we have an Information Science (IFSC) program where students are primarily concerned with learning about the structure, representation, management, storage, retrieval and transfer of information. Computer Science students on the other-hand focus deeply on the fundamental principles of computing and these students develop skills in data structures, algorithmic reasoning, hardware /software design needs and trade-offs, and integrated software application design. We prepare our students to apply these principles creatively and responsibly. If you are unsure about what area interests you, we suggest that you to try the introductory programming course.</p>\r\n<p>A common misconception among students attracted to the discipline is that they will learn to be skilled web page developers, graphic specialists, or applicative users -word processing, spreadsheet, graphical design, and CAD applications. If your interest is in learning about tools for the creation of computer art, then an art major with a minor in CS or Information Science would be most beneficial. If your interest is in creating efficient software applications, including internetworking software applications for the World Wide Web, then a CS degree with an appropriate minor would be your best option. Please set up a visit and talk to us if your career interests are in the design, analysis and development of software systems.</p>\r\n<p>Also a common expectation (or interest) among some students interested in the discipline is that they will learn to become expert game programmers. While good software design and development skills are key to being a successful game programmer, game programming involves deep knowledge in several other disciplines – including mathematics, psychology and art. Our Graphics, Animation, Multimedia and Entertainment (GAME) option will provide you the necessary basic computing skills – learned through the development of game based assignments and projects. It appropriately blends student learning of computing skills with the required interface development, mathematics and artistic skills to help you begin your career quest as a game programmer.</p>\r\n<p><a class=\"link\" href=\"#\">Top of Page</a></p>\r\n<hr>\r\n<h4 id=\"q3\"><strong>Why should I study Computer Science?</strong></h4>\r\n<p>For almost all choice jobs of the future – whether in engineering, natural or social sciences, economics, finance or government, one has to be familiar with the essential fundamentals of computing to understand and leverage technology in the search for scientific breakthroughs, the development of new products and services, or the way work is done in a technologically-driven society. A Computer Science degree involves well developed communication, leadership and management skills coupled with creative technical savvy. Daniel A. Reed, Professor & Director of the Institute for Renaissance Computing at the University of North Carolina at Chapel Hill and the current director of CRA (Computing Research Association – <a class=\"link\" href=\"http://www.cra.org\" target=\"_blank\" rel=\"noopener noreferrer\">http://www.cra.org</a>) says, “Computing has become the third pillar of science, along with theory and experiment”.</p>\r\n<p><img src=\"https://ualr.edu/computerscience/files/2006/09/cs1-faq.png\"></p>\r\n<p><a class=\"link\" href=\"#\">Top of Page</a></p>\r\n<hr>\r\n<h4 id=\"q4\"><strong>What languages are used in Computer Science?</strong></h4>\r\n<p>The introductory courses in Computer Science use C++ and the Windows® operating system environment as the tools to teach basic computer science concepts. Many subsequent courses in computer science assume that you know C++ (or another computer programming language) well and expect you to learn other languages as necessitated by specific problems in those classes.</p>\r\n<p><a class=\"link\" href=\"#\">Top of Page</a></p>\r\n<hr>\r\n<h4 id=\"q5\"><strong>Do I need to own my own personal computer? </strong></h4>\r\n<p>Owning a computer is obviously advantageous in terms of ease and convenience to work on your assignments at any given time. However, at UA Little Rock we do not require you to have your own computer. In addition to wireless access across the campus, we have many open computer labs for your use, which are equipped with the necessary software for your classes. While some computer labs are devoted to computer science exclusively, others are for the general student population at UA Little Rock. Thus, some labs may have specialized software installed that is not available in every lab.</p>\r\n<p><a class=\"link\" href=\"#\">Top of Page</a></p>\r\n<hr>\r\n<h4 id=\"q6\"><strong>What are some career opportunities for Computer Science majors?</strong></h4>\r\n<p>The rapid growth in technology-based jobs in all industries has created a need for technologically skilled professionals. Virtually every industry applies Computer Science professionals in a variety of ways – from computerized control of hazardous and remote environments to payroll processing in traditional industries. Industry, government and businesses seeking graduates in a wide variety of areas including software systems design, internet computing and networking, regularly recruit our graduates. Thus, career opportunities for Computer Science graduates are limitless. We are well known for offering well-designed curricula, setting challenging academic standards and providing well-qualified graduates for businesses and organizations. To support our students’ aspirations of lifelong learning and meet their employers’ needs, in addition to helping develop technical depth in our field, we help our students develop critical thinking, teamwork and effective communication skills.</p>\r\n<p><a class=\"link\" href=\"https://ualr.edu/computerscience/files/2019/07/63PercentOfAllNewSTEMjobsInCS.jpg\"><img src=\"https://ualr.edu/computerscience/files/2019/07/63PercentOfAllNewSTEMjobsInCS-444x303.jpg\"></a></p>\r\n<p><a class=\"link\" href=\"#\">Top of Page</a></p>\r\n<hr>\r\n<h4 id=\"q7\"><strong>Some people I know have a technology-related job without studying much Mathematics in their college major. However, I see that a degree in Computer Science involves a lot of mathematics. Why do you require it?</strong></h4>\r\n<p>Most stable and well-paying technology-based jobs require adeptness with algorithmic reasoning. Studying mathematics develops your analytical ability and prepares you to think precisely, thereby preparing you to be creative – a trait essential for being a successful computer scientist. Calculus for example, is not just for engineering students, since it builds in you the ability to think about, and rank the impact of, relationships among different items. The foundations provided by studying mathematics will give you the ability to grasp the essentials of a problem, understand the various abstractions and predict patterns of change induced by changing certain parameters. Such ability is essential to be intellectually productive in your professional life (in any discipline). Note that differences in mathematical performance of students are the result of hard work. Increasingly in this vast technologically glued world, you will experience the need to stand up to theories that do not hold up to quantitative analysis. Hence, the ability in mathematics is definitely helpful. However, it is not the knowledge of mathematics but rather a familiarity and comfort with algorithmic reasoning that correlates with success in the computing discipline.</p>\r\n<p><a class=\"link\" href=\"#\">Top of Page</a></p>\r\n<hr>\r\n<h4 id=\"q8\"><strong>What kind of a student succeeds as a Computer Science major?</strong></h4>\r\n<p>Most successful Computer Science students have demonstrated the ability to be flexible and adaptable (i.e. they MORPH well). Specifically, the MORPH traits include: (i) Mature: Clarity of thought (long-term focused career vision). (ii) Organized: Able to manage time and balance personal work habits. (iii) Responsible: Ability to take lead and handle responsibility. (iv) Persistence: Ability to be tenacious and deliberative in problem solving. (v) Helpful: Team-oriented, societal-issues consciousness and supportive of diverse needs and reach of the discipline.</p>\r\n<p>For example, many good students in our upper-level classes have not been the ones that could finish their assignments in lower-level classes on their first attempts, but ones that both made, and learned from, their mistakes through dogged persistence and sheer hard work. One key attribute that most of our successful majors have is the ability to think logically (or in Computer Science parlance, algorithmically). This means developing the ability to break down a problem into a series of small steps each of which can be solved through a logical sequence of actions.</p>\r\n<p><a class=\"link\" href=\"#\">Top of Page</a></p>\r\n<hr>\r\n<h4 id=\"q9\"><strong>What are some of the fundamental skills necessary for a Computer Science major?</strong></h4>\r\n<p>To succeed in the discipline, an aspiring student must seek to obtain a strong high school background in math and science, build strategic-thinking skills, develop strong oral and written communication skills and develop her/his ability to work in a team environment. As with any creative discipline, a curious and imaginative mind with an abundance of self-motivation to be successful is very essential.</p>\r\n<p><a class=\"link\" href=\"#\">Top of Page</a></p>\r\n<hr>\r\n<h4 id=\"q10\"><strong>I am ready to look at the Computer Science curriculum, where do I go from here? </strong></h4>\r\n<p>Here are the appropriate links to our curriculum pages.</p>\r\n<ul>\r\n	<li><a class=\"link\" title=\"Undergraduate Programs\" href=\"https://ualr.edu/computerscience/prospective-students/programs/undergraduate-programs/\">Bachelor of Science in Computer Science</a></li>\r\n	<li><a class=\"link\" title=\"Graduate Programs\" href=\"https://ualr.edu/computerscience/prospective-students/programs/graduate-programs/\">Master of Science in Computer Science</a></li>\r\n</ul>\r\n<p><a class=\"link\" href=\"#\">Top of Page</a></p>\r\n<hr>\r\n<h3>Transfer Student Questions</h3><br>\r\n<h4 id=\"q11\"><strong>What courses will transfer into UALR’s Computer Science Department? </strong></h4>\r\n<p>The chapter called “Admissions and Financial Aid” describes the transfer policies in general terms. Your transfer work will be evaluated once all of your required documents are received. All transfer students are initially admitted into University College. Please check here (<a class=\"link\" href=\"https://ualr.edu/records/transfer/tca/\" target=\"_blank\" rel=\"noopener noreferrer\">https://ualr.edu/records/transfer/tca/</a>) for transfer articulation agreements. If you want to be a Computer Science major, and have questions about specific coursework not covered in the transfer articulation, please request the department chairperson.</p>\r\n<p>Generally, a student coming out of high school can gain advanced placement (AP) credit for English or math courses. If you have advanced placement credit, then you should take the next English or math course after the one(s) for which advanced placement credit is given. Don’t skip ahead unless you feel comfortable; it is best to be on solid footing every step of the way through the curriculum.</p>\r\n<p><a class=\"link\" href=\"#\">Top of Page</a></p>\r\n<hr>\r\n<h4 id=\"q12\"><strong>General Education courses</strong></h4>\r\n<p>UA Little Rock participates in the State Minimum Core Curriculum, which allows students to transfer up to 35 hours of general education or core courses among Arkansas institutions. Students transferring to or from UA Little Rock and another publicly supported Arkansas college or university should check with their advisors to assure proper transfer of core courses. Students entering the University with an associate of arts degree from a regionally accredited college or university meet UA Little Rock’s core curriculum requirements.</p>\r\n<p><a class=\"link\" href=\"#\">Top of Page</a></p>\r\n<hr>\r\n<h4 id=\"q13\"><strong>Mathematics courses </strong></h4>\r\n<p>It is good to take all or part of the calculus sequence either at UA Little Rock or at your current institution. If you are not able take calculus, then take trigonometry and other pre-calculus courses. That way, when you transfer to UA Little Rock, you would be ready to take calculus during your first semester here so that you can continue to complete the mathematics requirements in our major. You should always be on solid footing in mathematics since mathematics is a long-term sequence of courses, which depend upon each other and complement corresponding Computer Science classes. If you are weak or deficient in any area of mathematics coming out of high school, you should definitely take the corresponding mathematics courses wherever you are attending college (two-year or other).</p>\r\n<p><a class=\"link\" href=\"#\">Top of Page</a></p>\r\n<hr>\r\n<h4 id=\"q14\"><strong>Computer Science courses</strong></h4>\r\n<p>If you wish to major in Computer Science, you are probably most interested in taking Computer Science courses when you enter any college. It is good to take such courses, but be aware that some computer courses will not count toward a Computer Science major at UA Little Rock because they are not part of the degree requirements. As an example, a course in computer peripherals, word processing or spreadsheets is a good course to have to develop your vocational skills, but it is not part of our degree requirement, so such a course will transfer only as general elective credit. The first two Computer Science courses in our program constitute a serious introduction to programming and program design. Usually, these courses use either C++ or Java as the programming language. Regardless of which language is used, the basic principles of structured and object oriented program design and use of data structures (e.g, linked lists, queues, trees, etc.) are covered. At UA Little Rock, C++ is used as the language in the first two courses. Thus, the question arises: “What happens if I take the first two courses in JAVA and want to transfer to UA Little Rock?” In the first place, the courses will transfer as CPSC 1375 and CPSC 2376 (the first two Computer Science courses at UA Little Rock) without any problem. A student who transfers to UA Little Rock in this situation generally either picks up the C++ language on his own or elects to take CPSC 1375 in order to learn C++ and feel comfortable in subsequent courses, even though taking CPSC 1375 is not strictly required. Generally, you should take the time, if necessary, to remain on solid footing at all times while progressing through the Computer Science courses (just like in math).</p>\r\n<p><a class=\"link\" href=\"#\">Top of Page</a></p>\r\n<hr>\r\n<h4 id=\"q15\"><strong>Summary</strong></h4>\r\n<p>Some courses that you take at another college count as general elective credit at UA Little Rock, but do not fulfill any specific degree requirement. You must fulfill all degree requirements using courses you take at UA Little Rock, courses that transfer from another college, or advanced placement credit from high school. UA Little Rock will evaluate your transcript from another college and decide what credits will transfer for specific courses in your degree program. As a general recommendation, if you are attending a two-year college, you should take general education courses and mathematics courses needed to fulfill requirements at UA Little Rock. You should take computer courses also, but remember that not all of them will transfer as courses required within the computer science major at UA Little Rock. UA Little Rock accepts work in transfer from any regionally accredited institution. If a particular institution does not appear in this guide, it does not mean UA Little Rock will not accept course work from that institution. For your particular case, check <a href=\"https://ualr.edu/records/transfer/tca/\" target=\"_blank\" rel=\"noopener noreferrer\">https://ualr.edu/records/transfer/tca/</a> to be sure that course equivalency exists for your current institution. If not, please discuss this with UA Little Rock – an academic advisor can answer all questions about a student’s transfer of credit and all other aspects of that student’s academic program of study.</p>\r\n<p><a class=\"link\" href=\"#\">Top of Page</a></p>','2020-07-26 23:25:29.000000','2020-07-26 23:25:30.000000'),('Graduate','<h1 class=\"content-title align-center\">Graduate Programs</h1>\r\n<hr/>\r\n<h4>Master of Computer Science</h4>\r\n<p>The Master of Science in computer science program at UA Little Rock reflects current trends in the computing discipline and provides students with a solid theoretical and practical foundation for careers in computing and/or advanced graduate studies. The curriculum centers on a core of courses covering major traditional areas of computer science: software engineering, operating systems, computer architecture, telecommunications and networking, and analysis of algorithms. It also allows students flexibility in acquiring in-depth knowledge of important areas of specialization through the selection of electives. Students may also elect one of three options (thesis, project, comprehensive exam) for satisfying the requirements for the master&rsquo;s degree. The program is accessible to both day and evening students, and lends itself to both full and part-time study.</p>\r\n<p>For more information, contact <a title=\"Mariofanna Milanova Ph.D. &ndash; Professor\" href=\"https://ualr.edu/computerscience/about/faculty-and-staff/mariofanna-milanova/\">Mariofanna Milanova Ph.D.</a></p>\r\n<p><a href=\"https://catalog.ualr.edu/preview_program.php?catoid=6&amp;poid=1094&amp;hl\"><img src=\"https://ualr.edu/computerscience/files/2006/11/apply-now.gif\"/></a></p>\r\n<hr/>\r\n<h4>Doctor of Philosophy in Computer and Information Sciences</h4>\r\n<p>The Computer and Information Sciences Doctoral Program is housed in the Donaghey College of Engineering and Information Technology. Faculty, curriculum, and resources for this program come from three departments: Computer Science, Information Science, and Systems Engineering. This degree is designed to promote strong multidisciplinary collaborations across several computing disciplines whose bodies of knowledge influence and intertwine with each other. The following emphasis areas are offered:</p>\r\n<ul>\r\n	<li>Computer Science &ndash; focusing on the application architecture whose integrated software systems support the data and functional needs of the enterprise across diverse computing networks.</li>\r\n	<li>Information Science &ndash; focusing on the theory, applications, technologies, and systems that classify, manipulate, store, retrieve, and disseminate information.</li>\r\n	<li>Information Quality &ndash; focusing on the theory, principles, models, and techniques for delivering information that is &ldquo;fit for use&rdquo;, an increasingly challenging task as organizations struggle with such issues as data architecture, identity resolution, data protection, and privacy.</li>\r\n</ul>\r\n<p>For more information, contact <a title=\"John Talburt Ph.D. &ndash; Professor\" href=\"https://ualr.edu/informationscience/faculty-staff/\">John Talburt Ph.D.</a></p>','2020-07-26 23:25:13.000000','2020-07-26 23:25:14.000000'),('Opportunities_for_Students','<h1 class=\"content-title align-center\">Opportunities for Students</h1>\r\n<hr/>\r\n<h5>Cyber Security:</h5>\r\n<ul>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/cybersecurity-club/\">Cyber Security Club</a><br/></li>\r\n	<li><a class=\"link\" href=\"https://arkansasstemcoalition.com/event/jolt-hackathon/\">Jolt Hackathon</a><br/></li>\r\n</ul>\r\n<hr/>\r\n<h5>Virtual and Augmented Reality:</h5>\r\n<ul>\r\n	<li><a class=\"link\" href=\"http://eac-ualr.org/EAC_Indiv/facility.html\">EAC VR and AR center</a><br/></li>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/news/2018/01/19/virtual-reality-innovator-cruz-neira-demonstrates-vr-changing-world-consumer-electronics-show/\">CAVE VR Experience</a><br/></li>\r\n</ul>\r\n<hr/>\r\n<h5>Data Visualization:</h5>\r\n<ul>\r\n	<li><a class=\"link\" href=\"http://cosmos.ualr.edu\">COSMOS Team</a><br/></li>\r\n</ul>\r\n<hr/>\r\n<h5>Artificial Intelligence and Machine Learning:</h5>\r\n<ul>\r\n	<li><a class=\"link\" href=\"https://www.pyimagesearch.com/2018/06/25/raspberry-pi-face-recognition/\">Facial Recognition on Raspberry PI</a><br/></li>\r\n</ul>\r\n<hr/>\r\n<h5>Student Clubs and Organizations:</h5>\r\n<ul>\r\n	<li><a class=\"link\" href=\"https://ualr.acm.org\">ACM Club</a><br/></li>\r\n	<li><a class=\"link\" href=\"https://ualr.edu/computerscience/cybersecurity-club/\">Cyber Security Club</a><br/></li>\r\n</ul>','2020-07-26 23:25:03.000000','2020-07-26 23:25:04.000000'),('Site_Info','<h1 class=\"content-title align-center\">Site Info</h1><hr>\r\n<p>This is a demo project submitted December 2019 for UALR CPSC Course 4392 Capstone instructed by <a class=\"link\" href=\"https://ualr.edu/computerscience/about/faculty-and-staff/albert-baker/\">Al Baker Ph.D.</a></p>\r\n<p>Listed below is information about the website, how to use it, and the project as a whole.</p><hr>\r\n<ul>\r\n	<li><p>This site is officially supported on Chrome version 70+</p></li>\r\n	<li><p>Hosted on an AWS EC2 t.2 Micro Linux instance</p></li>\r\n	<li><p>Dynamic DNS provided by <a class=\"link\" href=\"https://www.noip.com/\">No-IP</a></p></li>\r\n	<li><p>Version Control using <a class=\"link\" href=\"https://github.com/dwatherton/Capstone-Project\">GitHub</a></p></li>\r\n	<li><p>Built using PyCharm, Python 3.7.4, Django 2.2.8, MySQL 8.0.18</p></li>\r\n</ul><hr>\r\n<p>The goal of this project was to create a simple website editor to provide people with no programming experience a way to easily edit and maintain a website. (Specifically ualr.edu)</p>\r\n<p>The first step is to <a class=\"link\" href=\"/register\" target=\"_blank\">register here</a> then <a class=\"link\" href=\"/login\" target=\"_blank\">login.</a></p>\r\n<p>You will be greeted with a simple text editor.<br>Select a page listed on the left, and make changes using the editor. To view or save your changes, click the Preview or Update buttons.</p>\r\n<p>Please view the tutorial below to learn more!</p><hr>\r\n<h4 id=\"tutorial\">Tutorial</h4>\r\n<p>The following tutorial was created using <a class=\"link\" href=\"https://www.iorad.com/\">iorad.</a><br>Please choose below, click Start, and follow the prompts on the right sidebar.</p>\r\n<ul>\r\n	<li><a class=\"link\" href=\"https://www.iorad.com/player/1616683/UALR-Capstone---Easy-Web-Editor#trysteps-1\" target=\"_blank\">Interactive Tutorial</a></li>\r\n	<li><a class=\"link\" href=\"https://www.iorad.com/player/1616683/UALR-Capstone---Easy-Web-Editor#watchsteps-1\" target=\"_blank\">Video Tutorial</a> - Best for New Visitors!</li>\r\n</ul>','2020-07-26 23:24:48.000000','2020-07-26 23:24:49.000000'),('Undergraduate','<h1 class=\"content-title align-center\">Undergraduate Programs</h1>\r\n<hr/>\r\n<h4>Bachelor of Computer Science</h4>\r\n<p>The department offers courses covering a wide range of topics in Computer Science, including programming and programming languages, data structures and algorithms, assembly language, computer architecture, networking, operating systems, compilers, software engineering, file structures, database systems, graphics, artificial intelligence, and theory of computation. The department seeks to prepare students both for careers in the computing industry and for advanced study in Computer Science. The department maintains close ties with local computing industries and encourages its students to participate in the many cooperative and internship opportunities made available through these contacts.</p>\r\n<hr/>\r\n<p>The program educational objectives are:</p>\r\n<ul>\r\n	<li>Be successful in their careers as computer scientists in business, industry, or for advanced studies in the discipline.</li>\r\n	<li>Apply fundamental principles and practices of computer science for the design, development, and management of software systems.</li>\r\n	<li>Serve as role models of ethical and responsible behavior and foster teamwork and cooperation in their profession and their communities.</li>\r\n	<li>Engage in life-long learning, embracing the latest practices, methods, and technologies in their careers.</li>\r\n</ul>\r\n<hr/>\r\n<p>The program has measurable program results that enable students, by the time of graduation, to:</p>\r\n<ul>\r\n	<li>Analyze a complex computing problem and to apply principles of computing and other relevant disciplines to identify solutions.</li>\r\n	<li>Design, implement and evaluate a computing-based solution to meet a given set of computing requirements in the context of the program&rsquo;s discipline.</li>\r\n	<li>Communicate effectively in a variety of professional contexts.</li>\r\n	<li>Recognize professional responsibilities and make informed judgments in computing practice based on legal and ethical principles.</li>\r\n	<li>Function effectively as a member or leader of a team engaged in activities appropriate to the program&rsquo;s discipline.</li>\r\n	<li>Apply computer science theory and software development fundamentals to produce computing-based solutions.</li>\r\n</ul>\r\n<hr/>\r\n<p>Our B.S. in Computer Science program had 196 (147 Full time, 49 Part-Time) students (Fall 2018) and 26 graduates during the 2019 academic year, and is accredited by the Computing Accreditation Commission of ABET, <a href=\"http://www.abet.org/\" target=\"_blank\" rel=\"noopener noreferrer\" data-saferedirecturl=\"https://www.google.com/url?q=http://www.abet.org&amp;source=gmail&amp;ust=1563402073551000&amp;usg=AFQjCNGRAEYcRuuR3ZI_4PJtaeTU3Ag0rA\">http://www.abet.org</a>.</p>\r\n<p><a href=\"https://ualr.edu/computerscience/files/2006/11/CAC-RGB-B-S.png\"><img src=\"https://ualr.edu/computerscience/files/2006/11/CAC-RGB-B-S-204x89.png\"/></a></p>\r\n<p>For more information, contact <a class=\"link\" href=\"mailto:abaker@ualr.edu\">Dr. Albert Baker</a></p>\r\n<hr/>\r\n<p><strong><a class=\"link\" href=\"https://catalog.ualr.edu/preview_program.php?catoid=4&amp;poid=504&amp;returnto=118\">Computer Science, B.S. </a></strong></p>\r\n<p><a class=\"link\" href=\"https://catalog.ualr.edu/preview_program.php?catoid=4&amp;poid=506&amp;returnto=118\"><strong>Computer Science, B.S. (GAME option)</strong></a></p>\r\n<p><a class=\"link\" href=\"https://catalog.ualr.edu/preview_program.php?catoid=4&amp;poid=505&amp;returnto=118\" target=\"_blank\" rel=\"noopener noreferrer\"><strong>Associate in Computer Science Curriculum Catalog</strong></a></p>\r\n<p><a class=\"link\" href=\"https://ualr.edu/computerscience/assure/information-assurance-programs/\"><strong>Minor in Information Assurance</strong></a></p>','2020-07-26 23:24:37.000000','2020-07-26 23:24:37.000000'),('visitors','<a class=\"nav-link\" href=\"/visitors\">Go to Visitors page</a>','2020-09-06 19:29:50.000000','2020-09-06 19:29:50.000000');
/*!40000 ALTER TABLE `easy_web_page` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-06 14:51:11
