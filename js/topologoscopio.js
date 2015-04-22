// Necesitamos asegurarnos que el navegador utilice Websocket

        if ("WebSocket" in window) {

            // Antes de conectarnos al Websocket, debemos comenzarlo desde Processing

            var ws = new WebSocket("ws://localhost:8080/p5websocket");
        } else {

            // El navegador no sporta websocket

            alert("WebSocket NOT supported by your Browser!");
        }

        // Ahora podemos comenzar el reconocimiento de voz
        // Sólo soportado por Google Chrome
        // Una vez que comienza, debes autorizar el acceso al micrófono

        var recognition = new webkitSpeechRecognition();

        // De forma predeterminada, Google retorna solo 1 resultado
        // La forma continua mantiene el micrófono abierto

        recognition.continuous = true;
        recognition.interimResults = true;

        recognition.onresult = function(event) {

            // Obtén el resultado a partir del objeto generado por la API
            var transcript = event.results[event.results.length-1][0].transcript;

            var isFinal = event.results[event.results.length-1].isFinal;
            
            var x;
            
            if(isFinal){
            var d = document.getElementById("speech");
                d.textContent += " ~ "+transcript;
                d = document.getElementById("intermediate");
                d.textContent = " ";
                x = "true";
            }else{
            var d = document.getElementById("intermediate");
                d.textContent = transcript;
                x = "false";
            }

            var newTranscript = transcript + "+" + x;
            ws.send(newTranscript);
        }

        recognition.onerror = function(event) { 
            recognition.start();
        }
        recognition.onend = function(event){
            recognition.start();
        }

        // Comienza a reconocer
        // recognition.lang = 'ES';
        recognition.start();