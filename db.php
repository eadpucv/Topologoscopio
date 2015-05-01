<?php
$data = $_GET['data']; // este es el parametro que recibimos por ajax
$stringData = $data . '';
$servername = "181.160.254.123";
$username = "hspencer_topo";
$password = "?@6WksSdI!H?";
$port = "3306";

try {
    $conn = new PDO("mysql:host=$servername;dbname=hspencer_topologoscopio", $username, $password);
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