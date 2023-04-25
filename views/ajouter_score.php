<?php
include('../models/connect.php');

$pseudo = $_SESSION['user']['pseudo_utilisateur'];
$score = $_POST['score'];
// Récupérer le score actuel du joueur avant de le mettre à jour
$requete = "SELECT score FROM mastermind_scores WHERE pseudo_joueur = :pseudo_joueur";
$statement = $db->prepare($requete);
//  Ajouter un paramètre à la requête
$statement->bindParam(':pseudo_joueur', $pseudo, PDO::PARAM_STR);
// Execution de la requête
$statement->execute();
// Récupération du score actuel du joueur avec fetchColumn()
$currentScore = $statement->fetchColumn();

// Requête pour mettre à jour le score du joueur :
$statement = $db->prepare("REPLACE INTO mastermind_scores(pseudo_joueur, score) VALUES (:pseudo_joueur, :score)");
$statement->execute([':pseudo_joueur' => $pseudo, ':score' => $score + $currentScore]);


