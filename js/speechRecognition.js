
// Reconocimiento de voz
// Sólo soportado por Google Chrome
// Una vez que comienza, debes autorizar el acceso al micrófono

var recognition = new webkitSpeechRecognition();

// De forma predeterminada, Google retorna solo 1 resultado
// La forma continua mantiene el micrófono abierto

recognition.continuous = true;

// Devolución de resultados parciales
recognition.interimResults = true;

recognition.onresult = function(event) {

    // Obtén el resultado a partir del objeto generado por la API
    var transcript = event.results[event.results.length-1][0].transcript;
    var isFinal = event.results[event.results.length-1].isFinal;
    
    if(isFinal){
    var d = document.getElementById("speech");
        d.textContent += " · "+transcript;
        d = document.getElementById("intermediate");
        d.textContent = "";
        
        $.ajax({
            url: '../db.php', // llamamos al php
            type: 'POST',
            data: {data: tanscript}, // le enviamos la data en un objeto javascript
        })

        .done(function(data) {
            if (data) //si el resultado es 1 entonces se insertó
                console.log("Insertado");
        })
        
    }else{
    var d = document.getElementById("intermediate");
        d.textContent = transcript;
        
    }

    var newTranscript = transcript + "+" + x;
    // ws.send(newTranscript);
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