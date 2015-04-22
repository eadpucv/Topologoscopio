<?php
$data = $_GET['data']; //este es el parametro que recibimos por ajax
$servername = "127.0.0.1";
$username = "root";
$password = "";

try {
    $conn = new PDO("mysql:host=$servername;dbname=topologoscopio", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $sql = "INSERT INTO speech (utterance)
		VALUES ('data')";
    echo "1"; // se inserto y le devolvemos 1 al javascript
    die();
}
catch(PDOException $e)
{
    echo ":( " . $e->getMessage();
}
?>