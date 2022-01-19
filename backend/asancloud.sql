-- MySQL dump 10.13  Distrib 5.7.36, for Linux (x86_64)
--
-- Host: localhost    Database: asancloud
-- ------------------------------------------------------
-- Server version	5.7.36-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `g_account`
--

DROP TABLE IF EXISTS `g_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_account` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `userID` varchar(30) NOT NULL,
  `userPW` varchar(100) DEFAULT NULL,
  `salt` varchar(100) DEFAULT NULL,
  `userNAME` varchar(30) NOT NULL,
  `create_at` datetime DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_account`
--

LOCK TABLES `g_account` WRITE;
/*!40000 ALTER TABLE `g_account` DISABLE KEYS */;
INSERT INTO `g_account` VALUES (1,'admin','eOfcQpJNoWb7dIAMSUr1tAe3AqPerogaArzCN1LOTjPHMw20yOEAF3tf7s8N6ecJDsbIQ/ZHHZyw6WH8SzqxlA==','KcHGES3mLDWMvB7iwwfCjh2oa+M+KSP7j9R/oo9AL/xaEMhRoD+y3URJNGV79Mq2uEIbs2OtTodkTI/t4e8lpQ==','admin','2021-11-15 13:51:10');
/*!40000 ALTER TABLE `g_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_checklist`
--

DROP TABLE IF EXISTS `g_checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_checklist` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `stb_sn` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_checklist`
--

LOCK TABLES `g_checklist` WRITE;
/*!40000 ALTER TABLE `g_checklist` DISABLE KEYS */;
INSERT INTO `g_checklist` VALUES (1,'체크리스트','2022-01-19 09:15:56','KSQ19880205'),(2,'체크리스트','2022-01-18 19:29:09','KSQ19880201');
/*!40000 ALTER TABLE `g_checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_checklist_list`
--

DROP TABLE IF EXISTS `g_checklist_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_checklist_list` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `checklist_uid` int(11) NOT NULL,
  `value` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  KEY `sch_che` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_checklist_list`
--

LOCK TABLES `g_checklist_list` WRITE;
/*!40000 ALTER TABLE `g_checklist_list` DISABLE KEYS */;
INSERT INTO `g_checklist_list` VALUES (1,'집도과 ','2021-01-10 09:00:00',1,'타임아웃 하겠습니다. 환자분 성함과 주민번호 앞자리가 어떻게 되십니까?'),(2,'환자 ','2021-01-10 11:00:00',1,'000 0000000입니다'),(3,'집도과 ','2021-01-10 14:00:00',1,'네. 무슨 수술하러 오셨나요?'),(4,'환자 ','2021-01-10 16:00:00',1,'000 수술입니다'),(5,'집도과 ','2021-01-11 09:00:00',1,'등록번호 000 000 님. 000쪽 000수술 입니다.'),(6,'마취과 의사','2021-01-11 11:00:00',1,'네. 맞습니다.'),(7,'마취회복 간호사','2021-01-11 09:00:00',1,'네. 맞습니다.'),(8,'순회 간호사','2021-01-11 11:00:00',1,'네. 맞습니다.'),(9,'마취과 의사','2021-01-11 14:00:00',1,'마취 시작합니다.'),(10,'집도과 ','2021-01-11 16:00:00',2,'타임아웃 하겠습니다. 환자분 성함과 주민번호 앞자리가 어떻게 되십니까?'),(11,'환자 ','2021-01-12 09:00:00',2,'000 0000000입니다'),(12,'집도과 ','2021-01-12 11:00:00',2,'네. 무슨 수술하러 오셨나요?'),(13,'환자 ','2021-01-12 14:00:00',2,'000 수술입니다'),(14,'집도과 ','2021-01-12 16:00:00',2,'등록번호 000 000 님. 000쪽 000수술 입니다.'),(15,'마취과 의사','2021-01-13 09:00:00',2,'네. 맞습니다.'),(16,'마취회복 간호사','2021-01-10 09:00:00',2,'네. 맞습니다.'),(17,'순회 간호사','2021-01-10 11:00:00',2,'네. 맞습니다.'),(18,'마취과 의사','2021-01-10 14:00:00',2,'마취 시작합니다.');
/*!40000 ALTER TABLE `g_checklist_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_department`
--

DROP TABLE IF EXISTS `g_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_department` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `department` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_department`
--

LOCK TABLES `g_department` WRITE;
/*!40000 ALTER TABLE `g_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `g_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_distribution`
--

DROP TABLE IF EXISTS `g_distribution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_distribution` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `stb_sn` varchar(30) NOT NULL,
  `name` varchar(60) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `dis_sch` (`stb_sn`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_distribution`
--

LOCK TABLES `g_distribution` WRITE;
/*!40000 ALTER TABLE `g_distribution` DISABLE KEYS */;
INSERT INTO `g_distribution` VALUES (1,'KSQ19880205','first distribution','2022-01-19 10:01:28'),(2,'KSQ19880201','second distribution','2022-01-19 10:01:23'),(3,'KSQ19880207','third distribution','2020-11-08 10:10:10');
/*!40000 ALTER TABLE `g_distribution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_home`
--

DROP TABLE IF EXISTS `g_home`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_home` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `stb_sn` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_home`
--

LOCK TABLES `g_home` WRITE;
/*!40000 ALTER TABLE `g_home` DISABLE KEYS */;
INSERT INTO `g_home` VALUES (1,'폐 수술 메인 화면','2022-01-19 09:30:45','KSQ19880205'),(2,'어깨 팔 수술 메인 화면','2022-01-19 09:30:45','KSQ19880205'),(3,'간암 수술 메인 화면','2022-01-19 09:30:45','KSQ19880205'),(4,'난소암 수술 메인 화면','2022-01-19 09:30:45','KSQ19880205'),(5,'심장 수술 메인 화면','2022-01-18 17:47:50','KSQ19880201'),(6,'다리 수술 메인 화면','2022-01-18 17:47:50','KSQ19880201'),(7,'림프종 수술 메인 화면','2022-01-18 17:47:50','KSQ19880201'),(8,'신장암 수술 메인 화면','2022-01-18 17:47:50','KSQ19880201');
/*!40000 ALTER TABLE `g_home` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_home_list`
--

DROP TABLE IF EXISTS `g_home_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_home_list` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `g_home_uid` int(11) NOT NULL,
  PRIMARY KEY (`uid`),
  KEY `sch_hom` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_home_list`
--

LOCK TABLES `g_home_list` WRITE;
/*!40000 ALTER TABLE `g_home_list` DISABLE KEYS */;
INSERT INTO `g_home_list` VALUES (1,'폐 수술','2022-01-12 16:26:00',1),(2,'어깨 팔 수술','2022-01-12 09:24:00',2),(3,'간암 수술','2022-01-12 02:22:00',3),(4,'난소암 수술','2022-01-11 19:20:00',4),(5,'심장 수술','2022-01-11 12:18:00',5),(6,'다리 수술','2022-01-11 05:16:00',6),(7,'림프종 수술','2022-01-10 22:14:00',7),(8,'신장암 수술','2022-01-10 15:12:00',8);
/*!40000 ALTER TABLE `g_home_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_instrument`
--

DROP TABLE IF EXISTS `g_instrument`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_instrument` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `thumbnail` varchar(100) DEFAULT NULL,
  `name` varchar(60) NOT NULL,
  `contents` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_instrument`
--

LOCK TABLES `g_instrument` WRITE;
/*!40000 ALTER TABLE `g_instrument` DISABLE KEYS */;
INSERT INTO `g_instrument` VALUES (1,'url','Conference Call','content'),(2,'url','CT','content'),(3,'url','Microscope','content'),(4,'url','Endoscope','content'),(5,'url','PET_CT','content'),(6,'url','MRI','content'),(7,'url','Laparoscope','content'),(8,'url','PAC','content'),(9,'url','Potable XR','content');
/*!40000 ALTER TABLE `g_instrument` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_layout`
--

DROP TABLE IF EXISTS `g_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_layout` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `stb_sn` varchar(30) NOT NULL,
  `layout_list_order` int(11) DEFAULT NULL,
  `staff_id` int(11) NOT NULL,
  `imageurl` varchar(100) NOT NULL,
  `info` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_layout`
--

LOCK TABLES `g_layout` WRITE;
/*!40000 ALTER TABLE `g_layout` DISABLE KEYS */;
INSERT INTO `g_layout` VALUES (1,'first layout','2021-12-06 11:11:11','KSQ19880205',1,1,'http://172.16.41.233:3000/layout_used/2021-12-07_10:44:06_first_layout_1.jpg','1/ct,2/mri'),(2,'second layout','2021-12-27 14:00:00','KSQ19880201',2,1,'http://172.16.41.233:3000/layout_used/2021-12-07_10:44:06_first_layout_1.jpg','1/ct,2/mri');
/*!40000 ALTER TABLE `g_layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_layout_list_define`
--

DROP TABLE IF EXISTS `g_layout_list_define`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_layout_list_define` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `content_id` int(11) DEFAULT NULL,
  `contents` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_layout_list_define`
--

LOCK TABLES `g_layout_list_define` WRITE;
/*!40000 ALTER TABLE `g_layout_list_define` DISABLE KEYS */;
INSERT INTO `g_layout_list_define` VALUES (1,0,0,1920,540,1,''),(2,0,0,1920,540,2,''),(3,0,0,1920,540,3,'');
/*!40000 ALTER TABLE `g_layout_list_define` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_layout_list_layout`
--

DROP TABLE IF EXISTS `g_layout_list_layout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_layout_list_layout` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `imageurl` varchar(255) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_layout_list_layout`
--

LOCK TABLES `g_layout_list_layout` WRITE;
/*!40000 ALTER TABLE `g_layout_list_layout` DISABLE KEYS */;
INSERT INTO `g_layout_list_layout` VALUES (1,'layout1','2020-11-09 10:10:10','http://172.16.41.233:3000/layout/layout1.png'),(2,'layout2','2020-11-11 11:11:11','http://172.16.41.233:3000/layout/layout2.png'),(3,'layout3','2020-11-11 11:11:11','http://172.16.41.233:3000/layout/layout3.png'),(4,'layout4','2020-11-11 11:11:11','http://172.16.41.233:3000/layout/layout4.png'),(5,'layout5','2020-11-11 11:11:11','http://172.16.41.233:3000/layout/layout5.png'),(6,'layout6','2020-11-11 11:11:11','http://172.16.41.233:3000/layout/layout6.png');
/*!40000 ALTER TABLE `g_layout_list_layout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_main`
--

DROP TABLE IF EXISTS `g_main`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_main` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `stb_sn` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_main`
--

LOCK TABLES `g_main` WRITE;
/*!40000 ALTER TABLE `g_main` DISABLE KEYS */;
INSERT INTO `g_main` VALUES (1,'first main','2022-01-19 10:01:28','KSQ19880205'),(2,'second main','2022-01-19 10:01:23','KSQ19880201'),(3,'third main','2022-01-10 15:34:55','F20020Y0057');
/*!40000 ALTER TABLE `g_main` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_main_list`
--

DROP TABLE IF EXISTS `g_main_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_main_list` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `start` varchar(30) NOT NULL,
  `end` varchar(30) NOT NULL,
  `g_main_uid` int(11) NOT NULL,
  `user` varchar(30) NOT NULL,
  `file_path` varchar(200) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `file_ext` varchar(30) NOT NULL,
  `file_url` varchar(200) NOT NULL,
  PRIMARY KEY (`uid`),
  KEY `sch_mai` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_main_list`
--

LOCK TABLES `g_main_list` WRITE;
/*!40000 ALTER TABLE `g_main_list` DISABLE KEYS */;
INSERT INTO `g_main_list` VALUES (1,'토끼 영상','2022-01-19 10:00:40','08:00','10:00',1,'admin','/home/asan/asan/backend/uploads/contents/meditation/2022-01-19_10:00:35_movie.mp4','2022-01-19_10:00:35_movie.mp4','.mp4','http://172.16.41.233:3000/uploads/contents/meditation/2022-01-19_10:00:35_movie.mp4'),(2,'토끼 영상','2022-01-19 10:00:56','08:00','10:00',2,'admin','/home/asan/asan/backend/uploads/contents/meditation/2022-01-19_10:00:50_movie.mp4','2022-01-19_10:00:50_movie.mp4','.mp4','http://172.16.41.233:3000/uploads/contents/meditation/2022-01-19_10:00:50_movie.mp4'),(3,'토끼 영상','2022-01-19 10:01:16','08:00','10:00',1,'admin','/home/asan/asan/backend/uploads/contents/meditation/2022-01-19_10:01:09_movie.mp4','2022-01-19_10:01:09_movie.mp4','.mp4','http://172.16.41.233:3000/uploads/contents/meditation/2022-01-19_10:01:09_movie.mp4');
/*!40000 ALTER TABLE `g_main_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_media`
--

DROP TABLE IF EXISTS `g_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_media` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `stb_sn` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_media`
--

LOCK TABLES `g_media` WRITE;
/*!40000 ALTER TABLE `g_media` DISABLE KEYS */;
INSERT INTO `g_media` VALUES (1,'first media','2020-11-08 10:10:10','KSQ19880205'),(2,'second media','2020-11-11 11:11:11','KSQ19880201'),(3,'third media','2020-11-11 11:11:11','KSQ19880207');
/*!40000 ALTER TABLE `g_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_media_list`
--

DROP TABLE IF EXISTS `g_media_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_media_list` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `g_media_uid` int(11) NOT NULL,
  PRIMARY KEY (`uid`),
  KEY `sch_med` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_media_list`
--

LOCK TABLES `g_media_list` WRITE;
/*!40000 ALTER TABLE `g_media_list` DISABLE KEYS */;
INSERT INTO `g_media_list` VALUES (1,'first media list','2020-11-09 10:10:10',1),(2,'second media list','2020-11-11 11:11:11',2),(3,'third media list','2020-11-11 11:11:11',3);
/*!40000 ALTER TABLE `g_media_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_meditation`
--

DROP TABLE IF EXISTS `g_meditation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_meditation` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(30) NOT NULL,
  `regdate` datetime NOT NULL,
  `content_name` varchar(60) NOT NULL,
  `file_path` varchar(90) NOT NULL,
  `file_name` varchar(90) NOT NULL,
  `file_ext` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_meditation`
--

LOCK TABLES `g_meditation` WRITE;
/*!40000 ALTER TABLE `g_meditation` DISABLE KEYS */;
INSERT INTO `g_meditation` VALUES (1,'admin','2021-12-29 15:02:10','test1','/home/asan/asan/backend/uploads/contents/meditation/2021-12-29_15:02:10_this_is_movie.mp4','this_is_movie.mp4','.mp4'),(3,'admin','2021-12-29 15:08:10','test2','/home/asan/asan/backend/uploads/contents/meditation/2021-12-29_15:08:10_this_is_movie.mp4','this_is_movie.mp4','.mp4'),(4,'admin','2021-12-29 15:18:10','test3','/home/asan/asan/backend/uploads/contents/meditation/2021-12-29_15:18:10_this_is_movie.mp4','this_is_movie.mp4','.mp4');
/*!40000 ALTER TABLE `g_meditation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_patient`
--

DROP TABLE IF EXISTS `g_patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_patient` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `gender` varchar(30) NOT NULL,
  `age` int(11) NOT NULL,
  `dob` varchar(30) NOT NULL,
  `surgicalsite` varchar(100) NOT NULL,
  `g_surgery_uid` int(11) DEFAULT NULL,
  `surgicalname` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_patient`
--

LOCK TABLES `g_patient` WRITE;
/*!40000 ALTER TABLE `g_patient` DISABLE KEYS */;
INSERT INTO `g_patient` VALUES (1,'아무개','남성',20,'2002-01-01','폐',1,'lung surgery'),(2,'김돌복','남성',18,'2004-01-01','어깨 팔',2,'shoulder arm surgery'),(3,'김아린','여성',69,'1954-01-01','간',3,'liver cancer surgery'),(4,'최지연','여성',70,'1953-01-01','난소',4,'ovarian cancer surgery'),(5,'김웅식','여성',23,'1999-03-12','심장',5,'heart surgery'),(6,'최무식','남성',20,'2002-01-01','다리',6,'leg surgery'),(7,'한소정','여성',68,'1955-01-01','목',7,'lymphoma surgery'),(8,'상신범','남성',67,'1956-01-01','신장',8,'kidney cancer surgery');
/*!40000 ALTER TABLE `g_patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_process`
--

DROP TABLE IF EXISTS `g_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_process` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `g_surgery_uid` int(11) DEFAULT NULL,
  `name` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_process`
--

LOCK TABLES `g_process` WRITE;
/*!40000 ALTER TABLE `g_process` DISABLE KEYS */;
INSERT INTO `g_process` VALUES (1,1,'lung surgery process'),(2,2,'shoulder arm surgery process'),(3,3,'liver cancer surgery process'),(4,4,'ovarian cancer surgery process'),(5,5,'heart surgery process'),(6,6,'leg surgery process'),(7,7,'lymphoma surgery process'),(8,8,'kidney cancer surgery process');
/*!40000 ALTER TABLE `g_process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_process_list`
--

DROP TABLE IF EXISTS `g_process_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_process_list` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(100) NOT NULL,
  `g_process_uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_process_list`
--

LOCK TABLES `g_process_list` WRITE;
/*!40000 ALTER TABLE `g_process_list` DISABLE KEYS */;
INSERT INTO `g_process_list` VALUES (1,'T/O brfore ANES',1),(2,'Anesthesia',1),(3,'T/O before IND',1),(4,'Incision',1),(5,'Surgery',1),(6,'Suture',1),(7,'Wake up ANES',1),(8,'End of sergery',1),(9,'T/O brfore ANES',2),(10,'Anesthesia',2),(11,'T/O before IND',2),(12,'Incision',2),(13,'Surgery',2),(14,'Suture',2),(15,'Wake up ANES',2),(16,'End of sergery',2),(17,'T/O brfore ANES',3),(18,'Anesthesia',3),(19,'T/O before IND',3),(20,'Incision',3),(21,'Surgery',3),(22,'Suture',3),(23,'Wake up ANES',3),(24,'End of sergery',3),(25,'T/O brfore ANES',4),(26,'Anesthesia',4),(27,'T/O before IND',4),(28,'Incision',4),(29,'Surgery',4),(30,'Suture',4),(31,'Wake up ANES',4),(32,'End of sergery',4),(33,'T/O brfore ANES',5),(34,'Anesthesia',5),(35,'T/O before IND',5),(36,'Incision',5),(37,'Surgery',5),(38,'Suture',5),(39,'Wake up ANES',5),(40,'End of sergery',5),(41,'T/O brfore ANES',6),(42,'Anesthesia',6),(43,'T/O before IND',6),(44,'Incision',6),(45,'Surgery',6),(46,'Suture',6),(47,'Wake up ANES',6),(48,'End of sergery',6),(49,'T/O brfore ANES',7),(50,'Anesthesia',7),(51,'T/O before IND',7),(52,'Incision',7),(53,'Surgery',7),(54,'Suture',7),(55,'Wake up ANES',7),(56,'End of sergery',7),(57,'T/O brfore ANES',8),(58,'Anesthesia',8),(59,'T/O before IND',8),(60,'Incision',8),(61,'Surgery',8),(62,'Suture',8),(63,'Wake up ANES',8),(64,'End of sergery',8);
/*!40000 ALTER TABLE `g_process_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_schedule`
--

DROP TABLE IF EXISTS `g_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_schedule` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `stb_sn` varchar(30) NOT NULL,
  `name` varchar(60) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `start` varchar(30) NOT NULL,
  `end` varchar(30) NOT NULL,
  `main_uid` int(11) NOT NULL,
  `home_uid` int(11) NOT NULL,
  `checklist_uid` int(11) NOT NULL,
  `layout_uid` int(11) NOT NULL,
  `media_uid` int(11) NOT NULL,
  PRIMARY KEY (`uid`),
  KEY `dis_sch` (`stb_sn`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_schedule`
--

LOCK TABLES `g_schedule` WRITE;
/*!40000 ALTER TABLE `g_schedule` DISABLE KEYS */;
INSERT INTO `g_schedule` VALUES (1,'KSQ19880205','first schedule','2022-01-19 10:01:28','00:00','10:00',1,1,1,1,1),(2,'KSQ19880205','second schedule','2022-01-19 10:01:28','10:00','12:00',1,2,1,1,1),(3,'KSQ19880201','first schedule','2022-01-19 10:01:23','00:00','10:00',2,5,2,2,2),(4,'KSQ19880201','second schedule','2022-01-19 10:01:23','10:00','12:00',2,6,2,2,2),(5,'KSQ19880205','third schedule','2022-01-19 10:01:28','12:00','14:00',1,3,1,1,1),(6,'KSQ19880205','4th schedule','2022-01-19 10:01:28','14:00','23:59',1,4,1,1,1),(7,'KSQ19880201','third schedule','2022-01-19 10:01:23','12:00','14:00',2,7,2,2,2),(8,'KSQ19880201','4th schedule','2022-01-19 10:01:23','14:00','23:59',2,8,2,2,2);
/*!40000 ALTER TABLE `g_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_staff`
--

DROP TABLE IF EXISTS `g_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_staff` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `position` varchar(30) NOT NULL,
  `g_surgery_uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_staff`
--

LOCK TABLES `g_staff` WRITE;
/*!40000 ALTER TABLE `g_staff` DISABLE KEYS */;
INSERT INTO `g_staff` VALUES (1,'김개단','operator',1),(2,'김용손','surgical assistant',1),(3,'김순양','scrub nurse',1),(4,'김용식','circulating nurse',1),(5,'김달','anesthesiologist',1),(6,'최민준','operator',2),(7,'최서준','surgical assistant',2),(8,'최예준','scrub nurse',2),(9,'최도윤','circulating nurse',2),(10,'최시우','anesthesiologist',2),(11,'조주원','operator',3),(12,'조하준','surgical assistant',3),(13,'조지호','scrub nurse',3),(14,'조지후','circulating nurse',3),(15,'조준서','anesthesiologist',3),(16,'안현우','operator',4),(17,'안도현','surgical assistant',4),(18,'안지훈','scrub nurse',4),(19,'안건우','circulating nurse',4),(20,'안우진','anesthesiologist',4),(21,'한가이','operator',5),(22,'한나린','surgical assistant',5),(23,'한다슬','scrub nurse',5),(24,'한라나','circulating nurse',5),(25,'한마후','anesthesiologist',5),(26,'임가인','operator',6),(27,'임나샘','surgical assistant',6),(28,'임다온','scrub nurse',6),(29,'임라윤','circulating nurse',6),(30,'임민슬','anesthesiologist',6),(31,'박다히','operator',7),(32,'박민하','surgical assistant',7),(33,'박민예','scrub nurse',7),(34,'박루리','circulating nurse',7),(35,'이규아','anesthesiologist',7),(36,'이규하','operator',8),(37,'이그리','surgical assistant',8),(38,'이늘봄','scrub nurse',8),(39,'이드리','circulating nurse',8),(40,'이다흰','anesthesiologist',8);
/*!40000 ALTER TABLE `g_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_stb`
--

DROP TABLE IF EXISTS `g_stb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_stb` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `main_stb_sn` varchar(30) NOT NULL,
  `sub_stb_sn` varchar(30) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `network_status` enum('Y','N') DEFAULT 'N',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_stb`
--

LOCK TABLES `g_stb` WRITE;
/*!40000 ALTER TABLE `g_stb` DISABLE KEYS */;
INSERT INTO `g_stb` VALUES (1,'KSQ19880205','KSQ19880204','2022-01-19 09:13:09','N'),(2,'KSQ19880201','KSQ19880202','2022-01-19 03:56:29','N'),(3,'F20020Y0057','test','2022-01-19 09:31:40','Y');
/*!40000 ALTER TABLE `g_stb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_surgery`
--

DROP TABLE IF EXISTS `g_surgery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_surgery` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `g_main_home_uid` int(11) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_surgery`
--

LOCK TABLES `g_surgery` WRITE;
/*!40000 ALTER TABLE `g_surgery` DISABLE KEYS */;
INSERT INTO `g_surgery` VALUES (1,'lung surgery','2022-01-12 16:26:00',1),(2,'shoulder arm surgery','2022-01-12 09:24:00',2),(3,'liver cancer surgery','2022-01-12 02:22:00',3),(4,'ovarian cancer surgery','2022-01-11 19:20:00',4),(5,'heart surgery','2022-01-11 12:18:00',5),(6,'leg surgery','2022-01-11 05:16:00',6),(7,'lymphoma surgery','2022-01-10 22:14:00',7),(8,'kidney cancer surgery','2022-01-10 15:12:00',8);
/*!40000 ALTER TABLE `g_surgery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_user`
--

DROP TABLE IF EXISTS `g_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `userID` varchar(30) NOT NULL,
  `userPW` varchar(100) DEFAULT NULL,
  `salt` varchar(100) DEFAULT NULL,
  `userNAME` varchar(30) NOT NULL,
  `job_position` varchar(30) NOT NULL,
  `department` varchar(30) NOT NULL,
  `create_at` datetime DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_user`
--

LOCK TABLES `g_user` WRITE;
/*!40000 ALTER TABLE `g_user` DISABLE KEYS */;
INSERT INTO `g_user` VALUES (2,'cho','Bc0dqmyw7BLeRZiUv1rDkT4i2GBIDxvyAtMx6787KRnhxq6Qrk4KyjLNC+Yr3VBQADNLteIUWo6JFnjnFLK/Lw==','9exMaVA2elTJjxmjwzAT2CO5DQZ+jFnOHCYofhgwZkFQCbs4FeINzOPocDvXaVBArsHvUa46FFwCCnQvaqW4XA==','조윤식','교수','외과','2021-11-15 11:55:42'),(3,'cho','IN3S/3dI3W7QgLopsQUyTQcyOF3Vb0Klii10VhvwM8GkB8KVrrrEl5cJUPXnzf5IM+sKUlbMKLVjjSM1j5FzSA==','eebACgIuzKknGHbixqnd0AZwv6gdU6Ra/20DPufSuO7+Gr2x7lUqjmB0DmMj9VUK0nbG4RW+6g36Y01R1Ogtlw==','조제현','인턴','외과','2021-11-15 11:56:21'),(4,'cho','+HsBiOAyf+cgD0Oefpnwkmno6fEW/iCmBY7tU0ErcpJI0YQmLrwkqZDdP19ZoOw8T4R/Z2EqyeZXlqJI3jMBOg==','el2gNVmrUbj7GtsOk8F+MjIT79P/8gmZZvq2yx7Sjm7XCyvl56ozuNH2FALiQgm9732c4JV7X4ISUKTivRxYig==','최현주','교수','내과','2021-11-15 11:56:37'),(5,'cho','oHPwcCeigDmz7nJOiv6olrQozOy3fmRVH1eoUoqBegu9nWhTaH4O0Jl1DlYt2bStBhNQKX8wYbxVYA3WAwSfqQ==','02kz6kPWGSMw/TwYLeL31uzML7IGk56zKN3wWjZsEuQfnI7+gP6bkpE+TvrFa/21pJLYwL9EQxxBH9AMHHuNdQ==','최무안','인턴','내과','2021-11-15 11:56:57');
/*!40000 ALTER TABLE `g_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-19  1:04:28
