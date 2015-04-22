<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>Topo·Logo·Scopio</title>
    <link rel="stylesheet" type="text/css" href="css/topologoscopio.css">
    <script language="javascript" type="text/javascript" src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/p5.js"></script>
    <script language="javascript" type="text/javascript" src="js/p5.sound.js"></script>
    <script language="javascript" type="text/javascript" src="js/sound-display.js"></script>
    <script language="javascript" type="text/javascript" src="js/speechRecognition.js"></script>
</head>
<body>
    <div id="speech-container">
        <span id='speech'>
            <?php
            $servername = "127.0.0.1";
            $username = "root";
            $password = "";
            try {
                $conn = new PDO("mysql:host=$servername;dbname=topologoscopio", $username, $password);
                $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                echo "<h1>Topo·Logo·Scopio</h1>e[ad] Escuela de Arquitectura y Diseño PUCV<br><br>"; 
            }
            catch(PDOException $e)
            {
                echo ":( " . $e->getMessage();
            }
            ?>
        </span>
    </div>
    <span id='intermediate'></span>
    <div id='darken-overlay'></div>
</body>
</html>