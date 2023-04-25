<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/mastermind.css">
    <link rel="stylesheet" href="../css/morpion.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">

</head>

<body>

    <header>
        <?php
        // ajouter le temlate navbar
        include('./_navBar.php');
        ?>

    </header>
    <!-- Grid avec le top des jeux joués -->

    <section class="best-games">
        <h2 class="best-games-title">Nos jeux les plus populaires</h2>
        <article class="grid-best-games">

        </article>
    </section>

    <!-- Footer -->
    <footer>
        <?php
        // ajouter le temlate footer
        include('./_footer.php');
        ?>
    </footer>

    <script src="../main.js"></script>


</body>



</html>