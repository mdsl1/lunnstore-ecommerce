-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: lunnstore_db
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `estoque`
--

DROP TABLE IF EXISTS `estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estoque` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_produto` int NOT NULL,
  `qtde` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_produto` (`id_produto`),
  CONSTRAINT `estoque_ibfk_1` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoque`
--

LOCK TABLES `estoque` WRITE;
/*!40000 ALTER TABLE `estoque` DISABLE KEYS */;
INSERT INTO `estoque` VALUES (1,1,50),(2,2,50),(3,3,50);
/*!40000 ALTER TABLE `estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_pedido`
--

DROP TABLE IF EXISTS `item_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_pedido` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int NOT NULL,
  `id_produto` int NOT NULL,
  `qtde` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_produto` (`id_produto`),
  CONSTRAINT `item_pedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id`),
  CONSTRAINT `item_pedido_ibfk_2` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_pedido`
--

LOCK TABLES `item_pedido` WRITE;
/*!40000 ALTER TABLE `item_pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lista_desejos`
--

DROP TABLE IF EXISTS `lista_desejos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lista_desejos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_produto` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_produto` (`id_produto`),
  CONSTRAINT `lista_desejos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `lista_desejos_ibfk_2` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lista_desejos`
--

LOCK TABLES `lista_desejos` WRITE;
/*!40000 ALTER TABLE `lista_desejos` DISABLE KEYS */;
/*!40000 ALTER TABLE `lista_desejos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `data_pedido` datetime DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(10,2) DEFAULT NULL,
  `forma_pagamento` enum('pix','a vista','parcelado') DEFAULT NULL,
  `num_parcelas` int DEFAULT '0',
  `status` enum('Em andamento','Finalizado','Cancelado') DEFAULT 'Em andamento',
  `data_final` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto_banner`
--

DROP TABLE IF EXISTS `produto_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto_banner` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_produto` int NOT NULL,
  `url_img` varchar(255) DEFAULT NULL,
  `titulo_banner` varchar(255) DEFAULT NULL,
  `cta_banner` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_produto` (`id_produto`),
  CONSTRAINT `produto_banner_ibfk_1` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto_banner`
--

LOCK TABLES `produto_banner` WRITE;
/*!40000 ALTER TABLE `produto_banner` DISABLE KEYS */;
INSERT INTO `produto_banner` VALUES (1,1,'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwbd472d1e/produto-joia/background/desktop/204451.jpg','Novo Luna Nuit','Uma fragrância marcante e misteriosa como a noite.'),(2,2,'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwd9c69f1f/produto-joia/background/desktop/128756.jpg','O Clássico está de Volta','A fragrância icônica de Una Blush em uma edição especial.'),(3,3,'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dw599c7f9f/produto-joia/background/desktop/184485.jpg','O aroma do Homem #Urbano','Uma fragrância poderosa para o homem Urbano.');
/*!40000 ALTER TABLE `produto_banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto_imagens`
--

DROP TABLE IF EXISTS `produto_imagens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto_imagens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_produto` int NOT NULL,
  `url_img` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_produto` (`id_produto`),
  CONSTRAINT `produto_imagens_ibfk_1` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto_imagens`
--

LOCK TABLES `produto_imagens` WRITE;
/*!40000 ALTER TABLE `produto_imagens` DISABLE KEYS */;
INSERT INTO `produto_imagens` VALUES (1,1,'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwd35e1530/Produtos/NATBRA-204451_1.jpg'),(2,1,'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwbf5281c8/produto-joia/background/mobile/204451.jpg'),(3,2,'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dw4a0dd86a/Produtos/PRODUTO/NATBRA-128756_2.jpg'),(4,2,'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwcbb93353/produto-joia/background/mobile/128756.jpg'),(5,3,'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dw9e7d6e91/NATBRA-184485_1.jpg'),(6,3,'https://production.na01.natura.com/on/demandware.static/-/Sites-natura-br-storefront-catalog/default/dwd4d9a18c/produto-joia/background/mobile/184485.jpg');
/*!40000 ALTER TABLE `produto_imagens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `percentual_desconto` int DEFAULT '0',
  `descricao` text NOT NULL,
  `categoria` varchar(100) NOT NULL,
  `is_ativo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'Luna Nuit',124.90,0,'Luna Nuit exalta o poder feminino, uma fragrância marcante e misteriosa como a noite. Vai do calor do âmbar para o amadeirado e surpreende com um toque floral, revelando uma fragrância sofisticada e apaixonante. Irradia a paixão da mulher confiante que expressa sua autenticidade.','feminino',1),(2,'Una Blush',319.90,0,'A fragrância icônica de Una Blush em uma edição especial com embalagem colecionável. Inspirado no elegante retorno do brilho à maquiagem e perfumaria, o Deo Parfum Una Blush traz a sofisticação da flor de laranjeira e um toque único do breu branco.','feminino',1),(3,'Urbano',168.90,0,'Fragrância poderosa para o homem urbano. Amadeirado com notas cítricas e especiadas. Combinação única do akigalawood, ingrediente amadeirado inédito na Perfumaria mundial.','masculino',1);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tabela_fretes`
--

DROP TABLE IF EXISTS `tabela_fretes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tabela_fretes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `faixa_cep` char(1) NOT NULL,
  `regiao` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tabela_fretes`
--

LOCK TABLES `tabela_fretes` WRITE;
/*!40000 ALTER TABLE `tabela_fretes` DISABLE KEYS */;
INSERT INTO `tabela_fretes` VALUES (1,'A','São Paulo'),(2,'A','Rio de Janeiro'),(3,'A','Minas Gerais'),(4,'A','Paraná'),(5,'B','Mato Grosso do Sul'),(6,'B','Santa Catarina'),(7,'B','Espírito Santo'),(8,'B','Goiás'),(9,'C','Distrito Federal'),(10,'C','Rio Grande do Sul'),(11,'C','Mato Grosso'),(12,'D','Bahia'),(13,'D','Tocantins'),(14,'E','Sergipe'),(15,'E','Alagoas'),(16,'E','Pernambuco'),(17,'F','Ceará'),(18,'F','Paraíba'),(19,'F','Rio Grande do Norte'),(20,'F','Maranhão'),(21,'F','Piauí'),(22,'G','Pará'),(23,'G','Rondônia'),(24,'G','Amazonas'),(25,'G','Amapá'),(26,'H','Acre'),(27,'H','Roraima');
/*!40000 ALTER TABLE `tabela_fretes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_cartoes`
--

DROP TABLE IF EXISTS `usuario_cartoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_cartoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `token_pagamento` varchar(255) NOT NULL,
  `bandeira` varchar(20) NOT NULL,
  `last_4_digitos` char(4) NOT NULL,
  `data_expiracao` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_pagamento` (`token_pagamento`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `usuario_cartoes_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_cartoes`
--

LOCK TABLES `usuario_cartoes` WRITE;
/*!40000 ALTER TABLE `usuario_cartoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario_cartoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `cep` varchar(8) NOT NULL,
  `numero` int NOT NULL,
  `is_adm` tinyint(1) NOT NULL DEFAULT '0',
  `is_ativo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Administrador da Silva','aaa@gmail.com','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92','17512757',100,1,1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_1st_img_produto`
--

DROP TABLE IF EXISTS `vw_1st_img_produto`;
/*!50001 DROP VIEW IF EXISTS `vw_1st_img_produto`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_1st_img_produto` AS SELECT 
 1 AS `id_produto`,
 1 AS `url`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_banner_produto`
--

DROP TABLE IF EXISTS `vw_banner_produto`;
/*!50001 DROP VIEW IF EXISTS `vw_banner_produto`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_banner_produto` AS SELECT 
 1 AS `id_produto`,
 1 AS `url`,
 1 AS `titulo`,
 1 AS `cta`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_overall_produtos`
--

DROP TABLE IF EXISTS `vw_overall_produtos`;
/*!50001 DROP VIEW IF EXISTS `vw_overall_produtos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_overall_produtos` AS SELECT 
 1 AS `id`,
 1 AS `nome`,
 1 AS `preco`,
 1 AS `percentual_desconto`,
 1 AS `preco_final`,
 1 AS `categoria`,
 1 AS `estoque_atual`,
 1 AS `total_em_estoque`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_produtos_vitrine`
--

DROP TABLE IF EXISTS `vw_produtos_vitrine`;
/*!50001 DROP VIEW IF EXISTS `vw_produtos_vitrine`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_produtos_vitrine` AS SELECT 
 1 AS `id`,
 1 AS `nome`,
 1 AS `preco`,
 1 AS `percentual_desconto`,
 1 AS `preco_final`,
 1 AS `descricao_full`,
 1 AS `descricao`,
 1 AS `categoria`,
 1 AS `url_imagem_capa`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_tabela_frete`
--

DROP TABLE IF EXISTS `vw_tabela_frete`;
/*!50001 DROP VIEW IF EXISTS `vw_tabela_frete`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_tabela_frete` AS SELECT 
 1 AS `id`,
 1 AS `faixa_cep`,
 1 AS `regiao`,
 1 AS `preco`,
 1 AS `prazo`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `zonas_frete`
--

DROP TABLE IF EXISTS `zonas_frete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zonas_frete` (
  `faixa` char(1) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `prazo_dias_uteis` int NOT NULL,
  PRIMARY KEY (`faixa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zonas_frete`
--

LOCK TABLES `zonas_frete` WRITE;
/*!40000 ALTER TABLE `zonas_frete` DISABLE KEYS */;
INSERT INTO `zonas_frete` VALUES ('A',15.00,2),('B',25.00,5),('C',35.00,7),('D',45.00,10),('E',55.00,12),('F',65.00,15),('G',85.00,22),('H',110.00,30);
/*!40000 ALTER TABLE `zonas_frete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `vw_1st_img_produto`
--

/*!50001 DROP VIEW IF EXISTS `vw_1st_img_produto`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_1st_img_produto` AS select `subquery`.`id_produto` AS `id_produto`,`subquery`.`url` AS `url` from (select `pi`.`id_produto` AS `id_produto`,`pi`.`url_img` AS `url`,row_number() OVER (PARTITION BY `pi`.`id_produto` ORDER BY `pi`.`id` )  AS `rnk` from (`produto_imagens` `pi` join `produtos` `p` on((`p`.`id` = `pi`.`id_produto`))) where (`p`.`is_ativo` = 1)) `subquery` where (`subquery`.`rnk` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_banner_produto`
--

/*!50001 DROP VIEW IF EXISTS `vw_banner_produto`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_banner_produto` AS select `pb`.`id_produto` AS `id_produto`,`pb`.`url_img` AS `url`,`pb`.`titulo_banner` AS `titulo`,`pb`.`cta_banner` AS `cta` from (`produto_banner` `pb` join `produtos` `p` on((`p`.`id` = `pb`.`id_produto`))) where (`p`.`is_ativo` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_overall_produtos`
--

/*!50001 DROP VIEW IF EXISTS `vw_overall_produtos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_overall_produtos` AS select `p`.`id` AS `id`,`p`.`nome` AS `nome`,`p`.`preco` AS `preco`,`p`.`percentual_desconto` AS `percentual_desconto`,(`p`.`preco` * (1 - (`p`.`percentual_desconto` / 100))) AS `preco_final`,`p`.`categoria` AS `categoria`,`e`.`qtde` AS `estoque_atual`,(`p`.`preco` * `e`.`qtde`) AS `total_em_estoque` from (`produtos` `p` left join `estoque` `e` on((`p`.`id` = `e`.`id_produto`))) where (`p`.`is_ativo` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_produtos_vitrine`
--

/*!50001 DROP VIEW IF EXISTS `vw_produtos_vitrine`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_produtos_vitrine` AS select `p`.`id` AS `id`,`p`.`nome` AS `nome`,`p`.`preco` AS `preco`,`p`.`percentual_desconto` AS `percentual_desconto`,round((`p`.`preco` * (1 - (`p`.`percentual_desconto` / 100))),2) AS `preco_final`,`p`.`descricao` AS `descricao_full`,concat(left(`vbanner`.`cta`,100),'...') AS `descricao`,`p`.`categoria` AS `categoria`,`vimg`.`url` AS `url_imagem_capa` from ((`produtos` `p` left join `vw_1st_img_produto` `vimg` on((`p`.`id` = `vimg`.`id_produto`))) left join `vw_banner_produto` `vbanner` on((`p`.`id` = `vbanner`.`id_produto`))) where (`p`.`is_ativo` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_tabela_frete`
--

/*!50001 DROP VIEW IF EXISTS `vw_tabela_frete`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_tabela_frete` AS select `t`.`id` AS `id`,`t`.`faixa_cep` AS `faixa_cep`,`t`.`regiao` AS `regiao`,`z`.`preco` AS `preco`,`z`.`prazo_dias_uteis` AS `prazo` from (`tabela_fretes` `t` join `zonas_frete` `z` on((`t`.`faixa_cep` = `z`.`faixa`))) order by `z`.`preco` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-03 12:45:09
