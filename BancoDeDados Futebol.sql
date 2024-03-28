-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3308
-- Tempo de geração: 28-Mar-2024 às 00:56
-- Versão do servidor: 10.6.5-MariaDB
-- versão do PHP: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `futbol`
--

DELIMITER $$
--
-- Procedimentos
--
DROP PROCEDURE IF EXISTS `atualizaTime`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `atualizaTime` (IN `timeA` VARCHAR(100), IN `golsA` INT, IN `timeB` VARCHAR(100), IN `golsB` INT)  BEGIN
	IF (golsA > golsB) THEN
    UPDATE time
	SET pontosganhos = pontosganhos + 3,
        saldogol = saldogol + (golsA - golsB),
        qtdvitoria = qtdvitoria + 1,
        qtdjogos = qtdjogos + 1
        	WHERE time.nome LIKE timeA;
            UPDATE time
            set saldogol = saldogol - (golsA - golsB)
            WHERE time.nome LIKE timeB;
        ELSEIF(golsA < golsB) THEN
        UPDATE time
            SET pontosganhos = pontosganhos + 3,
            saldogol = saldogol + (golsB - golsA),
           	qtdvitoria = qtdvitoria + 1,
           	qtdjogos = qtdjogos + 1
        		WHERE time.nome LIKE timeB;
                UPDATE time
            set saldogol = saldogol - (golsB - golsA)
            WHERE time.nome LIKE timeA;
                ELSE             
                	UPDATE time
                    SET pontosganhos = pontosganhos + 1,
                    qtdjogos = qtdjogos + 1
                		WHERE time.nome LIKE timeA OR time.nome LIKE timeB;
                        	END IF;
                            	SELECT * FROM time;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `artilharia`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `artilharia`;
CREATE TABLE IF NOT EXISTS `artilharia` (
`nome` varchar(60)
,`nome_time` varchar(100)
,`qtygols` int(11)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `classificacao`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `classificacao`;
CREATE TABLE IF NOT EXISTS `classificacao` (
`nome` varchar(100)
,`pontosganhos` int(11)
,`qtdvitoria` int(11)
,`saldogol` int(11)
,`qtdjogos` int(11)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `estrangeiros`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `estrangeiros`;
CREATE TABLE IF NOT EXISTS `estrangeiros` (
`nome` varchar(60)
,`nome_time` varchar(100)
,`nacionalidade` varchar(45)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `jogador`
--

DROP TABLE IF EXISTS `jogador`;
CREATE TABLE IF NOT EXISTS `jogador` (
  `idjogador` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) NOT NULL,
  `qtygols` int(11) NOT NULL,
  `qtyjogos` int(11) NOT NULL,
  `qtyexpulsoes` int(11) NOT NULL,
  `time_idtime` int(11) NOT NULL,
  `nacionalidade_idnacionalidade` int(11) NOT NULL,
  PRIMARY KEY (`idjogador`),
  KEY `time_idtime` (`time_idtime`),
  KEY `nacionalidade_idnacionalidade` (`nacionalidade_idnacionalidade`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `jogador`
--

INSERT INTO `jogador` (`idjogador`, `nome`, `qtygols`, `qtyjogos`, `qtyexpulsoes`, `time_idtime`, `nacionalidade_idnacionalidade`) VALUES
(2, 'Kylian Mbappé', 320, 358, 1, 1, 3),
(3, 'Lionel Messi', 750, 800, 2, 3, 2),
(7, 'Erling Haaland', 250, 300, 1, 7, 7),
(8, 'Bruno Fernandes', 200, 250, 2, 8, 6);

-- --------------------------------------------------------

--
-- Estrutura da tabela `nacionalidade`
--

DROP TABLE IF EXISTS `nacionalidade`;
CREATE TABLE IF NOT EXISTS `nacionalidade` (
  `idnacionalidade` int(11) NOT NULL AUTO_INCREMENT,
  `nacionalidade` varchar(45) NOT NULL,
  PRIMARY KEY (`idnacionalidade`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `nacionalidade`
--

INSERT INTO `nacionalidade` (`idnacionalidade`, `nacionalidade`) VALUES
(1, 'Brasileiro'),
(2, 'Argentino'),
(3, 'Francês'),
(4, 'Polonês'),
(5, 'Egípcio'),
(6, 'Português'),
(7, 'Norueguês');

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `pais`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `pais`;
CREATE TABLE IF NOT EXISTS `pais` (
`pais` varchar(2)
,`COUNT(t.pais)` bigint(21)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `time`
--

DROP TABLE IF EXISTS `time`;
CREATE TABLE IF NOT EXISTS `time` (
  `idtime` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `pais` varchar(2) NOT NULL,
  `pontosganhos` int(11) NOT NULL,
  `saldogol` int(11) NOT NULL,
  `qtdvitoria` int(11) NOT NULL,
  `qtdjogos` int(11) NOT NULL,
  PRIMARY KEY (`idtime`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `time`
--

INSERT INTO `time` (`idtime`, `nome`, `pais`, `pontosganhos`, `saldogol`, `qtdvitoria`, `qtdjogos`) VALUES
(1, 'Paris Saint-Germain', 'FR', 40, 12, 39, 26),
(2, 'Al-Hilal Saudi', 'SA', 50, 64, 23, 67),
(3, 'FC Barcelona', 'ES', 45, 39, 31, 24),
(4, 'Bayern Munich', 'DE', 50, 70, 23, 25),
(5, 'Juventus', 'IT', 55, 44, 30, 25),
(6, 'Liverpool FC', 'GB', 54, 54, 29, 26),
(7, 'Borussia Dortmund', 'DE', 44, 39, 24, 21),
(8, 'FC Porto', 'PT', 49, 47, 26, 24),
(9, 'Ajax Amsterdam', 'NL', 50, 53, 30, 23),
(10, 'AC Milan', 'IT', 46, 41, 27, 24);

-- --------------------------------------------------------

--
-- Estrutura para vista `artilharia`
--
DROP TABLE IF EXISTS `artilharia`;

DROP VIEW IF EXISTS `artilharia`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `artilharia`  AS SELECT `j`.`nome` AS `nome`, `t`.`nome` AS `nome_time`, `j`.`qtygols` AS `qtygols` FROM (`time` `t` join `jogador` `j`) WHERE `j`.`qtygols` >= 1 AND `j`.`time_idtime` = `t`.`idtime` ORDER BY `j`.`qtygols` DESC ;

-- --------------------------------------------------------

--
-- Estrutura para vista `classificacao`
--
DROP TABLE IF EXISTS `classificacao`;

DROP VIEW IF EXISTS `classificacao`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `classificacao`  AS SELECT `t`.`nome` AS `nome`, `t`.`pontosganhos` AS `pontosganhos`, `t`.`qtdvitoria` AS `qtdvitoria`, `t`.`saldogol` AS `saldogol`, `t`.`qtdjogos` AS `qtdjogos` FROM `time` AS `t` ORDER BY `t`.`pontosganhos` DESC ;

-- --------------------------------------------------------

--
-- Estrutura para vista `estrangeiros`
--
DROP TABLE IF EXISTS `estrangeiros`;

DROP VIEW IF EXISTS `estrangeiros`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `estrangeiros`  AS SELECT `j`.`nome` AS `nome`, `t`.`nome` AS `nome_time`, `n`.`nacionalidade` AS `nacionalidade` FROM ((`time` `t` join `jogador` `j`) join `nacionalidade` `n`) WHERE `n`.`idnacionalidade` <> 1 AND `j`.`time_idtime` = `t`.`idtime` AND `j`.`nacionalidade_idnacionalidade` = `n`.`idnacionalidade` ;

-- --------------------------------------------------------

--
-- Estrutura para vista `pais`
--
DROP TABLE IF EXISTS `pais`;

DROP VIEW IF EXISTS `pais`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pais`  AS SELECT `t`.`pais` AS `pais`, count(`t`.`pais`) AS `COUNT(t.pais)` FROM `time` AS `t` GROUP BY `t`.`pais` ORDER BY count(`t`.`pais`) DESC ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
