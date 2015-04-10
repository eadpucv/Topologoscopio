import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import muthesius.net.*; 
import org.webbitserver.*; 
import de.bezier.data.sql.*; 
import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Topologoscopio extends PApplet {

/**
 **  Topo\u00b7Logo\u00b7Scopio
 **  por @hspencer
 **  e[ad] Escuela de Arquitectura y Dise\u00f1o PUCV
 **
 **/






Minim minim;
AudioInput in;

WebSocketP5 socket;  // la conexi\u00f3n con Webkit y la API de Google
MySQL db;            // la base de datos

PFont font, mono;

String[] texts;      // los textos en pantalla
float[] heights;     // las heights de los textos en pantalla
Integrator[] I;      // las heights animadas de los textos en pantalla

int lines = 7;       // el largo de todos los arreglos de textos

float fontSize, textWidth, fontHeight;
float margin, lowerMargin;
int newLine;  // corresponde al \u00edndice de la newLine l\u00ednea de texto que ingresa


public void setup() {
  size(displayWidth, displayHeight, P3D);
  socket = new WebSocketP5(this, 8080);
  String user     = "root";
  String pass     = "";
  String database = "topologoscopio";
  db = new MySQL( this, "127.0.0.1", database, user, pass);

  fontSize = 72;
  margin = 100;

  textWidth = width - 2 * margin;
  font = loadFont("DINCondensed-Bold-72.vlw");
  mono = loadFont("Monaco-12.vlw");
  textFont(font, fontSize);
  fontHeight = textAscent()+textDescent();
  textLeading(fontHeight);
  lowerMargin = height - margin;

  texts = new String[lines];
  heights = new float[lines];
  I = new Integrator[lines];

  for (int i = 0; i < lines; i++) {
    String a = "...";
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

public void draw() {
  background(0);
  drawAudio();
  printVoice();
}

public void stop() {
  socket.stop();
}

public void websocketOnMessage(WebSocketConnection con, String msg) {
  if (db.connect()) {
    db.query("INSERT INTO speech(utterance) VALUES('"+msg+"')");
  } else {
    println("la conexi\u00f3n con la base de datos no pudo realizarse");
  }

  println(msg);
  String t = createLineBreaks(msg, textWidth);

  texts[newLine] = msg;
  I[newLine].set(height*2);
  heights[newLine] = textHeight(t);

  for (int i = 0; i < lines; i++) {
    if (i != newLine) {
      I[i].target -= heights[newLine];
    }
  }
  I[newLine].target = lowerMargin - heights[newLine];
  newLine = (newLine + 1) % lines;
}

public void websocketOnOpen(WebSocketConnection con) {
  println("un cliente se ha unido");
}

public void websocketOnClosed(WebSocketConnection con) {
  println("un cliente se ha ido");
}

public void drawAudio() {
  stroke(255, 100);
  
  float amp = 500;
  pushMatrix();
  scale(2, 1);
  for (int i = 0; i < in.bufferSize () - 1; i++) {
    line( i, height - 50 - in.left.get(i)*amp, i+1,  height - 50 - in.left.get(i+1)*amp  );
    line( i, height - 47 - in.right.get(i)*amp, i+1, height - 47 - in.right.get(i+1)*amp );
  }
  popMatrix();
}

public void printVoice() {
  for (int i = 0; i < texts.length; i++) {
    I[i].update();
    float gray = map(I[i].value, height * .7f, 0, 255, 0);
    fill(gray);
    text(texts[i], margin, I[i].value, textWidth);
  }
}


public String createLineBreaks(String str, float maxWidth) {
  // Remove unnecessary spaces
  // and add (unix) linebreak characters if line length exceeds maxWidth
  StringBuilder strBuffer = new StringBuilder(str.length());
  boolean firstSpace = false;
  int lastSpace = -1, iB = 0;
  float currentWidth = 0, wordWidth = 0;
  for (int i = 0, n = str.length (); i < n; i++) {
    char c = str.charAt(i);
    if (c == ' ') { // If this character is a space
      if (firstSpace) { // If this space is the first space in a row
        if (currentWidth > maxWidth && lastSpace > -1) {
          strBuffer.setCharAt(lastSpace, (char)10);
          currentWidth -= wordWidth;
        }
        currentWidth += textWidth(c);
        wordWidth = currentWidth;
        lastSpace = iB;
        strBuffer.append(c);
        firstSpace = false;
        iB++;
      }
    } else { // If character is no space
      currentWidth += textWidth(c);
      strBuffer.append(c);
      firstSpace = true;
      iB++;
    }
  }
  if (currentWidth > maxWidth && lastSpace > -1) // If last line still exceeds maxWidth
    strBuffer.setCharAt(lastSpace, (char)10);

  // Return string
  return strBuffer.toString();
}

public void text(String str, float x, float y, float maxWidth) {
  text(createLineBreaks(str, maxWidth), x, y+textAscent());
}

public float textLeading() {
  return g.textLeading;
}

public float textHeight(String str) {
  // Count (unix) linebreaks
  int linebreaks = 0;
  for (int i = 0, n = str.length (); i < n; i++)
    if (str.charAt(i) == (char)10)
      linebreaks++;

  // Calculate & return height
  if (linebreaks == 0)
    return textAscent() + textDescent();
  else
    return linebreaks * textLeading() + textAscent() + textDescent();
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--hide-stop", "Topologoscopio" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
