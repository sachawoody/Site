<?php
include('../models/connect.php');
?>


<nav class="nav-header">
    <a href="../views/index.php" class="to-logo"><img src="../img/logo.png" alt="Logo principal" class="logo"></a>
    <a href="../views/multijoueur.php" class="to-multi">Multijoueur</a>
    <a href="../views/categories.php" class="to-cate">Catégories</a>
    <a href="../views/classement.php" class="to-rank">Classements</a>
    <!-- <button aria-label="Ouvrir la recherche" class="btn-nav-search to-search">
        <img src="../img/search.png" alt="img pour recherche">
    </button> -->

    <?php
    if (!empty($_SESSION)) {
        // echo ucfirst($_SESSION['user']['pseudo_utilisateur']);

        // echo '<p class="welcome-msg">' . ucfirst($_SESSION['user']['pseudo_utilisateur']) . '</p>';
        echo '<img src="' . ucfirst($_SESSION['user']['avatar_utilisateur']) . '" alt="Avatar utilisateur" class="user-profile">';
        echo '<a href="../views/deconnexion.php" class="to-logout"><img src="../img/logout.svg" alt="log-out" class="btn-logout"></a>';
    } else {
        echo '<a href="../views/connexion.php" class="to-login">Connexion</a>';
    }
    ?>
</nav>