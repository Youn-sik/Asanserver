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
  `name` varchar(60) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `order` int(11) NOT NULL,
  `stb_sn` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_checklist`
--

LOCK TABLES `g_checklist` WRITE;
/*!40000 ALTER TABLE `g_checklist` DISABLE KEYS */;
INSERT INTO `g_checklist` VALUES (1,'first checklist','2020-11-08 10:10:10',1,'KSQ19880205'),(2,'second checklist','2020-11-11 11:11:11',2,'KSQ19880201'),(3,'third checklist','2020-11-11 11:11:11',3,'KSQ19880207');
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
  `name` varchar(60) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `order` int(11) NOT NULL,
  `checklist_order` int(11) DEFAULT NULL,
  `value` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`uid`,`order`),
  KEY `sch_che` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_checklist_list`
--

LOCK TABLES `g_checklist_list` WRITE;
/*!40000 ALTER TABLE `g_checklist_list` DISABLE KEYS */;
INSERT INTO `g_checklist_list` VALUES (1,'first checklist list','2020-11-09 10:10:10',1,1,''),(2,'second checklist list','2020-11-11 11:11:11',2,1,''),(3,'third checklist list','2020-11-11 11:11:11',3,2,'');
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
INSERT INTO `g_distribution` VALUES (1,'KSQ19880205','first distribution','2020-11-08 10:10:10'),(2,'KSQ19880201','second distribution','2020-11-08 10:10:10'),(3,'KSQ19880207','third distribution','2020-11-08 10:10:10');
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
  `order` int(11) NOT NULL,
  `stb_sn` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_home`
--

LOCK TABLES `g_home` WRITE;
/*!40000 ALTER TABLE `g_home` DISABLE KEYS */;
INSERT INTO `g_home` VALUES (1,'first home','2020-11-08 10:10:10',1,'KSQ19880205'),(2,'second home','2020-11-11 11:11:11',2,'KSQ19880201'),(3,'third home','2020-11-11 11:11:11',2,'KSQ19880207');
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
  `order` int(11) NOT NULL,
  `start` varchar(30) NOT NULL,
  `end` varchar(30) NOT NULL,
  `g_home_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`uid`,`order`),
  KEY `sch_hom` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_home_list`
--

LOCK TABLES `g_home_list` WRITE;
/*!40000 ALTER TABLE `g_home_list` DISABLE KEYS */;
INSERT INTO `g_home_list` VALUES (1,'수술 이름','2020-11-09 10:10:10',1,'08:00','10:00',1),(2,'second home list','2020-11-11 11:11:11',2,'09:00','11:00',2),(3,'third home list','2020-11-11 11:11:11',3,'10:00','12:00',NULL);
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
  `order` int(11) NOT NULL,
  `thumbnail` varchar(100) DEFAULT NULL,
  `name` varchar(60) NOT NULL,
  `contents` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`uid`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_instrument`
--

LOCK TABLES `g_instrument` WRITE;
/*!40000 ALTER TABLE `g_instrument` DISABLE KEYS */;
INSERT INTO `g_instrument` VALUES (1,1,'url','Conference Call',NULL),(2,2,'url','CT',NULL),(3,3,'url','Microscope',NULL),(4,4,'url','Endoscope',NULL),(5,5,'url','PET_CT',NULL),(6,6,'url','MRI',NULL),(7,7,'url','Laparoscope',NULL),(8,8,'url','PAC',NULL),(9,9,'url','Potable XR',NULL);
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
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_layout`
--

LOCK TABLES `g_layout` WRITE;
/*!40000 ALTER TABLE `g_layout` DISABLE KEYS */;
INSERT INTO `g_layout` VALUES (1,'first layout','2021-12-06 11:11:11','KSQ19880205',1,1,'http://172.16.41.233:3000/layout_used/2021-12-07_10:44:06_first_layout_1.jpg'),(2,'second layout','2021-12-27 14:00:00','KSQ19880201',2,1,'http://172.16.41.233:3000/layout_used/2021-12-07_10:44:06_first_layout_1.jpg');
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
  `order` int(11) NOT NULL,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `content_id` int(11) DEFAULT NULL,
  `contents` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`uid`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_layout_list_define`
--

LOCK TABLES `g_layout_list_define` WRITE;
/*!40000 ALTER TABLE `g_layout_list_define` DISABLE KEYS */;
INSERT INTO `g_layout_list_define` VALUES (1,1,0,0,1920,540,1,''),(2,2,0,0,1920,540,2,''),(3,3,0,0,1920,540,3,'');
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
  `order` int(11) NOT NULL,
  PRIMARY KEY (`uid`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_layout_list_layout`
--

LOCK TABLES `g_layout_list_layout` WRITE;
/*!40000 ALTER TABLE `g_layout_list_layout` DISABLE KEYS */;
INSERT INTO `g_layout_list_layout` VALUES (1,'layout1','2020-11-09 10:10:10','http://172.16.41.233:3000/layout/layout1.png',1),(2,'layout2','2020-11-11 11:11:11','http://172.16.41.233:3000/layout/layout2.png',2),(3,'layout3','2020-11-11 11:11:11','http://172.16.41.233:3000/layout/layout3.png',3),(4,'layout4','2020-11-11 11:11:11','http://172.16.41.233:3000/layout/layout4.png',4),(5,'layout5','2020-11-11 11:11:11','http://172.16.41.233:3000/layout/layout5.png',5),(6,'layout6','2020-11-11 11:11:11','http://172.16.41.233:3000/layout/layout6.png',6);
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
  `order` int(11) NOT NULL,
  `stb_sn` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_main`
--

LOCK TABLES `g_main` WRITE;
/*!40000 ALTER TABLE `g_main` DISABLE KEYS */;
INSERT INTO `g_main` VALUES (1,'first main','2020-11-08 10:10:10',1,'KSQ19880205'),(2,'second main','2020-11-11 11:11:11',2,'KSQ19880201'),(3,'third main','2020-11-11 11:11:11',3,'KSQ19880207');
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
  `order` int(11) NOT NULL,
  `start` varchar(30) NOT NULL,
  `end` varchar(30) NOT NULL,
  `g_main_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`uid`,`order`),
  KEY `sch_mai` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_main_list`
--

LOCK TABLES `g_main_list` WRITE;
/*!40000 ALTER TABLE `g_main_list` DISABLE KEYS */;
INSERT INTO `g_main_list` VALUES (1,'first main list','2020-11-09 10:10:10',1,'08:00','10:00',1),(2,'second main list','2020-11-08 10:10:10',2,'09:00','11:00',2),(3,'third main list','2020-11-08 10:10:10',3,'10:00','12:00',3),(4,'4th main list','2020-11-08 10:10:10',4,'11:00','13:00',4);
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
  `order` int(11) NOT NULL,
  `stb_sn` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_media`
--

LOCK TABLES `g_media` WRITE;
/*!40000 ALTER TABLE `g_media` DISABLE KEYS */;
INSERT INTO `g_media` VALUES (1,'first media','2020-11-08 10:10:10',1,'KSQ19880205'),(2,'second media','2020-11-11 11:11:11',2,'KSQ19880201'),(3,'third media','2020-11-11 11:11:11',3,'KSQ19880207');
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
  `order` int(11) NOT NULL,
  `g_media_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`uid`,`order`),
  KEY `sch_med` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_media_list`
--

LOCK TABLES `g_media_list` WRITE;
/*!40000 ALTER TABLE `g_media_list` DISABLE KEYS */;
INSERT INTO `g_media_list` VALUES (1,'first media list','2020-11-09 10:10:10',1,1),(2,'second media list','2020-11-11 11:11:11',2,2),(3,'third media list','2020-11-11 11:11:11',3,3);
/*!40000 ALTER TABLE `g_media_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `g_patient`
--

DROP TABLE IF EXISTS `g_patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `g_patient` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `order` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `gender` varchar(30) NOT NULL,
  `age` int(11) NOT NULL,
  `dob` varchar(30) NOT NULL,
  `surgicalsite` varchar(100) NOT NULL,
  `g_surgery_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_patient`
--

LOCK TABLES `g_patient` WRITE;
/*!40000 ALTER TABLE `g_patient` DISABLE KEYS */;
INSERT INTO `g_patient` VALUES (1,1,1,'아무개','남성',20,'2002-01-01','폐',1),(2,2,2,'김웅식','남성',18,'2004-01-01','심장',NULL),(3,3,3,'김돌복','여성',23,'1999-03-12','어깨, 팔',NULL);
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
  `order` int(11) NOT NULL,
  `g_surgery_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_process`
--

LOCK TABLES `g_process` WRITE;
/*!40000 ALTER TABLE `g_process` DISABLE KEYS */;
INSERT INTO `g_process` VALUES (1,1,1),(2,2,NULL),(3,3,NULL);
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
  `order` int(11) NOT NULL,
  `value` varchar(100) NOT NULL,
  `process_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_process_list`
--

LOCK TABLES `g_process_list` WRITE;
/*!40000 ALTER TABLE `g_process_list` DISABLE KEYS */;
INSERT INTO `g_process_list` VALUES (1,1,'T/O brfore ANES',1),(2,2,'Anesthesia',1),(3,3,'T/O before IND',1),(4,4,'Incision',1),(5,5,'Surgery',1),(6,6,'Suture',1),(7,7,'Wake up ANES',1),(8,8,'End of sergery',1);
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
  `order` int(11) NOT NULL,
  `start` varchar(30) NOT NULL,
  `end` varchar(30) NOT NULL,
  `main_name` varchar(60) DEFAULT NULL,
  `home_name` varchar(60) DEFAULT NULL,
  `checklist_name` varchar(60) DEFAULT NULL,
  `layout_name` varchar(60) DEFAULT NULL,
  `media_name` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`uid`,`order`),
  KEY `dis_sch` (`stb_sn`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_schedule`
--

LOCK TABLES `g_schedule` WRITE;
/*!40000 ALTER TABLE `g_schedule` DISABLE KEYS */;
INSERT INTO `g_schedule` VALUES (1,'KSQ19880205','first schedule','2020-11-08 10:10:10',1,'08:00','10:00','first main','first home','first checklist','first layout','first media'),(2,'KSQ19880205','second schedule','2020-11-08 10:10:10',2,'10:00','11:00','first main','first home','first checklist','first layout','first media'),(3,'KSQ19880201','first schdule','2020-11-08 10:10:10',3,'10:00','12:00','second main','second home','second checklist','second layout','second media'),(4,'KSQ19880201','second schdule','2020-11-08 10:10:10',4,'12:00','13:00','second main','second home','second checklist','second layout','second media'),(5,'KSQ19880205','third schdule','2021-12-27 13:00:00',5,'11:00','12:00','first main','first home','first checklist','first layout','first media'),(6,'KSQ19880205','4th schedule','2021-12-27 13:00:00',6,'14:00','16:00','first main','first home','first checklist','first layout','first media'),(7,'KSQ19880201','third schedule','2021-12-27 13:00:00',7,'15:00','16:00','second main','second home','second checklist','second layout','second media'),(8,'KSQ19880201','4th schedule','2021-12-27 13:00:00',7,'17:00','18:00','second main','second home','second checklist','second layout','second media');
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
  `order` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `position` varchar(30) NOT NULL,
  `g_surgery_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_staff`
--

LOCK TABLES `g_staff` WRITE;
/*!40000 ALTER TABLE `g_staff` DISABLE KEYS */;
INSERT INTO `g_staff` VALUES (1,1,1,'김개단','operator',1),(2,2,2,'김용손','surgical assistant',1),(3,3,3,'김순양','scrub nurse',1),(4,4,4,'김용식','circulating nurse',1),(5,5,5,'김달','anesthesiologist',1),(6,6,6,'김무혁','operator',2);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_stb`
--

LOCK TABLES `g_stb` WRITE;
/*!40000 ALTER TABLE `g_stb` DISABLE KEYS */;
INSERT INTO `g_stb` VALUES (1,'KSQ19880205','KSQ19880204','2021-12-28 16:11:49','Y'),(2,'KSQ19880201','KSQ19880202','2021-12-02 15:15:15','N');
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
  `order` int(11) NOT NULL,
  `start` varchar(30) NOT NULL,
  `end` varchar(30) NOT NULL,
  `g_main_home_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`uid`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_surgery`
--

LOCK TABLES `g_surgery` WRITE;
/*!40000 ALTER TABLE `g_surgery` DISABLE KEYS */;
INSERT INTO `g_surgery` VALUES (1,'lung surgery','2020-11-29 12:34:56',1,'08:00','10:00',1),(2,'heart surgery','2020-11-29 09:14:00',2,'09:00','11:00',2),(3,'back surgery','2020-11-29 13:00:00',3,'10:00','12:00',3),(4,'brain surgery','2020-11-29 13:21:00',4,'11:00','13:00',4);
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

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `uid` int(11) DEFAULT NULL,
  `name` varchar(60) DEFAULT NULL,
  `age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,' 아무개',23),(2,'홍길동',24),(3,'김복선',31),(4,'김분선',21),(5,'김상소',21),(6,'김신고',52),(7,'김복상',41),(8,'김대성',23),(9,'김대수',52),(10,'김대신',12),(11,'김두연',42),(12,'김두안',32),(13,'김두희',35),(14,'김서희',26),(15,'김세희',12),(16,'김세은',10),(17,'김세흔',42),(18,'최대연',12),(19,'최태현',32),(20,'최윤정',12),(21,'최은정',21),(22,'최은서',30),(23,'조안지',20),(24,'조안서',21),(25,'조연서',15),(26,'조랑말',16),(27,'얼룩말',4),(28,'호랑이',6),(29,'고양이',8),(30,'강아지',9),(31,'아무개',23),(32,'홍길동',24),(33,'김복선',31),(34,'김분선',21),(35,'김상소',21),(36,'김신고',52),(37,'김복상',41),(38,'김대성',23),(39,'김대수',52),(40,'김대신',12),(41,'김두연',42),(42,'김두안',32),(43,'김두희',35),(44,'김서희',26),(45,'김세희',12),(46,'김세은',10),(47,'김세흔',42),(48,'최대연',12),(49,'최태현',32),(50,'최윤정',12),(51,'최은정',21),(52,'최은서',30),(53,'조안지',20),(54,'조안서',21),(55,'조연서',15),(56,'조랑말',16),(57,'얼룩말',4),(58,'호랑이',6),(59,'고양이',8),(60,'강아지',9);
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-12-28  7:13:26
