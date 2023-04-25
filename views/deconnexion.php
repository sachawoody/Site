<?php
session_start(); // start the session
include("connect.php");

// Comme dans la page d'index, sauf qu'ici c'est forcé

session_destroy();

// Puis on redirige l'utilisateur vers la page de notre choix (ici index.php)

header("Location: ../views/index.php");

?>