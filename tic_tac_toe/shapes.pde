void makeBoard(){
  stroke(0);
  strokeWeight(2);

  line(VERT_LINE_ONE_X, 0, VERT_LINE_ONE_X, height);
  line(VERT_LINE_TWO_X, 0, VERT_LINE_TWO_X, height);
  line(0, HORI_LINE_ONE_Y, width, HORI_LINE_ONE_Y);
  line(0, HORI_LINE_TWO_Y, width, HORI_LINE_TWO_Y);
}
void drawX(int cell){
  stroke(0);
  strokeWeight(2);

  float x = getCellX(cell);
  float y = getCellY(cell);

  line(x, y, x + LINE_HEIGHT_NORMAL, y + LINE_HEIGHT_NORMAL);
  line(x + LINE_HEIGHT_NORMAL, y, x, y + LINE_HEIGHT_NORMAL);
}
