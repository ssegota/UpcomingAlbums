-- MySQL dump 10.13  Distrib 5.5.43, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: albums
-- ------------------------------------------------------
-- Server version	5.5.43-0ubuntu0.14.10.1

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
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `album` (
  `albumID` int(11) NOT NULL,
  `authorID` int(11) NOT NULL,
  `genre` text NOT NULL,
  `subgenre` varchar(60) DEFAULT NULL,
  `nofsongs` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `albumname` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`albumID`),
  KEY `authorID` (`authorID`),
  CONSTRAINT `album_ibfk_1` FOREIGN KEY (`authorID`) REFERENCES `musician` (`bandID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES (5,5,'electronic','ambient',0,'2015-06-16','mercy'),(6,6,'hip-hop','',12,'2015-06-16','dream world'),(7,7,'pop','rnr',0,'2015-06-16','super future'),(8,8,'folk','',0,'2015-06-16','labor against waste'),(9,9,'synthpop','dark wave',12,'2015-06-16','full cold moon'),(10,10,'rock','indie',8,'2015-06-16','all signs point to yes'),(11,11,'punk','hardcore',1,'2015-06-16','year of the hare'),(12,12,'blues','rock',0,'2015-06-16','the restless'),(13,13,'hip-hop','electronic',14,'2015-06-16','lantern'),(14,14,'pop','rock',14,'2015-06-16','no place in heaven'),(15,15,'pop','indie',16,'2015-06-16','youre going to make it'),(16,16,'pop','indie',0,'2015-06-16','grand romantic'),(17,17,'rock','indie',0,'2015-06-16','city of quartz'),(18,18,'pop','indie',11,'2015-06-16','the fool'),(19,19,'rock','emo',0,'2015-06-16','joy, departed'),(20,20,'rock','alternative',12,'2015-06-16','dopamine'),(21,21,'rock','indie',0,'2015-06-16','a lot of sorrow'),(22,22,'rock','surf',0,'2015-06-23','dancing at the blue lagoon'),(23,23,'punk','post',11,'2015-06-23','cemetary highrise slum'),(24,24,'punk','emo',11,'2015-06-23','payola'),(25,25,'country','americana',13,'2015-06-23','pageant material'),(26,26,'soul','gosel',3,'2015-06-23','coming home'),(27,27,'metal','industrial',10,'2015-06-23','skills in pills'),(28,28,'hip-hop','alternative',11,'2015-06-23','bones'),(29,29,'rock','alternative',5,'2015-06-23','my love is cool'),(30,30,'rock','indie',0,'2015-06-29','slow gum'),(31,31,'rock','',0,'2015-06-29','the monsanto years'),(32,32,'rock','alternative',18,'2015-06-30','the heart is a monster'),(33,33,'rock','indie',0,'2015-06-30','brain cream'),(34,34,'metal','alternative',2,'2015-06-30','bleeder'),(35,35,'punk','hardcore',0,'2015-06-30','refused'),(36,36,'punk','psych',0,'2015-06-30','galore'),(37,37,'rock','post',8,'2015-07-10','atheists cornea'),(38,38,'electronic','folktronica',2,'2015-07-10','morningevening'),(39,39,'folk','indie',0,'2015-07-10','glider'),(40,40,'electronic','pop',15,'2015-07-10','working girl'),(41,41,'hip-hop','alternative',8,'2015-07-10','every color of darkness'),(42,42,'punk','post',12,'2015-07-10','key markets'),(43,43,'pop','rnb',16,'2015-07-10','crown jewel'),(44,44,'rock','alternative',14,'2015-07-10','ghost notes'),(45,45,'folk','indie',16,'2015-07-17','archive series'),(46,46,'pop','indie',1,'2015-07-17','how does it feel'),(47,47,'punk','',12,'2015-07-17','white reaper does it again'),(48,48,'punk','',12,'2015-07-28','the most lamentable tragedy'),(49,49,'metal','heavy',15,'2015-07-31','coda'),(50,49,'metal','heavy',12,'2015-07-31','presence'),(51,49,'metal','heavy',14,'2015-07-31','in trough the out door'),(52,50,'metal','progressive',15,'2015-08-04','the hunter'),(53,51,'metal','trash',11,'2015-09-11','repentless');
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `korisnik`
--

DROP TABLE IF EXISTS `korisnik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `korisnik` (
  `userID` int(11) NOT NULL,
  `username` text NOT NULL,
  `password` text,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `korisnik`
--

LOCK TABLES `korisnik` WRITE;
/*!40000 ALTER TABLE `korisnik` DISABLE KEYS */;
INSERT INTO `korisnik` VALUES (0,'admin','nimda'),(1,'ines','javolimbp'),(2,'sandi','password'),(3,'bruno','l0veisinthe4ir'),(4,'maura','maura');
/*!40000 ALTER TABLE `korisnik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musician`
--

DROP TABLE IF EXISTS `musician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `musician` (
  `bandID` int(11) NOT NULL,
  `members` int(11) DEFAULT NULL,
  `location` text NOT NULL,
  `name` text NOT NULL,
  PRIMARY KEY (`bandID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musician`
--

LOCK TABLES `musician` WRITE;
/*!40000 ALTER TABLE `musician` DISABLE KEYS */;
INSERT INTO `musician` VALUES (1,1,'italy','giorgio moroderi'),(2,5,'england','everything everything'),(3,3,'usa','the antlers'),(4,1,'usa','yukon blonde'),(5,1,'usa','active child'),(6,1,'usa','araabmuzik'),(7,3,'usa','calvin love'),(8,1,'usa','christopher paul steling'),(9,1,'usa','cold cave'),(10,1,'usa','dave monks'),(11,6,'canada','fucked up'),(12,4,'usa','heartless bastards'),(13,1,'usa','huson mohawke'),(14,1,'lebanon','mika'),(15,2,'usa','mates of state'),(16,1,'usa','nate ruess'),(17,1,'canada','nick diamonds'),(18,1,'usa','ryn weaver'),(19,4,'usa','sorority noise'),(20,5,'usa','third blind eye'),(21,4,'usa','the national'),(22,5,'usa','cayucas'),(23,4,'usa','creepoid'),(24,4,'usa','desparecidos'),(25,1,'usa','kasey musgraves'),(26,1,'usa','leon bridges'),(27,1,'germany','lindemann'),(28,1,'usa','son lux'),(29,4,'england','wolf alice'),(30,1,'australia','fraiser a. gorman'),(31,1,'canada','neil young'),(32,3,'usa','failure'),(33,3,'usa','jaill'),(34,3,'usa','mutoid man'),(35,4,'sweden','refused'),(36,3,'usa','the hussy'),(37,5,'japan','envy'),(38,1,'england','four tet'),(39,1,'usa','heather woods'),(40,1,'england','little boots'),(41,1,'usa','prefuse 73'),(42,2,'england','sleaford mods'),(43,1,'usa','the-dream'),(44,4,'usa','veruca salt'),(45,1,'usa','iron & wine'),(46,2,'usa','ms mr'),(47,4,'usa','white reaper'),(48,5,'usa','titus andronicus'),(49,4,'england','led zeppelin'),(50,5,'usa','mastodon'),(51,4,'usa','slayer');
/*!40000 ALTER TABLE `musician` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote`
--

DROP TABLE IF EXISTS `vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vote` (
  `bandID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  PRIMARY KEY (`bandID`,`userID`),
  KEY `userID` (`userID`),
  CONSTRAINT `vote_ibfk_1` FOREIGN KEY (`bandID`) REFERENCES `musician` (`bandID`) ON DELETE CASCADE,
  CONSTRAINT `vote_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `korisnik` (`userID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote`
--

LOCK TABLES `vote` WRITE;
/*!40000 ALTER TABLE `vote` DISABLE KEYS */;
INSERT INTO `vote` VALUES (20,1,3),(20,2,5),(20,3,4),(20,4,3),(27,2,4),(49,1,5),(49,3,4),(50,1,3),(50,2,4),(51,2,5),(51,3,2);
/*!40000 ALTER TABLE `vote` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-06-16 21:26:36
