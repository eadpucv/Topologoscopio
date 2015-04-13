/**
 **  Topo·Logo·Scopio
 **  por @hspencer
 **  e[ad] Escuela de Arquitectura y Diseño PUCV
 **
 **/

import muthesius.net.*;
import org.webbitserver.*;
import de.bezier.data.sql.*;
import ddf.minim.*;

Minim minim;
AudioInput in;

WebSocketP5 socket;  // la conexión con Webkit y la API de Google
MySQL db;            // la base de datos
color c;

PFont font;

String[] texts;      // los textos en pantalla
float[] heights;     // las heights de los textos en pantalla
Integrator[] I;      // las heights animadas de los textos en pantalla

int lines = 7;       // el largo de todos los arreglos de textos

float fontSize, textWidth, fontHeight;
float margin, lowerMargin;
int newLine;  // corresponde al índice de la newLine línea de texto que ingresa


void setup() {
  size(displayWidth, displayHeight, P3D);
  socket = new WebSocketP5(this, 8080);
  
  // datos de conexión con la BBDD local
  String user     = "root";
  String pass     = "";
  String database = "topologoscopio";
  db = new MySQL( this, "127.0.0.1", database, user, pass);
  
  c = #FAF9ED;
  noCursor();
  fontSize = 72;
  margin = 100;

  textWidth = width - 2 * margin;
  font = loadFont("DINCondensed-Bold-72.vlw");
  textFont(font, fontSize);
  fontHeight = textAscent()+textDescent();
  textLeading(fontHeight);
  lowerMargin = height - margin;

  texts = new String[lines];
  heights = new float[lines];
  I = new Integrator[lines];

  // inicializa los textos con números
  for (int i = 0; i < lines; i++) {
    String a = ""+i+").";
    texts[i] = a;
    heights[i] = lowerMargin - ((textHeight(a)+textLeading()) * (lines - i));
    I[i] = new Integrator(height*2);
  }
  for (int i = 0; i < lines; i++) {
    I[i].target(heights[i]);
  }
  newLine = 0;

  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  background(0);
  drawAudio();
  printVoice();
}

void stop() {
  socket.stop();
}

void websocketOnMessage(WebSocketConnection con, String msg) {
  if (db.connect()) {
    db.query("INSERT INTO speech(utterance) VALUES('"+msg+"')");
  } else {
    println("no se puede conectar a la base de datos");
  }

  // println(msg);
  String t = createLineBreaks(msg, textWidth);

  texts[newLine] = msg;
  I[newLine].set(height*2);
  heights[newLine] = textHeight(t);

  // corre los textos hacia arriba al ingresar un texto nuevo
  for (int i = 0; i < lines; i++) {
    if (i != newLine) {
      I[i].target -= heights[newLine];
    }
  }
  
  // anima el ingreso del nuevo texto
  I[newLine].target = lowerMargin - heights[newLine];
  newLine = (newLine + 1) % lines;
}

void websocketOnOpen(WebSocketConnection con) {
  println("un cliente se ha unido");
}

void websocketOnClosed(WebSocketConnection con) {
  println("un cliente se ha ido");
}

void keyPressed() {
  if (key == 'q' || key == 27) {
    socket.stop();
    db.close();
    exit();
  }
}

