
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

        var node = document.createElement("span");                 
        var textnode = document.createTextNode(transcript);         
        node.appendChild(textnode);                             
        d.appendChild(node); 
        
        var interim = document.getElementById("intermediate");
        interim.textContent = "";

        $.ajax({
            url: 'db.php', // llamamos al php
            type: 'GET',
            data: {data: transcript}, // le enviamos la data en un objeto javascript
        })

        .done(function(data) {
            if (data) //si el resultado es 1 entonces se insertó
                console.log("db.php -> "+data);
        })
        
    }else{
        var interim = document.getElementById("intermediate");
        interim.textContent = transcript;
        
    }
}

/*
recognition.onerror = function(event) { 
    recognition.start();
}
*/

recognition.onend = function(event){
    recognition.start();
}

// Comienza a reconocer
// recognition.lang = 'ES';
recognition.start();