void printVoice() {
  for (int i = 0; i < texts.length; i++) {
    I[i].update();
    // define una transparencia diferente para los textos de más arriba
    float alfa = map(I[i].value, height * .7, 0, 255, 0);
    fill(c, alfa);
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


