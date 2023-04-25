<?php
include('../models/connect.php');
$requete = "UPDATE mastermind_scores s -- s est un alias pour mastermind_scores
    inner join (
        select id, (
            select count(*) + 1 -- cela me permet de savoir combien j'ai de lignes dans une table (ici le nombre d'id donc en somme le nb de joueurs dans le classement)
            -- ici je fais + 1 pour obtenir la position du joueur dans le classement
            -- je crée une sous requête car je ne peux pas faire de inner join dans une requête update donc je duplique ma table
            -- pour ensuite faire mon système de classement (tri) et ensuite je la copie dans ma table principale s
            from mastermind_scores s2 -- s2 est un alias la sous-requête qui correspond a une copie de mastermind_scores
            where s2.score > s.score
        ) as classement
        from mastermind_scores s
        where s.score > 0
    ) s2 on s.id = s2.id
    set s.classement = s2.classement -- faire la mise à jour de la table en fonction de la table dupliquée qui a le classement à jour
";
$statement = $db->prepare($requete);
?>
