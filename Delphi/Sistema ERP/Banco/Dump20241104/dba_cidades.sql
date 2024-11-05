-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: dba
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cidades`
--

DROP TABLE IF EXISTS `cidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cidades` (
  `CODIGOCIDADE` int NOT NULL,
  `CIDADE` varchar(100) NOT NULL,
  `CODIGOESTADO` int NOT NULL,
  PRIMARY KEY (`CODIGOCIDADE`),
  KEY `FK_CIDADES_ESTADOS` (`CODIGOESTADO`),
  CONSTRAINT `FK_CIDADES_ESTADOS` FOREIGN KEY (`CODIGOESTADO`) REFERENCES `estados` (`CODIGOESTADO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cidades`
--

LOCK TABLES `cidades` WRITE;
/*!40000 ALTER TABLE `cidades` DISABLE KEYS */;
INSERT INTO `cidades` VALUES (1,'São Paulo',25),(2,'Campinas',25),(3,'Santos',25),(4,'Sorocaba',25),(5,'Ribeirão Preto',25),(6,'São Bernardo do Campo',25),(7,'Osasco',25),(8,'Diadema',25),(9,'Mauá',25),(10,'Bauru',25),(11,'Jundiaí',25),(12,'Piracicaba',25),(13,'São José dos Campos',25),(14,'Taboão da Serra',25),(15,'Franca',25),(16,'Carapicuíba',25),(17,'Indaiatuba',25),(18,'Atibaia',25),(19,'Barueri',25),(20,'São Vicente',25),(21,'Rio de Janeiro',19),(22,'Niterói',19),(23,'São Gonçalo',19),(24,'Duque de Caxias',19),(25,'Nova Iguaçu',19),(26,'Teresópolis',19),(27,'Petrópolis',19),(28,'Volta Redonda',19),(29,'Macaé',19),(30,'Campo Grande',19),(31,'Angra dos Reis',19),(32,'Itaboraí',19),(33,'Belford Roxo',19),(34,'Cabo Frio',19),(35,'Barra Mansa',19),(36,'Resende',19),(37,'Nilópolis',19),(38,'Queimados',19),(39,'São João de Meriti',19),(40,'Magé',19),(41,'Belo Horizonte',13),(42,'Uberlândia',13),(43,'Contagem',13),(44,'Juiz de Fora',13),(45,'Betim',13),(46,'Governador Valadares',13),(47,'Sete Lagoas',13),(48,'Ipatinga',13),(49,'Montes Claros',13),(50,'Poços de Caldas',13),(51,'Divinópolis',13),(52,'Santa Luzia',13),(53,'Timóteo',13),(54,'Nova Lima',13),(55,'Araxá',13),(56,'Barbacena',13),(57,'Teófilo Otoni',13),(58,'Sabará',13),(59,'Formiga',13),(60,'Varginha',13),(61,'Salvador',5),(62,'Feira de Santana',5),(63,'Vitória da Conquista',5),(64,'Camaçari',5),(65,'Ilhéus',5),(66,'Juazeiro',5),(67,'Lauro de Freitas',5),(68,'Itabuna',5),(69,'Jequié',5),(70,'Santo Antônio de Jesus',5),(71,'Simões Filho',5),(72,'Eunápolis',5),(73,'Porto Seguro',5),(74,'Alagoinhas',5),(75,'Barreiras',5),(76,'Teixeira de Freitas',5),(77,'Santa Maria da Vitória',5),(78,'Candeias',5),(79,'São Francisco do Conde',5),(80,'Serrinha',5),(81,'Brasília',7),(82,'Ceilândia',7),(83,'Taguatinga',7),(84,'Sobradinho',7),(85,'Planaltina',7),(86,'Samambaia',7),(87,'Gama',7),(88,'Águas Claras',7),(89,'Santa Maria',7),(90,'Lago Sul',7),(91,'Lago Norte',7),(92,'Riacho Fundo',7),(93,'Jardim Botânico',7),(94,'São Sebastião',7),(95,'Sudoeste',7),(96,'Paranoá',7),(97,'Recanto das Emas',7),(98,'Guará',7),(99,'Varjão',7),(100,'Sobradinho II',7),(101,'TESTE d\\adf',7),(102,'dfasf',1);
/*!40000 ALTER TABLE `cidades` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-04 20:42:40
