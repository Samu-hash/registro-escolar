-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: registro_escolar
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.28-MariaDB

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

CREATE DATABASE `registro_escolar` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

use `registro_escolar`;

--
-- Table structure for table `catalogo_tipos_notas_actividades`
--

DROP TABLE IF EXISTS `catalogo_tipos_notas_actividades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_tipos_notas_actividades` (
  `tipo_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_tipo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tipo_id`),
  UNIQUE KEY `nombre_tipo` (`nombre_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_tipos_notas_actividades`
--

LOCK TABLES `catalogo_tipos_notas_actividades` WRITE;
/*!40000 ALTER TABLE `catalogo_tipos_notas_actividades` DISABLE KEYS */;
/*!40000 ALTER TABLE `catalogo_tipos_notas_actividades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ciclos`
--

DROP TABLE IF EXISTS `ciclos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciclos` (
  `ciclo_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_ciclo` varchar(255) DEFAULT NULL,
  `anio_academico` int(11) DEFAULT NULL,
  `estado` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ciclo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciclos`
--

LOCK TABLES `ciclos` WRITE;
/*!40000 ALTER TABLE `ciclos` DISABLE KEYS */;
INSERT INTO `ciclos` VALUES (1,'CICLO 1 2023',202301,'ACTIVO'),(2,'CICLO  2 2023',202302,'ACTIVO'),(3,'Ciclo 24',202401,'INACTIVO');
/*!40000 ALTER TABLE `ciclos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inscripciones`
--

DROP TABLE IF EXISTS `inscripciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inscripciones` (
  `inscripcion_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `materia_en_ciclo_id` int(11) DEFAULT NULL,
  `fecha_inscripcion` date DEFAULT NULL,
  PRIMARY KEY (`inscripcion_id`),
  KEY `user_id` (`user_id`),
  KEY `materia_en_ciclo_id` (`materia_en_ciclo_id`),
  CONSTRAINT `inscripciones_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`user_id`),
  CONSTRAINT `inscripciones_ibfk_2` FOREIGN KEY (`materia_en_ciclo_id`) REFERENCES `materias_en_ciclos` (`materia_en_ciclo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscripciones`
--

LOCK TABLES `inscripciones` WRITE;
/*!40000 ALTER TABLE `inscripciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `inscripciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materias`
--

DROP TABLE IF EXISTS `materias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materias` (
  `materia_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_materia` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `docente_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`materia_id`),
  KEY `docente_id` (`docente_id`),
  CONSTRAINT `materias_ibfk_1` FOREIGN KEY (`docente_id`) REFERENCES `usuarios` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materias`
--

LOCK TABLES `materias` WRITE;
/*!40000 ALTER TABLE `materias` DISABLE KEYS */;
/*!40000 ALTER TABLE `materias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materias_en_ciclos`
--

DROP TABLE IF EXISTS `materias_en_ciclos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materias_en_ciclos` (
  `materia_en_ciclo_id` int(11) NOT NULL AUTO_INCREMENT,
  `materia_id` int(11) DEFAULT NULL,
  `ciclo_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`materia_en_ciclo_id`),
  KEY `materia_id` (`materia_id`),
  KEY `ciclo_id` (`ciclo_id`),
  CONSTRAINT `materias_en_ciclos_ibfk_1` FOREIGN KEY (`materia_id`) REFERENCES `materias` (`materia_id`),
  CONSTRAINT `materias_en_ciclos_ibfk_2` FOREIGN KEY (`ciclo_id`) REFERENCES `ciclos` (`ciclo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materias_en_ciclos`
--

LOCK TABLES `materias_en_ciclos` WRITE;
/*!40000 ALTER TABLE `materias_en_ciclos` DISABLE KEYS */;
/*!40000 ALTER TABLE `materias_en_ciclos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas_actividades`
--

DROP TABLE IF EXISTS `notas_actividades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notas_actividades` (
  `nota_actividad_id` int(11) NOT NULL AUTO_INCREMENT,
  `inscripcion_id` int(11) DEFAULT NULL,
  `tipo_id` int(11) DEFAULT NULL,
  `valor` float DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`nota_actividad_id`),
  KEY `inscripcion_id` (`inscripcion_id`),
  KEY `tipo_id` (`tipo_id`),
  CONSTRAINT `notas_actividades_ibfk_1` FOREIGN KEY (`inscripcion_id`) REFERENCES `inscripciones` (`inscripcion_id`),
  CONSTRAINT `notas_actividades_ibfk_2` FOREIGN KEY (`tipo_id`) REFERENCES `catalogo_tipos_notas_actividades` (`tipo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas_actividades`
--

LOCK TABLES `notas_actividades` WRITE;
/*!40000 ALTER TABLE `notas_actividades` DISABLE KEYS */;
/*!40000 ALTER TABLE `notas_actividades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `correo_electronico` varchar(255) DEFAULT NULL,
  `contrasena` varchar(255) DEFAULT NULL,
  `es_docente` tinyint(1) DEFAULT NULL,
  `estado_pago` varchar(20) DEFAULT NULL,
  `ciclo_actual` int(11) DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL,
  `estado_usuario` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `correo_electronico` (`correo_electronico`),
  KEY `ciclo_actual` (`ciclo_actual`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`ciclo_actual`) REFERENCES `ciclos` (`ciclo_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Samuel','Alvarado','samu@samu.com','samu2332',0,'PENDIENTE',1,'ADMINISTRADOR','ACTIVO'),(2,'Wilfredo','Salazar','wil@gmail.com','wil2332',0,'PENDIENTE',1,'ALUMNO','ACTIVO'),(3,'Janeth','Gomez','jk@gmail.com','janeth',1,'PENDIENTE',1,'DOCENTE','PENDIENTE APROV');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'registro_escolar'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-19  8:30:23
