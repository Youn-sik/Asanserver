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
  `checklist_list_order` int(11) NOT NULL,
  `stb_sn` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_checklist`
--

LOCK TABLES `g_checklist` WRITE;
/*!40000 ALTER TABLE `g_checklist` DISABLE KEYS */;
INSERT INTO `g_checklist` VALUES (1,'first checklist','2020-11-08 10:10:10',1,1,'KSQ19880205'),(2,'second checklist','2020-11-11 11:11:11',2,2,'KSQ19880206'),(3,'third checklist','2020-11-11 11:11:11',3,3,'KSQ19880207');
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
  PRIMARY KEY (`uid`,`order`),
  KEY `sch_che` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_checklist_list`
--

LOCK TABLES `g_checklist_list` WRITE;
/*!40000 ALTER TABLE `g_checklist_list` DISABLE KEYS */;
INSERT INTO `g_checklist_list` VALUES (1,'first checklist list','2020-11-09 10:10:10',1),(2,'second checklist list','2020-11-11 11:11:11',2),(3,'third checklist list','2020-11-11 11:11:11',3);
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
INSERT INTO `g_distribution` VALUES (1,'KSQ19880205','first distribution','2020-11-08 10:10:10'),(2,'KSQ19880206','second distribution','2020-11-08 10:10:10'),(3,'KSQ19880207','third distribution','2020-11-08 10:10:10');
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
  `home_list_order` int(11) NOT NULL,
  `stb_sn` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_home`
--

LOCK TABLES `g_home` WRITE;
/*!40000 ALTER TABLE `g_home` DISABLE KEYS */;
INSERT INTO `g_home` VALUES (1,'first home','2020-11-08 10:10:10',1,1,'KSQ19880205'),(2,'second home','2020-11-11 11:11:11',2,2,'KSQ19880206'),(3,'third home','2020-11-11 11:11:11',2,3,'KSQ19880207');
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
  PRIMARY KEY (`uid`,`order`),
  KEY `sch_hom` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_home_list`
--

LOCK TABLES `g_home_list` WRITE;
/*!40000 ALTER TABLE `g_home_list` DISABLE KEYS */;
INSERT INTO `g_home_list` VALUES (1,'first home list','2020-11-09 10:10:10',1,'08:00','10:00'),(2,'second home list','2020-11-11 11:11:11',2,'09:00','11:00'),(3,'third home list','2020-11-11 11:11:11',3,'10:00','12:00');
/*!40000 ALTER TABLE `g_home_list` ENABLE KEYS */;
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
  `order` int(11) NOT NULL,
  `stb_sn` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_layout`
--

LOCK TABLES `g_layout` WRITE;
/*!40000 ALTER TABLE `g_layout` DISABLE KEYS */;
INSERT INTO `g_layout` VALUES (1,'first layout','2020-11-08 10:10:10',1,'KSQ19880205'),(2,'second layout','2020-11-11 11:11:11',2,'KSQ19880206'),(3,'third layout','2020-11-11 11:11:11',3,'KSQ19880207');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_layout_list_layout`
--

LOCK TABLES `g_layout_list_layout` WRITE;
/*!40000 ALTER TABLE `g_layout_list_layout` DISABLE KEYS */;
INSERT INTO `g_layout_list_layout` VALUES (1,'layout1','2020-11-09 10:10:10','http://172.16.41.233:3000/layout/layout.png',1),(2,'layout2','2020-11-11 11:11:11','http://172.16.41.233:3000/movie/sample.mp4',2),(3,'layout3','2020-11-11 11:11:11','http://172.16.41.233:3000/music/music.mp3',3);
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
  `main_list_order` int(11) NOT NULL,
  `stb_sn` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_main`
--

LOCK TABLES `g_main` WRITE;
/*!40000 ALTER TABLE `g_main` DISABLE KEYS */;
INSERT INTO `g_main` VALUES (1,'first main','2020-11-08 10:10:10',1,1,'KSQ19880205'),(2,'second main','2020-11-11 11:11:11',2,2,'KSQ19880206'),(3,'third main','2020-11-11 11:11:11',3,3,'KSQ19880207');
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
  PRIMARY KEY (`uid`,`order`),
  KEY `sch_mai` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_main_list`
--

LOCK TABLES `g_main_list` WRITE;
/*!40000 ALTER TABLE `g_main_list` DISABLE KEYS */;
INSERT INTO `g_main_list` VALUES (1,'first main list','2020-11-09 10:10:10',1,'08:00','10:00'),(2,'second main list','2020-11-08 10:10:10',2,'09:00','11:00'),(3,'third main list','2020-11-08 10:10:10',3,'10:00','12:00'),(4,'4th main list','2020-11-08 10:10:10',4,'11:00','13:00');
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
  `media_list_order` int(11) NOT NULL,
  `stb_sn` varchar(30) NOT NULL,
  PRIMARY KEY (`uid`,`order`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_media`
--

LOCK TABLES `g_media` WRITE;
/*!40000 ALTER TABLE `g_media` DISABLE KEYS */;
INSERT INTO `g_media` VALUES (1,'first media','2020-11-08 10:10:10',1,1,'KSQ19880205'),(2,'second media','2020-11-11 11:11:11',2,2,'KSQ19880206'),(3,'third media','2020-11-11 11:11:11',3,3,'KSQ19880207');
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
  PRIMARY KEY (`uid`,`order`),
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `g_schedule`
--

LOCK TABLES `g_schedule` WRITE;
/*!40000 ALTER TABLE `g_schedule` DISABLE KEYS */;
INSERT INTO `g_schedule` VALUES (1,'KSQ19880205','first schedule','2020-11-08 10:10:10',1,'08:00','10:00','first main','first home','first checklist','first layout','first media'),(2,'KSQ19880207','second schedule','2020-11-08 10:10:10',2,'09:00','11:00','second main','second home','second checklist','second layout','second media'),(3,'KSQ19880207','thrid schedule','2020-11-08 10:10:10',3,'10:00','12:00','third main','third home','third checklist','third layout','third media'),(4,'KSQ19880207','4th schedule','2020-11-08 10:10:10',4,'11:00','13:00','4th main','4th home','4th checklist','4th layout','4th media');
/*!40000 ALTER TABLE `g_schedule` ENABLE KEYS */;
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
INSERT INTO `g_stb` VALUES (1,'KSQ19880205','KSQ19880204','2021-11-18 17:43:22','Y');
/*!40000 ALTER TABLE `g_stb` ENABLE KEYS */;
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

-- Dump completed on 2021-11-19  0:56:18
