-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: graduation_prj
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `biopsy`
--

DROP TABLE IF EXISTS `biopsy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biopsy` (
  `img_id` varchar(45) NOT NULL,
  `img_name` varchar(45) NOT NULL,
  `biopsy_result` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `date/time` datetime NOT NULL,
  `directory` varchar(100) NOT NULL,
  `ID_DOCTOR` int NOT NULL,
  PRIMARY KEY (`img_id`),
  UNIQUE KEY `img_id_UNIQUE` (`img_id`),
  UNIQUE KEY `directory_UNIQUE` (`directory`),
  KEY `ID_DOCTOR_idx` (`ID_DOCTOR`),
  CONSTRAINT `FK_DOCTOR_ID` FOREIGN KEY (`ID_DOCTOR`) REFERENCES `doctor` (`ID_DOCTOR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biopsy`
--

LOCK TABLES `biopsy` WRITE;
/*!40000 ALTER TABLE `biopsy` DISABLE KEYS */;
INSERT INTO `biopsy` VALUES ('208_123_2024_16','208_123_2024_16_ G3','positive',' G3','2024-05-04 23:42:45','D:\\project\\doctor\\20835415\\208_123_2024_16_ G3.jpeg',20835415),('208_150_2024_75','208_150_2024_75_ G1','positive',' G1','2024-05-04 10:19:50','D:\\project\\doctor\\20835415\\208_150_2024_75_ G1.jpeg',20835415),('208_170_2024_95','208_170_2024_95_ G3','positive',' G3','2024-05-04 10:05:20','D:\\project\\doctor\\20835415\\208_170_2024_95_ G3.jpeg',20835415),('208_226_2024_13','208_226_2024_13_ G1','positive',' G1','2024-05-04 10:30:41','D:\\project\\doctor\\20835415\\208_226_2024_13_ G1.jpeg',20835415),('208_300_2024_44','208_300_2024_44_G1','positive','G1','2024-05-02 12:06:14','D:\\project\\doctor\\20835415\\208_300_2024_44_G1.jpeg',20835415),('208_413_2024_19','208_413_2024_19_ G1','positive',' G1','2024-05-04 10:19:49','D:\\project\\doctor\\20835415\\208_413_2024_19_ G1.jpeg',20835415),('208_413_2024_92','208_413_2024_92_G1','positive','G1','2024-05-02 11:11:04','D:\\project\\doctor\\20835415\\208_413_2024_92_G1.jpeg',20835415),('208_423_2024_13','208_423_2024_13_G1','positive','G1','2024-05-02 12:07:28','D:\\project\\doctor\\20835415\\208_423_2024_13_G1.jpeg',20835415),('208_544_2024_22','208_544_2024_22_ G2','positive',' G2','2024-05-04 10:02:22','D:\\project\\doctor\\20835415\\208_544_2024_22_ G2.jpeg',20835415),('208_569_2024_37','208_569_2024_37_ G1','positive',' G1','2024-05-04 10:19:46','D:\\project\\doctor\\20835415\\208_569_2024_37_ G1.jpeg',20835415),('208_601_2024_15','208_601_2024_15_ G3','positive',' G3','2024-05-04 10:05:22','D:\\project\\doctor\\20835415\\208_601_2024_15_ G3.jpeg',20835415),('208_601_2024_34','208_601_2024_34_G1','positive','G1','2024-05-02 12:02:15','D:\\project\\doctor\\20835415\\208_601_2024_34_G1.jpeg',20835415),('208_645_2024_32','208_645_2024_32_G2','positive','G2','2024-03-18 15:41:00','D:\\project\\doctor\\20835415\\208_645_2024_32_G2.jpeg',20835415),('208_645_2024_5','208_645_2024_5_ G2','positive',' G2','2024-05-04 10:02:44','D:\\project\\doctor\\20835415\\208_645_2024_5_ G2.jpeg',20835415),('208_645_2024_96','208_645_2024_96_G1','positive','G1','2024-03-18 15:42:07','D:\\project\\doctor\\20835415\\208_645_2024_96_G1.jpeg',20835415),('208_717_2024_64','208_717_2024_64_ G3','positive',' G3','2024-05-04 10:05:18','D:\\project\\doctor\\20835415\\208_717_2024_64_ G3.jpeg',20835415),('208_717_2024_81','208_717_2024_81_ G3','positive',' G3','2024-05-04 10:24:09','D:\\project\\doctor\\20835415\\208_717_2024_81_ G3.jpeg',20835415),('208_820_2024_3','208_820_2024_3_ G3','positive',' G3','2024-05-05 10:43:54','D:\\project\\doctor\\20835415\\208_820_2024_3_ G3.jpeg',20835415),('208_820_2024_55','208_820_2024_55_ G2','positive',' G2','2024-05-04 10:02:47','D:\\project\\doctor\\20835415\\208_820_2024_55_ G2.jpeg',20835415),('233_150_2024_53','233_150_2024_53_G3','positive','G3','2024-04-13 16:49:20','D:\\project\\doctor\\23384882\\233_150_2024_53_G3.jpeg',23384882),('233_262_2024_15','233_262_2024_15_G2','positive','G2','2024-04-13 16:53:19','D:\\project\\doctor\\23384882\\233_262_2024_15_G2.jpeg',23384882),('233_558_2024_51','233_558_2024_51_G3','positive','G3','2024-03-18 15:36:58','D:\\project\\doctor\\23384882\\233_558_2024_51_G3.jpeg',23384882),('467_369_2024_25','467_369_2024_25_ G2','positive',' G2','2024-05-05 12:13:19','D:\\project\\doctor\\46760574\\467_369_2024_25_ G2.jpeg',46760574),('467_383_2024_20','467_383_2024_20_ G3','positive',' G3','2024-05-05 12:03:06','D:\\project\\doctor\\46760574\\467_383_2024_20_ G3.jpeg',46760574),('467_544_2024_41','467_544_2024_41_G1','positive','G1','2024-03-18 15:46:57','D:\\project\\doctor\\46760574\\467_544_2024_41_G1.jpeg',46760574),('467_558_2024_13','467_558_2024_13_ G1','positive',' G1','2024-05-02 16:07:30','D:\\project\\doctor\\46760574\\467_558_2024_13_ G1.jpeg',46760574),('467_601_2024_96','467_601_2024_96_ G1','positive',' G1','2024-05-02 16:07:25','D:\\project\\doctor\\46760574\\467_601_2024_96_ G1.jpeg',46760574),('467_666_2024_14','467_666_2024_14_G2','positive','G2','2024-04-13 17:01:29','D:\\project\\doctor\\46760574\\467_666_2024_14_G2.jpeg',46760574),('467_820_2024_27','467_820_2024_27_ G3','positive',' G3','2024-05-05 12:14:24','D:\\project\\doctor\\46760574\\467_820_2024_27_ G3.jpeg',46760574),('467_820_2024_72','467_820_2024_72_ G2','positive',' G2','2024-05-05 12:14:04','D:\\project\\doctor\\46760574\\467_820_2024_72_ G2.jpeg',46760574),('467_845_2024_28','467_845_2024_28_ G1','positive',' G1','2024-05-02 16:07:32','D:\\project\\doctor\\46760574\\467_845_2024_28_ G1.jpeg',46760574);
/*!40000 ALTER TABLE `biopsy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor` (
  `ID_DOCTOR` int NOT NULL,
  `Username` varchar(45) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `National_ID` varchar(45) NOT NULL,
  `Address` varchar(45) NOT NULL,
  `Medical_Specility` varchar(45) NOT NULL,
  `Mobile_phone` varchar(45) DEFAULT NULL,
  `Email_address` varchar(45) NOT NULL,
  PRIMARY KEY (`ID_DOCTOR`),
  UNIQUE KEY `password_UNIQUE` (`Password`),
  UNIQUE KEY `id_UNIQUE` (`ID_DOCTOR`),
  UNIQUE KEY `National_ID_UNIQUE` (`National_ID`),
  UNIQUE KEY `Email_address_UNIQUE` (`Email_address`),
  UNIQUE KEY `mobile_UNIQUE` (`Mobile_phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES (20835415,'layla','l)G+@6Bw','3310974669','Tla al-Ali','Breast Cancer Specialist','079-251-6710','layla42.healthcare@gmail.com'),(23384882,'huda','h#7XIYj6','1205648633','Tla al-Ali','Breast Cancer Specialist','078-603-3956 ','huda72.healthcare@gmail.com'),(46760574,'raad','raap36fr','4102585387','Tla al-Ali','Breast Cancer Specialist','078-313-0434','raad69.healthcare@gmail.com');
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-24 19:21:13
