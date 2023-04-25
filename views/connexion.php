<?php
include('../models/connect.php');

?>
<h1>Connexion</h1>

<form method="post" action="../controllers/controller_connexion.php">

    <input type="hidden" name="form_connexion" value="1">

    <label for="form_email">Email:</label>

    <input type="text" name="form_email" id="form_email" placeholder="Ex: nomprenom@fournisseur.com" required>

    <label for="form_password">Mot de passe:</label>

    <input type="password" name="form_password" id="form_password" placeholder="1234" required>

    <input type="submit" value="Se connecter">

</form>

<a href="../views/inscription.php">Pas de compte ? Venez en créer un ici !</a>

<style>
    body {
        background-color: #f9f9f9;
        font-family: Arial, sans-serif;
    }

    h1 {
        text-align: center;
        margin-top: 50px;
        color: #333;
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