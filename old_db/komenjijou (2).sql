-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 23 fév. 2023 à 10:25
-- Version du serveur : 5.7.40
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `komenjijou`
--

-- --------------------------------------------------------

--
-- Structure de la table `articles`
--

DROP TABLE IF EXISTS `articles`;
CREATE TABLE IF NOT EXISTS `articles` (
  `id_article` int(11) NOT NULL AUTO_INCREMENT,
  `nom_article` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `contenu_article` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_article` datetime NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  PRIMARY KEY (`id_article`),
  KEY `fk_own_creator` (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id_category` int(11) NOT NULL AUTO_INCREMENT,
  `nom_category` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description_category` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `classements`
--

DROP TABLE IF EXISTS `classements`;
CREATE TABLE IF NOT EXISTS `classements` (
  `id_classement` int(11) NOT NULL AUTO_INCREMENT,
  `nom_classement` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description_classement` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `top_joueurs_classement` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id_classement`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Déchargement des données de la table `classements`
--

INSERT INTO `classements` (`id_classement`, `nom_classement`, `description_classement`, `top_joueurs_classement`) VALUES
(1, 'Mastermind', 'Ici le classement du mois pour le jeu mastermind.', 'Lokman avec 360 points<br>\nMano avec 150 points');

-- --------------------------------------------------------

--
-- Structure de la table `commentaires`
--

DROP TABLE IF EXISTS `commentaires`;
CREATE TABLE IF NOT EXISTS `commentaires` (
  `id_commentaire` int(11) NOT NULL AUTO_INCREMENT,
  `contenu_commentaire` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_commentaire` datetime NOT NULL,
  `id_article` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  PRIMARY KEY (`id_commentaire`),
  KEY `fk_own_author` (`id_utilisateur`),
  KEY `fk_own_article` (`id_article`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `demineur_scores`
--

DROP TABLE IF EXISTS `demineur_scores`;
CREATE TABLE IF NOT EXISTS `demineur_scores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pseudo_joueur` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `score` int(11) NOT NULL,
  `date_time` datetime NOT NULL,
  `classement` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `echec_scores`
--

DROP TABLE IF EXISTS `echec_scores`;
CREATE TABLE IF NOT EXISTS `echec_scores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pseudo_joueur` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `score` int(11) NOT NULL,
  `date_time` datetime NOT NULL,
  `classement` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `jeux`
--

DROP TABLE IF EXISTS `jeux`;
CREATE TABLE IF NOT EXISTS `jeux` (
  `id_jeu` int(11) NOT NULL AUTO_INCREMENT,
  `nom_jeu` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description_jeu` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `sortie_jeu` datetime NOT NULL,
  `createur_jeu` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `en_ligne_jeu` tinyint(1) NOT NULL,
  `hors_ligne_jeu` tinyint(1) NOT NULL,
  `id_category` int(11) NOT NULL,
  PRIMARY KEY (`id_jeu`),
  KEY `fk_own_category` (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Déchargement des données de la table `jeux`
--

INSERT INTO `jeux` (`id_jeu`, `nom_jeu`, `description_jeu`, `sortie_jeu`, `createur_jeu`, `en_ligne_jeu`, `hors_ligne_jeu`, `id_category`) VALUES
(1, 'Mastermind', 'C\'est un jeu pouvant se jouer tout seul ou bien à deux.\r\nLe but est de deviner la combinaison cachée.', '2023-02-19 16:33:42', 'Mano', 1, 1, 1),
(2, 'Morpion', 'Un premier joueur dessine son symbole sur une case. Puis c\'est au tour de l\'autre joueur de dessiner son symbole sur une case vide. Le but du jeu est de réussir à aligner ses trois symboles, on remporte alors la partie.', '2023-02-19 16:36:34', 'Mano', 1, 1, 1),
(3, 'Echec', 'Les joueurs jouent à tour de rôle en déplaçant des pièces. Chaque joueur possède au départ seize pièces : un roi, une dame, deux tours, deux fous, deux cavaliers et huit pions. Le but du jeu est d\'infliger un échec et mat où le roi adverse est en prise sans qu\'il soit possible d\'y remédier.', '2023-02-19 16:39:44', 'Mano', 1, 1, 1),
(4, 'Pong', 'Le concept original de Pong est un simulateur simple de ping-pong (tennis de table), reprenant le nom du jeu. Au tennis de table, les joueurs se tiennent de chaque côté d\'une table de ping-pong et manient une raquette pour frapper une petite boule entre eux dans les deux sens. Ce concept de base est celui de Pong.', '2023-02-19 16:39:44', 'Mano', 1, 1, 1),
(5, 'Demineur', 'Démineur est un jeu de réflexion pour un seul joueur dont le but est de nettoyer un champ rectangulaire contenant des mines cachées sans en faire exploser aucune. Il donne au joueur des indices basés sur la numérotation des mines voisines dans chaque champ.', '2023-02-19 16:39:44', 'Mano', 1, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `mastermind_scores`
--

DROP TABLE IF EXISTS `mastermind_scores`;
CREATE TABLE IF NOT EXISTS `mastermind_scores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pseudo_joueur` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `score` int(11) NOT NULL,
  `date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `classement` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pseudo_joueur` (`pseudo_joueur`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Déchargement des données de la table `mastermind_scores`
--

INSERT INTO `mastermind_scores` (`id`, `pseudo_joueur`, `score`, `date_time`, `classement`) VALUES
(2, 'lokman', 1000, '2023-02-19 18:05:43', 1),
(5, 'celofan', 2, '2023-02-19 18:12:52', 6),
(6, 'lulu', 158, '2023-02-22 15:38:30', 3),
(7, 'eva', 500, '2023-02-22 15:38:30', 2),
(19, 'mano', 120, '2023-02-23 11:04:11', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id_message` int(11) NOT NULL AUTO_INCREMENT,
  `contenu_message` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_message` datetime NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  PRIMARY KEY (`id_message`),
  KEY `fk_own_author` (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `morpion_scores`
--

DROP TABLE IF EXISTS `morpion_scores`;
CREATE TABLE IF NOT EXISTS `morpion_scores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pseudo_joueur` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `score` int(11) NOT NULL,
  `date_time` datetime NOT NULL,
  `classement` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pong_scores`
--

DROP TABLE IF EXISTS `pong_scores`;
CREATE TABLE IF NOT EXISTS `pong_scores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pseudo_joueur` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `score` int(11) NOT NULL,
  `date_time` datetime NOT NULL,
  `classement` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id_role` int(11) NOT NULL AUTO_INCREMENT,
  `nom_role` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description_role` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id_utilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `pseudo_utilisateur` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `mail_utilisateur` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `password_utilisateur` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description_utilisateur` text COLLATE utf8mb4_unicode_520_ci,
  `avatar_utilisateur` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '../img/avatar_default.png',
  `parties_utilisateur` int(11) NOT NULL DEFAULT '0',
  `id_role` int(11) NOT NULL,
  PRIMARY KEY (`id_utilisateur`),
  KEY `fk_own_role` (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id_utilisateur`, `pseudo_utilisateur`, `mail_utilisateur`, `password_utilisateur`, `description_utilisateur`, `avatar_utilisateur`, `parties_utilisateur`, `id_role`) VALUES
(1, 'mano', 'mano@yahoo.fr', '123456', NULL, '../img/avatar_default.png', 150, 0),
(2, 'celofan', 'celofan@gmail.com', '1234', NULL, '../img/avatar_default.png', 500, 0),
(3, 'lokman', 'loke@gmail.com', '1234', NULL, '../img/avatar_default.png', 38, 0),
(4, 'lulu', 'ludo@gmail.com', '1234', NULL, '../img/avatar_default.png', 59, 0),
(5, 'eva', 'Â²', '1234', NULL, '../img/avatar_default.png', 0, 0);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
