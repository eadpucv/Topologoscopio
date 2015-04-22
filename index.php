<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>Topo·Logo·Scopio</title>
    <script type="text/javascript" src="js/speechRecognition.js"></script>
    <script language="javascript" type="text/javascript" src="js/p5.js"></script>
    <script language="javascript" type="text/javascript" src="js/p5.sound.js"></script>
    <script language="javascript" type="text/javascript" src="js/sound-waves.js"></script>
    <link rel="stylesheet" type="text/css" href="css/topologoscopio.css">
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
                echo ":)"; 
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