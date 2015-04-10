import muthesius.net.*;
import org.webbitserver.*;
import de.bezier.data.sql.*;
import java.io.ByteArrayOutputStream;
import java.io.PrintStream;

WebSocketP5 socket;
MySQL db;
Console console;
PFont font, mono;

String[] texts;
float[] alturas;
Integrator[] I;

int lines = 5;

float fontSize, textWidth;
float margin;

void setup() {
  size(displayWidth, displayHeight);
  socket = new WebSocketP5(this, 8080);
  String user     = "root";
  String pass     = "";
  String database = "topologoscopio";
  db = new MySQL( this, "127.0.0.1", database, user, pass );
  font = loadFont("DINCondensed-Bold-72.vlw");
  mono = loadFont("Monaco-12.vlw");

  texts = new String[lines];
  alturas = new float[lines];
  I = new Integrator[lines];

  fontSize = 72;
  margin = 100;
  textWidth = displayWidth - 2 * margin;

  console = new Console(this, 72);

  for (int i = 0; i < lines; i++) {
    String a = "...";
    texts[i] = a;
    I[i] = new Integrator(height);
  }

  textFont(font, fontSize);
  textLeading(textAscent()+4);

  resetHeights();
  calcHeights();
}

void resetHeights() {
  for (int i = 0; i < lines; i++) {
    alturas[i] = height - (textAscent()+textDescent()+margin);
  }
}


void calcHeights() {
  for (int i = 0; i < lines; i++) {
    for (int j = lines - 1; j >= i; j --) {
      String t = createLineBreaks(texts[j], textWidth);
      alturas[i] -= (textHeight(t)); 
      //println("cuando i vale "+i+" j vale "+j);
    }
  }
  for (int i = 0; i < lines; i++) {
    I[i].target(alturas[i]);
  }
}


void draw() {
  background(0);
  printVoice();
}


void stop() {
  socket.stop();
}

void websocketOnMessage(WebSocketConnection con, String msg) {
  if (db.connect()) {
    db.query("INSERT INTO speech(utterance) VALUES('"+msg+"')");
  } else
  {
    println("la conexión con la base de datos no pudo realizarse");
  }
  String t = createLineBreaks(msg, textWidth - fontSize);
  t.toUpperCase();
  for (int i = 1; i < texts.length; i++) {
    texts[i-1] = texts[i];
  }
  texts[texts.length-1] = t;
  println(msg);
  resetHeights();
  calcHeights();
}

void websocketOnOpen(WebSocketConnection con) {
  println("un cliente se ha unido");
}

void websocketOnClosed(WebSocketConnection con) {
  println("un cliente se ha ido");
}

