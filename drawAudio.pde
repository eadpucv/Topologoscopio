
// dibuja las barras de monitoreo de audio
void drawAudio() {
  float st = 5;
  strokeWeight(st);
  float ypos = height;
  float amp = 400;
  pushMatrix();
  scale(2, 1);
  for (int i = 0; i < in.bufferSize (); i+=(st)) {
    // gray = 100 + in.left.get(i) * 155;
    stroke(c, 100);
    line( i, height, i, ypos - in.left.get(i)*amp);
    // line( i, ypos - 5 - in.right.get(i)*amp, i+1, ypos - 5 - in.right.get(i+1)*amp );
  }
  popMatrix();
}
