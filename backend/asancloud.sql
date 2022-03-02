-- MySQL dump 10.13  Distrib 5.7.37, for Linux (x86_64)
--
-- Host: localhost    Database: asancloud
-- ------------------------------------------------------
-- Server version	5.7.37-0ubuntu0.18.04.1

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
INSERT INTO `g_checklist` VALUES (1,'체크리스트','2022-02-10 13:46:21','KSQ19880205'),(2,'체크리스트','2022-03-02 11:14:56','KSQ19880201');
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
INSERT INTO `g_checklist_list` VALUES (1,'집도과 ','2022-01-12 12:00:00',1,'타임아웃 하겠습니다. 환자분 성함과 주민번호 앞자리가 어떻게 되십니까?'),(2,'환자 ','2022-01-12 12:00:00',1,'000 0000000입니다'),(3,'집도과 ','2022-01-12 12:00:00',1,'네. 무슨 수술하러 오셨나요?'),(4,'환자 ','2022-01-12 12:00:00',1,'000 수술입니다'),(5,'집도과 ','2022-01-12 12:00:00',1,'등록번호 000 000 님. 000쪽 000수술 입니다.'),(6,'마취과 의사','2022-01-12 12:00:00',1,'네. 맞습니다.'),(7,'마취회복 간호사','2022-01-12 12:00:00',1,'네. 맞습니다.'),(8,'순회 간호사','2022-01-12 12:00:00',1,'네. 맞습니다.'),(9,'마취과 의사','2022-01-12 12:00:00',1,'마취 시작합니다.'),(10,'집도과 ','2022-01-12 12:00:00',2,'타임아웃 하겠습니다. 환자분 성함과 주민번호 앞자리가 어떻게 되십니까?'),(11,'환자 ','2022-01-12 12:00:00',2,'000 0000000입니다'),(12,'집도과 ','2022-01-12 12:00:00',2,'네. 무슨 수술하러 오셨나요?'),(13,'환자 ','2022-01-12 12:00:00',2,'000 수술입니다'),(14,'집도과 ','2022-01-12 12:00:00',2,'등록번호 000 000 님. 000쪽 000수술 입니다.'),(15,'마취과 의사','2022-01-12 12:00:00',2,'네. 맞습니다.'),(16,'마취회복 간호사','2022-01-12 12:00:00',2,'네. 맞습니다.'),(17,'순회 간호사','2022-01-12 12:00:00',2,'네. 맞습니다.'),(18,'마취과 의사','2022-01-12 12:00:00',2,'마취 시작합니다.');
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
INSERT INTO `g_distribution` VALUES (1,'KSQ19880205','first distribution','2022-02-11 03:01:55'),(2,'KSQ19880201','second distribution','2022-03-02 11:14:55'),(3,'KSQ19880207','third distribution','2020-11-08 10:10:10');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_home`
--

LOCK TABLES `g_home` WRITE;
/*!40000 ALTER TABLE `g_home` DISABLE KEYS */;
INSERT INTO `g_home` VALUES (1,'Arthroscopic bankart repair and remplissage1','2022-02-10 13:46:21','KSQ19880205'),(2,'Arthroscopic superior capsular reconstruction shoulder left1','2022-02-10 13:46:21','KSQ19880205'),(3,'A/S RCR Rt.','2022-02-10 13:46:21','KSQ19880205'),(4,'Arthroscopic bankart repair and remplissage2','2022-02-10 13:46:21','KSQ19880205'),(5,'Arthroscopic superior capsular reconstruction shoulder left2','2022-02-10 13:46:21','KSQ19880205'),(6,'Arthroscopic bankart repair and remplissage1','2022-03-02 11:14:56','KSQ19880201'),(7,'Arthroscopic superior capsular reconstruction shoulder left1','2022-03-02 11:14:56','KSQ19880201'),(8,'A/S RCR Rt.','2022-03-02 11:14:56','KSQ19880201'),(9,'Arthroscopic bankart repair and remplissage2','2022-03-02 11:14:56','KSQ19880201'),(10,'Arthroscopic superior capsular reconstruction shoulder left2','2022-03-02 11:14:56','KSQ19880201');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_home_list`
--

LOCK TABLES `g_home_list` WRITE;
/*!40000 ALTER TABLE `g_home_list` DISABLE KEYS */;
INSERT INTO `g_home_list` VALUES (1,'Arthroscopic bankart repair and remplissage','2022-01-12 12:00:00',1),(2,'Arthroscopic superior capsular reconstruction shoulder left','2022-01-12 12:00:00',2),(3,'A/S RCR Rt.','2022-01-12 12:00:00',3),(4,'Arthroscopic bankart repair and remplissage','2022-01-12 12:00:00',4),(5,'Arthroscopic superior capsular reconstruction shoulder left','2022-01-12 12:00:00',5),(6,'Arthroscopic bankart repair and remplissage','2022-01-12 12:00:00',6),(7,'Arthroscopic superior capsular reconstruction shoulder left','2022-01-12 12:00:00',7),(8,'A/S RCR Rt.','2022-01-12 12:00:00',8),(9,'Arthroscopic bankart repair and remplissage','2022-01-12 12:00:00',9),(10,'Arthroscopic superior capsular reconstruction shoulder left','2022-01-12 12:00:00',10);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
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
INSERT INTO `g_main` VALUES (1,'first main','2022-02-10 13:46:21','KSQ19880205'),(2,'second main','2022-03-02 11:14:56','KSQ19880201'),(3,'third main','2022-01-10 15:34:55','F20020Y0057');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_main_list`
--

LOCK TABLES `g_main_list` WRITE;
/*!40000 ALTER TABLE `g_main_list` DISABLE KEYS */;
INSERT INTO `g_main_list` VALUES (1,'토끼 영상','2022-01-19 10:00:40','08:00','10:00',1,'admin','/home/asan/asan/backend/uploads/contents/meditation/2022-01-19_10:00:35_movie.mp4','2022-01-19_10:00:35_movie.mp4','.mp4','http://172.16.41.233:3000/uploads/contents/meditation/2022-01-19_10:00:35_movie.mp4'),(2,'토끼 영상','2022-01-19 10:00:56','08:00','10:00',2,'admin','/home/asan/asan/backend/uploads/contents/meditation/2022-01-19_10:00:50_movie.mp4','2022-01-19_10:00:50_movie.mp4','.mp4','http://172.16.41.233:3000/uploads/contents/meditation/2022-01-19_10:00:50_movie.mp4'),(3,'토끼 영상','2022-01-19 10:01:16','08:00','10:00',1,'admin','/home/asan/asan/backend/uploads/contents/meditation/2022-01-19_10:01:09_movie.mp4','2022-01-19_10:01:09_movie.mp4','.mp4','http://172.16.41.233:3000/uploads/contents/meditation/2022-01-19_10:01:09_movie.mp4'),(4,'피아노 협주곡','2022-01-24 10:00:50','08:00','10:00',2,'admin','/home/asan/asan/backend/uploads/contents/meditation/2022-01-24_10:00:39_Piano-Concerto-no.-21-in-C-major-K.-467-II.-Andante.mp3','2022-01-24_10:00:39_Piano-Concerto-no.-21-in-C-major-K.-467-II.-Andante.mp3','.mp3','http://172.16.41.233:3000/uploads/contents/meditation/2022-01-24_10:00:39_Piano-Concerto-no.-21-in-C-major-K.-467-II.-Andante.mp3');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_patient`
--

LOCK TABLES `g_patient` WRITE;
/*!40000 ALTER TABLE `g_patient` DISABLE KEYS */;
INSERT INTO `g_patient` VALUES (1,'이재운','남성',25,'35284','어깨 팔',1,'Arthroscopic bankart repair and remplissage'),(2,'방시욱','남성',24,'35674','어깨 팔',2,'Arthroscopic superior capsular reconstruction shoulder left'),(3,'김애린','여성',69,'19725','어깨 팔',3,'A/S RCR Rt.'),(4,'김대평','남성',39,'30783','어깨 팔',4,'Arthroscopic bankart repair and remplissage'),(5,'노지애','여성',70,'26822','어깨 팔',5,'Arthroscopic superior capsular reconstruction shoulder left'),(6,'이재운','남성',25,'35284','어깨 팔',6,'Arthroscopic bankart repair and remplissage'),(7,'방시욱','남성',24,'35674','어깨 팔',7,'Arthroscopic superior capsular reconstruction shoulder left'),(8,'김애린','여성',69,'19725','어깨 팔',8,'A/S RCR Rt.'),(9,'김대평','남성',39,'30783','어깨 팔',9,'Arthroscopic bankart repair and remplissage'),(10,'노지애','여성',70,'26822','어깨 팔',10,'Arthroscopic superior capsular reconstruction shoulder left');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_process`
--

LOCK TABLES `g_process` WRITE;
/*!40000 ALTER TABLE `g_process` DISABLE KEYS */;
INSERT INTO `g_process` VALUES (1,1,'shoulder arm surgery process'),(2,2,'shoulder arm surgery process'),(3,3,'shoulder arm surgery process'),(4,4,'shoulder arm surgery process'),(5,5,'shoulder arm surgery process'),(6,6,'shoulder arm surgery process'),(7,7,'shoulder arm surgery process'),(8,8,'shoulder arm surgery process'),(9,9,'shoulder arm surgery process'),(10,10,'shoulder arm surgery process');
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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_process_list`
--

LOCK TABLES `g_process_list` WRITE;
/*!40000 ALTER TABLE `g_process_list` DISABLE KEYS */;
INSERT INTO `g_process_list` VALUES (1,'T/O brfore ANES',1),(2,'Anesthesia',1),(3,'T/O before IND',1),(4,'Incision',1),(5,'Surgery',1),(6,'Suture',1),(7,'Wake up ANES',1),(8,'End of surgery',1),(9,'T/O brfore ANES',2),(10,'Anesthesia',2),(11,'T/O before IND',2),(12,'Incision',2),(13,'Surgery',2),(14,'Suture',2),(15,'Wake up ANES',2),(16,'End of surgery',2),(17,'T/O brfore ANES',3),(18,'Anesthesia',3),(19,'T/O before IND',3),(20,'Incision',3),(21,'Surgery',3),(22,'Suture',3),(23,'Wake up ANES',3),(24,'End of surgery',3),(25,'T/O brfore ANES',4),(26,'Anesthesia',4),(27,'T/O before IND',4),(28,'Incision',4),(29,'Surgery',4),(30,'Suture',4),(31,'Wake up ANES',4),(32,'End of surgery',4),(33,'T/O brfore ANES',5),(34,'Anesthesia',5),(35,'T/O before IND',5),(36,'Incision',5),(37,'Surgery',5),(38,'Suture',5),(39,'Wake up ANES',5),(40,'End of surgery',5),(41,'T/O brfore ANES',6),(42,'Anesthesia',6),(43,'T/O before IND',6),(44,'Incision',6),(45,'Surgery',6),(46,'Suture',6),(47,'Wake up ANES',6),(48,'End of surgery',6),(49,'T/O brfore ANES',7),(50,'Anesthesia',7),(51,'T/O before IND',7),(52,'Incision',7),(53,'Surgery',7),(54,'Suture',7),(55,'Wake up ANES',7),(56,'End of surgery',7),(57,'T/O brfore ANES',8),(58,'Anesthesia',8),(59,'T/O before IND',8),(60,'Incision',8),(61,'Surgery',8),(62,'Suture',8),(63,'Wake up ANES',8),(64,'End of surgery',8),(65,'T/O brfore ANES',9),(66,'Anesthesia',9),(67,'T/O before IND',9),(68,'Incision',9),(69,'Surgery',9),(70,'Suture',9),(71,'Wake up ANES',9),(72,'End of surgery',9),(73,'T/O brfore ANES',10),(74,'Anesthesia',10),(75,'T/O before IND',10),(76,'Incision',10),(77,'Surgery',10),(78,'Suture',10),(79,'Wake up ANES',10),(80,'End of surgery',10);
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_schedule`
--

LOCK TABLES `g_schedule` WRITE;
/*!40000 ALTER TABLE `g_schedule` DISABLE KEYS */;
INSERT INTO `g_schedule` VALUES (1,'KSQ19880205','first schedule','2022-03-02 11:14:56','08:00','10:00',1,1,1,1,1),(2,'KSQ19880205','second schedule','2022-03-02 11:14:56','10:00','12:00',1,2,1,1,1),(3,'KSQ19880201','first schedule','2022-03-02 11:14:56','08:00','10:00',2,6,2,2,2),(4,'KSQ19880201','second schedule','2022-03-02 11:14:56','10:00','12:00',2,7,2,2,2),(5,'KSQ19880205','third schedule','2022-03-02 11:14:56','12:00','14:00',1,3,1,1,1),(6,'KSQ19880205','4th schedule','2022-03-02 11:14:56','14:00','16:00',1,4,1,1,1),(7,'KSQ19880201','third schedule','2022-03-02 11:14:56','12:00','14:00',2,8,2,2,2),(8,'KSQ19880201','4th schedule','2022-03-02 11:14:56','14:00','16:00',2,9,2,2,2),(9,'KSQ19880205','5th schedule','2022-03-02 11:14:56','16:00','18:00',1,5,1,1,1),(10,'KSQ19880201','5th schedule','2022-03-02 11:14:56','16:00','18:00',2,10,2,2,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_staff`
--

LOCK TABLES `g_staff` WRITE;
/*!40000 ALTER TABLE `g_staff` DISABLE KEYS */;
INSERT INTO `g_staff` VALUES (1,'김석웅','Operator',1),(2,'강찬','Assistant 1',1),(3,'김용균','Assistant 2',1),(4,'김영범','Assistant 3',1),(5,'백주홍','Anesthetist',1),(6,'유태영','Scrub nurse',1),(7,'이성혁','Circulating nurse',1),(8,'김인석','Recovery room nurse',1),(9,'전정문','Operator',2),(10,'김탄형','Assistant 1',2),(11,'박지만','Assistant 2',2),(12,'김석잔','Assistant 3',2),(13,'김낙준','Anesthetist',2),(14,'정홍석','Scrub nurse',2),(15,'민융기','Circulating nurse',2),(16,'우지화','Recovery room nurse',2),(17,'이혜라','Operator',3),(18,'방민안','Assistant 1',3),(19,'김아령','Assistant 2',3),(20,'박소전','Assistant 3',3),(21,'박세준','Anesthetist',3),(22,'박형석','Scrub nurse',3),(23,'이승율','Circulating nurse',3),(24,'최우석','Recovery room nurse',3),(25,'안연선','Operator',4),(26,'임시환','Assistant 1',4),(27,'안보형','Assistant 2',4),(28,'이민홍','Assistant 3',4),(29,'김슬인','Anesthetist',4),(30,'감혜진','Scrub nurse',4),(31,'김세현','Circulating nurse',4),(32,'김희섭','Recovery room nurse',4),(33,'강의검','Operator',5),(34,'정학늬','Assistant 1',5),(35,'강혜안','Assistant 2',5),(36,'신가빈','Assistant 3',5),(37,'이아정','Anesthetist',5),(38,'최효전','Scrub nurse',5),(39,'이혜열','Circulating nurse',5),(40,'조화원','Recovery room nurse',5),(41,'김석웅','Operator',6),(42,'강찬','Assistant 1',6),(43,'김용균','Assistant 2',6),(44,'김영범','Assistant 3',6),(45,'백주홍','Anesthetist',6),(46,'유태영','Scrub nurse',6),(47,'이성혁','Circulating nurse',6),(48,'김인석','Recovery room nurse',6),(49,'전정문','Operator',7),(50,'김탄형','Assistant 1',7),(51,'박지만','Assistant 2',7),(52,'김석잔','Assistant 3',7),(53,'김낙준','Anesthetist',7),(54,'정홍석','Scrub nurse',7),(55,'민융기','Circulating nurse',7),(56,'우지화','Recovery room nurse',7),(57,'이혜라','Operator',8),(58,'방민안','Assistant 1',8),(59,'김아령','Assistant 2',8),(60,'박소전','Assistant 3',8),(61,'박세준','Anesthetist',8),(62,'박형석','Scrub nurse',8),(63,'이승율','Circulating nurse',8),(64,'최우석','Recovery room nurse',8),(65,'안연선','Operator',9),(66,'임시환','Assistant 1',9),(67,'안보형','Assistant 2',9),(68,'이민홍','Assistant 3',9),(69,'김슬인','Anesthetist',9),(70,'감혜진','Scrub nurse',9),(71,'김세현','Circulating nurse',9),(72,'김희섭','Recovery room nurse',9),(73,'강의검','Operator',10),(74,'정학늬','Assistant 1',10),(75,'강혜안','Assistant 2',10),(76,'신가빈','Assistant 3',10),(77,'이아정','Anesthetist',10),(78,'최효전','Scrub nurse',10),(79,'이혜열','Circulating nurse',10),(80,'조화원','Recovery room nurse',10);
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
INSERT INTO `g_stb` VALUES (1,'KSQ19880205','KSQ19880204','2022-02-14 08:52:23','N'),(2,'KSQ19880201','KSQ19880202','2022-03-02 10:34:14','N'),(3,'F20020Y0057','test','2022-01-27 17:43:40','N');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_surgery`
--

LOCK TABLES `g_surgery` WRITE;
/*!40000 ALTER TABLE `g_surgery` DISABLE KEYS */;
INSERT INTO `g_surgery` VALUES (1,'Arthroscopic bankart repair and remplissage','2022-01-12 12:00:00',1),(2,'Arthroscopic superior capsular reconstruction shoulder left','2022-01-12 12:00:00',2),(3,'A/S RCR Rt.','2022-01-12 12:00:00',3),(4,'Arthroscopic bankart repair and remplissage','2022-01-12 12:00:00',4),(5,'Arthroscopic superior capsular reconstruction shoulder left','2022-01-12 12:00:00',5),(6,'Arthroscopic bankart repair and remplissage','2022-01-12 12:00:00',6),(7,'Arthroscopic superior capsular reconstruction shoulder left','2022-01-12 12:00:00',7),(8,'A/S RCR Rt.','2022-01-12 12:00:00',8),(9,'Arthroscopic bankart repair and remplissage','2022-01-12 12:00:00',9),(10,'Arthroscopic superior capsular reconstruction shoulder left','2022-01-12 12:00:00',10);
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

-- Dump completed on 2022-03-02  2:18:52
