<?php
include('../models/connect.php');


if (!empty($_POST["form_connexion"])) {
    $select = $db->prepare("SELECT * FROM utilisateurs WHERE mail_utilisateur=:mail_utilisateur;");

    $select->bindParam(":mail_utilisateur", $_POST["form_email"]);

    $select->execute();

    // La fonction rowCount() permet de donner le nombre de lignes pour une requête

    if ($select->rowCount() === 1) {

        $user = $select->fetch(PDO::FETCH_ASSOC);

        if ($_POST["form_password"] == $user['password_utilisateur']) {

            // On affecte les données de notre utilisateur dans notre super globale $_SESSION

            $_SESSION['user'] = $user;

            // Le header permet d'effectuer une requête HTTP, la valeur Location permet la redirection vers un autre fichier
            print_r($_SESSION);
            header("Location: ../views/index.php");
        } else {
            echo ("error");
        }
    } else {
        unset($_SESSION['user']);
    }
}
