<?php
include('../models/connect.php');
include('../models/_classes.php');



?>



<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Classements</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/classement.css">

</head>

<body>

    <header>
        <?php
        include('./_navBar.php');
        ?>

    </header>

    <main>
        <h1>Inscription</h1>

        <form action="../controllers/controller_inscription.php" method="post">

            <input type="hidden" name="form_inscription" value="1">

            <label for="form_pseudo">Pseudo : </label>
            <input type="text" name="form_pseudo" placeholder="Votre pseudo sera visible par les autres joueurs." required>

            <label for="form_mail">Mail : </label>
            <input type="text" name="form_mail" placeholder="me@domaine.com" required>

            <label for="form_mail_conf">Confirmation du mail : </label>
            <input type="text" name="form_mail_conf" required>

            <label for="form_password">Mot de passe:</label>
            <input type="password" name="form_password" required>

            <label for="form_password_conf">Confirmation du mot de passe :</label>
            <input type="password" name="form_password_conf" required>

            <input type="submit" value="S'inscrire">
        </form>
        <a href="../views/connexion.php">Déjà un compte ? Connectez-vous ici !</a>


    </main>

    <footer>
        <?php
        include('./_footer.php');
        ?>
    </footer>

</body>

</html>



<style scoped>
    main {
        background-color: #B97958;
        height: auto;
    }

    h1 {
        text-align: center;
        color: white;
    }

    form {
        max-width: 500px;
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 5px;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
    }

    label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
        color: #333;
    }

    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 3px;
        font-size: 16px;
        box-sizing: border-box;
    }

    input[type="submit"] {
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 3px;
        font-size: 16px;
        cursor: pointer;
    }

    input[type="submit"]:hover {
        background-color: #3e8e41;
    }

    a {
        display: block;
        text-align: center;
        margin-top: 20px;
        color: #333;
        text-decoration: none;
    }

    @media screen and (max-width: 480px) {
        form {
            max-width: 300px;
        }
    }
</style>
