-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 09 mai 2023 à 09:39
-- Version du serveur : 8.0.31
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
  `id_article` int NOT NULL AUTO_INCREMENT,
  `nom_article` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `contenu_article` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_article` datetime NOT NULL,
  `id_utilisateur` int NOT NULL,
  PRIMARY KEY (`id_article`),
  KEY `fk_own_creator` (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id_category` int NOT NULL AUTO_INCREMENT,
  `nom_category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description_category` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `classements`
--

DROP TABLE IF EXISTS `classements`;
CREATE TABLE IF NOT EXISTS `classements` (
  `id_classement` int NOT NULL AUTO_INCREMENT,
  `nom_classement` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description_classement` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `top_joueurs_classement` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
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
  `id_commentaire` int NOT NULL AUTO_INCREMENT,
  `contenu_commentaire` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_commentaire` datetime NOT NULL,
  `id_article` int NOT NULL,
  `id_utilisateur` int NOT NULL,
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
  `id` int NOT NULL AUTO_INCREMENT,
  `pseudo_joueur` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `score` int NOT NULL,
  `date_time` datetime NOT NULL,
  `classement` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `echec_scores`
--

DROP TABLE IF EXISTS `echec_scores`;
CREATE TABLE IF NOT EXISTS `echec_scores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pseudo_joueur` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `score` int NOT NULL,
  `date_time` datetime NOT NULL,
  `classement` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `jeux`
--

DROP TABLE IF EXISTS `jeux`;
CREATE TABLE IF NOT EXISTS `jeux` (
  `id_jeu` int NOT NULL AUTO_INCREMENT,
  `nom_jeu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description_jeu` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `sortie_jeu` datetime NOT NULL,
  `createur_jeu` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `en_ligne_jeu` tinyint(1) NOT NULL,
  `hors_ligne_jeu` tinyint(1) NOT NULL,
  `id_category` int NOT NULL,
  PRIMARY KEY (`id_jeu`),
  KEY `fk_own_category` (`id_category`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Déchargement des données de la table `jeux`
--

INSERT INTO `jeux` (`id_jeu`, `nom_jeu`, `description_jeu`, `sortie_jeu`, `createur_jeu`, `en_ligne_jeu`, `hors_ligne_jeu`, `id_category`) VALUES
(1, 'Mastermind', 'Super jeu mastermind', '2023-02-19 16:33:42', 'Mano', 1, 1, 1),
(2, 'Morpion', 'Super jeu morpion', '2023-02-19 16:36:34', 'Mano', 1, 1, 1),
(3, 'Echec', 'Super jeu echecs.', '2023-02-19 16:39:44', 'Mano', 1, 1, 1),
(4, 'Pong', 'Super jeu pong', '2023-02-19 16:39:44', 'Mano', 1, 1, 1),
(5, 'Demineur', 'Super jeu demineur', '2023-02-19 16:39:44', 'Mano', 1, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `mastermind_scores`
--

DROP TABLE IF EXISTS `mastermind_scores`;
CREATE TABLE IF NOT EXISTS `mastermind_scores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pseudo_joueur` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `score` int DEFAULT NULL,
  `date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `classement` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pseudo_joueur` (`pseudo_joueur`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Déchargement des données de la table `mastermind_scores`
--

INSERT INTO `mastermind_scores` (`id`, `pseudo_joueur`, `score`, `date_time`, `classement`) VALUES
(2, 'lokman', 1000, '2023-02-19 18:05:43', 1),
(5, 'celofan', 2, '2023-02-19 18:12:52', 6),
(6, 'lulu', 158, '2023-02-22 15:38:30', 3),
(7, 'eva', 500, '2023-02-22 15:38:30', 2),
(31, 'mano', 550, '2023-05-08 16:15:56', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id_message` int NOT NULL AUTO_INCREMENT,
  `contenu_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_message` datetime NOT NULL,
  `id_utilisateur` int NOT NULL,
  PRIMARY KEY (`id_message`),
  KEY `fk_own_author` (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `morpion_scores`
--

DROP TABLE IF EXISTS `morpion_scores`;
CREATE TABLE IF NOT EXISTS `morpion_scores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pseudo_joueur` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `score` int NOT NULL,
  `date_time` datetime NOT NULL,
  `classement` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Déchargement des données de la table `morpion_scores`
--

INSERT INTO `morpion_scores` (`id`, `pseudo_joueur`, `score`, `date_time`, `classement`) VALUES
(1, 'mano', 123, '2023-05-08 10:18:13', NULL),
(2, 'lulu', 650, '2023-05-08 10:18:13', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `pong_scores`
--

DROP TABLE IF EXISTS `pong_scores`;
CREATE TABLE IF NOT EXISTS `pong_scores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pseudo_joueur` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `score` int NOT NULL,
  `date_time` datetime NOT NULL,
  `classement` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Déchargement des données de la table `pong_scores`
--

INSERT INTO `pong_scores` (`id`, `pseudo_joueur`, `score`, `date_time`, `classement`) VALUES
(1, 'mano', 423, '2023-05-08 14:22:23', NULL),
(2, 'lokman', 651, '2023-05-08 14:22:23', NULL),
(3, 'celofan', 654123, '2023-05-08 14:22:23', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id_role` int NOT NULL AUTO_INCREMENT,
  `nom_role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description_role` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id_utilisateur` int NOT NULL AUTO_INCREMENT,
  `pseudo_utilisateur` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `mail_utilisateur` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `password_utilisateur` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description_utilisateur` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci,
  `avatar_utilisateur` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '../img/avatar_default.png',
  `parties_utilisateur` int NOT NULL DEFAULT '0',
  `id_role` int NOT NULL,
  PRIMARY KEY (`id_utilisateur`),
  KEY `fk_own_role` (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`id_utilisateur`, `pseudo_utilisateur`, `mail_utilisateur`, `password_utilisateur`, `description_utilisateur`, `avatar_utilisateur`, `parties_utilisateur`, `id_role`) VALUES
(1, 'mano', 'mano@yahoo.fr', '123456', NULL, '../img/avatar_default.png', 150, 0),
(2, 'celofan', 'celofan@gmail.com', '1234', NULL, 'https://images-ext-1.discordapp.net/external/Jgs0FRsQKYpK-Mkq8_ShaCaBxnM71yzUo10cAn7uWNA/%3Fsize%3D4096/https/cdn.discordapp.com/avatars/371632961465876480/06971ae34774a17998a625a396d0f202.png', 500, 0),
(3, 'lokman', 'loke@gmail.com', '1234', NULL, 'https://cdn.discordapp.com/avatars/244829286903709696/7e47a67f01285d19f25ad6dde4667b9f.png', 38, 0),
(4, 'lulu', 'ludo@gmail.com', '1234', NULL, 'https://avatarfiles.alphacoders.com/181/181235.png', 59, 0),
(5, 'eva', 'Â²', '1234', NULL, 'https://xf-assets.pokecharms.com/data/attachment-files/2015/10/236933_Charmander_Picture.png', 0, 0);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `articles`
--
ALTER TABLE `articles`
  ADD CONSTRAINT `fk_own_creator` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id_utilisateur`);

--
-- Contraintes pour la table `commentaires`
--
ALTER TABLE `commentaires`
  ADD CONSTRAINT `fk_own_article` FOREIGN KEY (`id_article`) REFERENCES `articles` (`id_article`),
  ADD CONSTRAINT `fk_own_author` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id_utilisateur`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
