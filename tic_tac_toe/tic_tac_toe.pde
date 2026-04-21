void setup() {
  size(500, 500);
  for(int i = 0; i < cellsFull.length; i++) {
    cellsFull[i] = false;
    playerCells[i] = false;
    pcCells[i] = false;
  }
}

void draw() {
  makeBoard();
  if (!userMoveNeeded && !checkWin()) {
      pcTurn();
  }
  checkGameOver();
}
