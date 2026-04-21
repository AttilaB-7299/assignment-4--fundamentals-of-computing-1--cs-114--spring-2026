int userCell = -1;
int turn = 1;
int pcCell = -1;

boolean userMoveNeeded = false;
boolean pcWin = false;
boolean playerWin = false;
boolean gameOver = true;

boolean[] cellsFull = new boolean[9];
boolean [] pcCells = new boolean[9];
boolean [] playerCells = new boolean[9];

boolean checkGameOver(){
  boolean allCellsFull = true;

  for (int i = 0; i < cellsFull.length; i++){
    allCellsFull &= cellsFull[i];
  }

  if (checkWin()) {
    return true;
  }
  gameOver = allCellsFull;

  return gameOver;
}
void keyPressed(){
  userCell = key - '0';
  userTurn();
}
float getCellX(int cell){
  switch(cell) {
    case 0:
    case 3:
    case 6:
      return 0;

    case 1:
    case 4:
    case 7:
      return CELL_ONE_X;

    case 2:
    case 5:
    case 8:
      return CELL_TWO_X;

    default:
      return -1;

  }
}
float getCellY(int cell){
  switch (cell){
    case 0:
    case 1:
    case 2:
      return 0;

    case 3:
    case 4:
    case 5:
      return CELL_ONE_Y;

    case 6:
    case 7:
    case 8:
      return CELL_TWO_Y;

    default:
      return 0;
  }
}
void drawCircle(int cell){
  if (!checkGameOver()){
    if (cell >= 0 && cell <= 8){
    noFill();
      if (!cellsFull[cell]){

        float x = getCellX(cell);
        float y = getCellY(cell);

        x += CIRCLE_RADIUS;
        y += CIRCLE_RADIUS;

        circle(x, y, CIRCLE_DIAMETER);

        cellsFull[cell] = true;
        playerCells[cell] = true;
        userMoveNeeded = false;
        turn++;
      } else{
        println("That cell is full try another");
        userMoveNeeded = true;
      }
    } else {
      println("Please enter a number 0-8");
    }
  }
}

void userTurn(){
  if (userCell != -1) {
    drawCircle(userCell);
  }
  if (checkGameOver()){
    println("The Game Is Over");
  }
}
boolean checkColumn(){
  boolean isWin = false;

  if (playerCells[0] && playerCells[3] && playerCells[6] ||
      playerCells[1] && playerCells[4] && playerCells[7] ||
      playerCells[2] && playerCells[5] && playerCells[8]){

    playerWin = true;
  }
  if (pcCells[0] && pcCells[3] && pcCells[6] ||
      pcCells[1] && pcCells[4] && pcCells[7] ||
      pcCells[2] && pcCells[5] && pcCells[8]){

    pcWin = true;
  }

  isWin = playerWin || pcWin;

  return isWin;
}
boolean checkRow(){
  boolean isWin = false;

  if (playerCells[0] && playerCells[1] && playerCells[2] ||
      playerCells[3] && playerCells[4] && playerCells[5] ||
      playerCells[6] && playerCells[7] && playerCells[8]){

    playerWin = true;
  }
  if (pcCells[0] && pcCells[1] && pcCells[2] ||
      pcCells[3] && pcCells[4] && pcCells[5] ||
      pcCells[6] && pcCells[7] && pcCells[8]){

    pcWin = true;
  }

  isWin = playerWin || pcWin;

  return isWin;
}
boolean checkDiagonal(){
  boolean isWin = false;

  if (playerCells[0] && playerCells[4] && playerCells[8] ||
      playerCells[6] && playerCells[4] && playerCells[2]){

    playerWin = true;
  }
  if (pcCells[0] && pcCells[4] && pcCells[8] ||
      pcCells[6] && pcCells[4] && pcCells[2]){

    pcWin = true;
  }

  isWin = playerWin || pcWin;

  return isWin;
}
boolean checkWin(){
  boolean isWin = false;

  isWin |= checkColumn();
  isWin |= checkRow();
  isWin |= checkDiagonal();

  if (playerWin) {
    println("You Have Won The Game");
    noLoop();
  }
  if (pcWin){
    println("The Computer Has Won The Game");
    noLoop();
  }
  if (!pcWin && !playerWin && gameOver && turn != 1){
    println("The Game Is A Tie");
    noLoop();
  }
  return isWin;
}
boolean checkTie(){
  return !playerWin && !pcWin && checkGameOver();
}
void pcTurn(){
  if (checkTie()){
    println("TIE GAME");
  }
  if(!checkGameOver()){
    println("The Game Is Still Going");
  }
  pcCell = (int)random(9);
  if (turn == 1) {
    println(pcCell);
  } else{
    pcCell = (int)random(9);
    while (cellsFull[pcCell]){
      pcCell = (int)random(9);
    }
  }
  cellsFull[pcCell] = true;
  pcCells[pcCell] = true;
  drawX(pcCell);

  turn++;
  userMoveNeeded = true;
}
