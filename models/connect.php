<?php
session_start();
try {
    $DB_NAME = "komenjijou";
    $DB_USER = "root";
    $DB_PASSWORD = "";
    $db = new PDO('mysql:host=localhost;dbname=' . $DB_NAME, $DB_USER, $DB_PASSWORD);
} catch (PDOException $e) {
    throw $e;
}
