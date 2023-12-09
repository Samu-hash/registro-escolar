
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

create or replace database registro_escolar;

use registro_escolar;

--
-- Table structure for table `catalogo_tipos_notas_actividades`
--

DROP TABLE IF EXISTS `catalogo_tipos_notas_actividades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogo_tipos_notas_actividades` (
  `tipo_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_tipo` varchar(50) DEFAULT NULL,
  `estado` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`tipo_id`),
  UNIQUE KEY `nombre_tipo` (`nombre_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catalogo_tipos_notas_actividades`
--

LOCK TABLES `catalogo_tipos_notas_actividades` WRITE;
/*!40000 ALTER TABLE `catalogo_tipos_notas_actividades` DISABLE KEYS */;
INSERT INTO `catalogo_tipos_notas_actividades` VALUES (1,'Examen','PENDIENTE');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciclos`
--

LOCK TABLES `ciclos` WRITE;
/*!40000 ALTER TABLE `ciclos` DISABLE KEYS */;
INSERT INTO `ciclos` VALUES (1,'N/A',NULL,'ACTIVO'),(2,'CICLO  2 2023',202302,'ACTIVO'),(3,'Ciclo 24',202401,'INACTIVO'),(4,'CICLO 1 2023',202301,'ACTIVO');
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
  `estado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`inscripcion_id`),
  KEY `user_id` (`user_id`),
  KEY `materia_en_ciclo_id` (`materia_en_ciclo_id`),
  CONSTRAINT `inscripciones_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`user_id`),
  CONSTRAINT `inscripciones_ibfk_2` FOREIGN KEY (`materia_en_ciclo_id`) REFERENCES `materias_en_ciclos` (`materia_en_ciclo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `estado` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`materia_id`),
  KEY `docente_id` (`docente_id`),
  CONSTRAINT `materias_ibfk_1` FOREIGN KEY (`docente_id`) REFERENCES `usuarios` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `estado` varchar(10) DEFAULT NULL,
  `periodo_ini` date DEFAULT NULL,
  `periodo_end` date DEFAULT NULL,
  PRIMARY KEY (`materia_en_ciclo_id`),
  KEY `materia_id` (`materia_id`),
  KEY `ciclo_id` (`ciclo_id`),
  CONSTRAINT `materias_en_ciclos_ibfk_1` FOREIGN KEY (`materia_id`) REFERENCES `materias` (`materia_id`),
  CONSTRAINT `materias_en_ciclos_ibfk_2` FOREIGN KEY (`ciclo_id`) REFERENCES `ciclos` (`ciclo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
-- Table structure for table `opciones`
--

DROP TABLE IF EXISTS `opciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opciones` (
  `id_opcion` int(11) NOT NULL AUTO_INCREMENT,
  `icono_menu` varchar(50) NOT NULL,
  `url_relativo` varchar(150) NOT NULL,
  `nombre_opcion` varchar(75) NOT NULL,
  `estado` varchar(50) NOT NULL,
  PRIMARY KEY (`id_opcion`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opciones`
--

LOCK TABLES `opciones` WRITE;
/*!40000 ALTER TABLE `opciones` DISABLE KEYS */;
INSERT INTO `opciones` VALUES (1,'fas fa-fw fa-user','/RegistroEscolar/UsuariosController','Usuarios','ACTIVO'),(2,'fas fa-fw fa-circle','/RegistroEscolar/CiclosController','Ciclos','ACTIVO'),(3,'fas fa-fw fa-book','/RegistroEscolar/MateriasController','Materias','ACTIVO'),(4,'fas fa-fw fa-list-alt','/RegistroEscolar/TipoActividadController','Tipo Actividad','ACTIVO'),(5,'fas fa-fw fa-list-alt','/RegistroEscolar/MateriasCiclosController','Materias Ciclos','ACTIVO'),(6,'fas fa-fw fa-list-alt','/RegistroEscolar/InscripcionesController','Inscripciones','ACTIVO');
/*!40000 ALTER TABLE `opciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opciones_usuarios`
--

DROP TABLE IF EXISTS `opciones_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opciones_usuarios` (
  `id_optiones_usuarios` int(11) NOT NULL AUTO_INCREMENT,
  `id_opcion` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `estado` varchar(50) NOT NULL,
  PRIMARY KEY (`id_optiones_usuarios`),
  KEY `user_id` (`user_id`),
  KEY `opciones_usuarios_FK` (`id_opcion`),
  CONSTRAINT `opciones_usuarios_FK` FOREIGN KEY (`id_opcion`) REFERENCES `opciones` (`id_opcion`),
  CONSTRAINT `opciones_usuarios_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opciones_usuarios`
--

LOCK TABLES `opciones_usuarios` WRITE;
/*!40000 ALTER TABLE `opciones_usuarios` DISABLE KEYS */;
INSERT INTO `opciones_usuarios` VALUES (1,1,1,'ACTIVO'),(2,2,1,'ACTIVO'),(3,3,1,'ACTIVO'),(4,4,1,'ACTIVO'),(5,5,1,'ACTIVO'),(6,6,1,'ACTIVO');
/*!40000 ALTER TABLE `opciones_usuarios` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Marvin','Guzman','mar@mar.com','samu2332',0,'PENDIENTE',1,'ADMINISTRADOR','ACTIVO');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_user_opciones
AFTER INSERT
ON usuarios 
FOR EACH row
begin
	
	if (new.role = 'ALUMNO') then
		begin
			insert into opciones_usuarios(id_opcion, user_id, estado) values(6, new.user_id, 'ACTIVO');
		end;
	elseif (new.role = 'DOCENTE') then
		begin
			insert into opciones_usuarios(id_opcion, user_id, estado) values(3, new.user_id, 'ACTIVO');
		end;
	elseif (new.role = 'ADMINISTRADOR') then
		begin
			insert into opciones_usuarios(id_opcion, user_id, estado) values(1, new.user_id, 'ACTIVO'),
			(2, new.user_id, 'ACTIVO'),(3, new.user_id, 'ACTIVO'),(4, new.user_id, 'ACTIVO'),
			(5, new.user_id, 'ACTIVO'),(6, new.user_id, 'ACTIVO');
		end;
	end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER tr_update_user_opt
AFTER update 
ON usuarios FOR EACH ROW
begin 
	
	delete from opciones_usuarios where user_id = new.user_id;

	if (new.role = 'ALUMNO') then
		begin
			insert into opciones_usuarios(id_opcion, user_id, estado) values(6, new.user_id, 'ACTIVO');
		end;
	elseif (new.role = 'DOCENTE') then
		begin
			insert into opciones_usuarios(id_opcion, user_id, estado) values(3, new.user_id, 'ACTIVO');
		end;
	elseif (new.role = 'ADMINISTRADOR') then
		begin
			insert into opciones_usuarios(id_opcion, user_id, estado) values(1, new.user_id, 'ACTIVO'),
			(2, new.user_id, 'ACTIVO'),(3, new.user_id, 'ACTIVO'),(4, new.user_id, 'ACTIVO'),
			(5, new.user_id, 'ACTIVO'),(6, new.user_id, 'ACTIVO');
		end;
	end if;
	
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'registro_escolar'
--

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

-- Dump completed on 2023-12-09 10:45:11
