void printConsolte(float x, float y) {
  textAlign(RIGHT);
  float lineHeight = 17;
  textFont(mono);
  fill(#D6BA8C);
  for (int i = 0; i < console.buffer.size (); i++) {
    String t = console.buffer.get(i);
    text(t, x, y + i * lineHeight);
  }
}


public class Console {
  private PApplet parent;
  private ByteArrayOutputStream baos = new ByteArrayOutputStream();
  private PrintStream printStream = new PrintStream(this.baos);
  private PrintStream original= System.out;
  private int streamSizeDummy= 0;
  private int maxLines= 0;

  public ArrayList<String> buffer;

  Console(PApplet parent, int lines) {
    this.parent= parent;
    this.parent.registerMethod("pre", this);

    this.buffer= new ArrayList();
    this.maxLines= lines;

    System.setOut(this.printStream);
  }

  public void pre() {
    if (this.baos.size() > this.streamSizeDummy) {
      String[] dummy= splitTokens(baos.toString(), "\n");

      for (int i=0; i<dummy.length; i++) {
        this.buffer.add(dummy[i]);
        if (this.buffer.size() > this.maxLines) {
          this.buffer.remove(0);
        }
      }

      System.setOut(this.original);      
      //println(join(dummy, '\n'));

      System.setOut(printStream);

      this.baos.reset();
    }
  }
}

