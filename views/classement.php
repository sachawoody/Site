<?php
include('../models/connect.php');

// Faire une requête sql et récupérer tout les utilisateurs et les classer (exclure si le joueur a fait 0 parties)

$utilisateurs = $db->query("SELECT * FROM utilisateurs
WHERE parties_utilisateur > 0
ORDER BY parties_utilisateur DESC;")->fetchAll(PDO::FETCH_ASSOC);

// Faire une requête pour récupérer le nom de tout les jeux disponibles
$jeux = $db->query("SELECT * FROM jeux
;")->fetchAll(PDO::FETCH_ASSOC);




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

    <section class="classement-main">
        <article class="classement-description">
            <h1>Comment fonctionne les classements ?</h1>
            <p>Notre système de classement est basé sur le ratio win + défaites / nb de parties. Néanmoins, un joueur se verra gagner plus de points lors d’une win streak. De plus, il ne peut gagner qu’un nombre limité de points par jour.</p>
        </article>
        <article class="classement-display">

            <div class="classement-games">
                <h1>Classement des joueurs avec le plus de parties</h1>

                <?php foreach ($utilisateurs as $utilisateur) {
                ?>
                    <p>
                        <!-- Afficher ici le classement des joueurs avec le plus de parties -->
                        <?= ucfirst($utilisateur['pseudo_utilisateur']) ?>
                        avec
                        <?= $utilisateur['parties_utilisateur'] ?>
                        parties
                    </p>
                <?php
                } ?>
            </div>

            <div class="classement-month">
                <?php foreach ($jeux as $jeu) {
                    // On récupère le nom du jeu et on le transforme en minuscules pour former le nom de la table
                    $game = lcfirst($jeu['nom_jeu']) . "_scores";

                    // On effectue une requête SQL pour récupérer tous les scores du jeu triés en ordre décroissant
                    $classement = $db->query("SELECT * FROM $game ORDER BY score DESC")->fetchAll(PDO::FETCH_ASSOC);
                    // Pour afficher uniquement les 10 meilleurs scores, on peut utiliser la requête SQL suivante :
                    // $classement = $db->query("SELECT * FROM $game ORDER BY score DESC LIMIT 10")->fetchAll(PDO::FETCH_ASSOC);

                    if (sizeof($classement) > 0) {
                ?>
                        <h3>Classement du jeu <?= ucfirst($jeu['nom_jeu']) ?></h3>
                        <!-- On créé maintenant un tableau pour afficher nos classements -->
                        <table>
                            <thead>
                                <tr>
                                    <!-- Création de la structure du tableau -->
                                    <th>Position</th>
                                    <th>Joueur</th>
                                    <th>Score</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Boucle for each pour créer une ligne pour chaque joueur -->

                                <?php

                                foreach ($classement as $position => $result) {
                                    // Faire une requête select préparée qui permet de récupérer l'avatar du joueur (dans cette configuration, chaque pseudo est unique)
                                    $requete = "SELECT avatar_utilisateur FROM utilisateurs WHERE pseudo_utilisateur = :pseudo_utilisateur";
                                    $statement = $db->prepare($requete);
                                    //  Ajouter un paramètre à la requête
                                    $statement->bindParam(':pseudo_utilisateur', $result['pseudo_joueur'], PDO::PARAM_STR);
                                    // Execution de la requête
                                    $statement->execute();
                                    // Récupération de l'avatar avec fetchColumn()
                                    $avatar = $statement->fetchColumn();


                                ?>
                                    <tr>
                                        <!-- Afficher son rank -->
                                        <td><?= $position + 1 ?></td>
                                        <!-- Afficher son pseudo -->
                                        <td><?= $result['pseudo_joueur'] ?></td>
                                        <!-- Afficher son score -->
                                        <td><?= $result['score'] ?></td>
                                        <td><img src="<?= $avatar ?>" alt="Avatar de <?= $result['pseudo_joueur'] ?>"></td>
                                    </tr>
                                <?php }

                                ?>

                                <?php foreach ($classement as $position => $result) {

                                    if (!empty($_SESSION['user']) and $result['pseudo_joueur'] == $_SESSION['user']['pseudo_utilisateur']) {
                                ?>
                                        <tr style="
                                background-color:blanchedalmond;
                                color: black;
                            ">
                                            <!-- Afficher son rank -->
                                            <td><?= $position + 1 ?></td>
                                            <!-- Afficher son pseudo -->
                                            <td><?= $_SESSION['user']['pseudo_utilisateur'] ?> (vous)</td>
                                            <!-- Afficher son score -->
                                            <td><?= $result['score'] ?></td>
                                            <td><img src="<?= $_SESSION['user']['avatar_utilisateur'] ?>" alt="Avatar de <?= $_SESSION['user']['pseudo_utilisateur'] ?>"></td>
                                        </tr>
                                <?php }
                                } ?>
                            </tbody>
                        </table>
                <?php }
                } ?>
            </div>

        </article>
        <!-- <article class="classement-selector">
            <select name="" id="">
                <option>Afficher le classement d'un jeu</option>

                <?php foreach ($jeux as $jeu) {
                ?>
                    <option value="option-<?= lcfirst($jeu['nom_jeu']) ?>">
                        <?= ucfirst($jeu['nom_jeu']) ?>
                    </option>
                <?php
                } ?>

            </select>
        </article> -->

    </section>

    <footer>
        <?php
        include('./_footer.php');
        ?>
    </footer>

</body>

</html>