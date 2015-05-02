<?php
$data = $_GET['data']; // este es el parametro que recibimos por ajax
$stringData = $data . '';
$servername = "127.0.0.1";
$username = "root";
$password = "";

try {
    $conn = new PDO("mysql:host=$servername;dbname=topologoscopio", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $data = $conn->query('INSERT INTO speech(utterance) VALUES("'.$stringData.'")');
    echo $stringData; // esto le devolvemos al js
    die();
}
catch(PDOException $e)
{
    echo ":( " . $e->getMessage();
}
?>