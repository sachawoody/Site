<?php 
include('../models/connect.php');
include('../models/_classes.php');
   
if(!empty($_POST['form_inscription'])) {
    $utilisateur->insert($_POST['form_pseudo'], $_POST['form_mail'], $_POST['form_password'], '0');
    header("Location: ../views/index.php");
}
