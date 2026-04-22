int userCell = -1;
int turn = 1;
int pcCell = -1;
int lastCell = -1;

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
  checkTie();
  checkWin();
  if(!checkGameOver()){
    println("The Game Is Still Going");
  }
  if (turn == 1) {
    int cornerCell = (int)random(4);
    switch (cornerCell) {
      case 1:
        pcCell = 0;
      case 2:
        pcCell = 2;
      case 3:
        pcCell = 6;
      case 4:
        pcCell = 8;
    }
  } else {
    pcCell = getNextMove();
  }

  cellsFull[pcCell] = true;
  pcCells[pcCell] = true;
  lastCell = pcCell;
  drawX(pcCell);

  turn++;
  userMoveNeeded = true;
}
int getNextMove(){
  checkDiagonalWinCon();
  checkHorizontalWinCon();
  checkVerticalWinCon();
  if (!cellsFull[pcCell]){
    if (checkDiagonalWinCon()){
    return playDiagonalWin();
    }
    else if (checkHorizontalWinCon()){
      return playHorizontalWin();
    }
    else if (checkVerticalWinCon()){
      return playVerticalWin();
    }
    else {
      return (int)random(9);
    }
  } else {
    return getNextFreeSpace(lastCell);
  }
}
int playVerticalWin(){
  if (pcCells[0] && pcCells[3]){
    pcCell = 6;
    return 6;
  }
  if (pcCells[0] && pcCells[6]){
    pcCell = 3;
    return 3;
  }
  if (pcCells[6] && pcCells[3]){
    pcCell = 0;
    return 0;
  }

  if (pcCells[1] && pcCells[7]){
    pcCell = 4;
    return 4;
  }
  if (pcCells[4] && pcCells[7]){
    pcCell = 1;
    return 1;
  }
  if (pcCells[1] && pcCells[4]){
    pcCell = 7;
    return 7;
  }

  if (pcCells[2] && pcCells[8]){
    pcCell = 5;
    return 5;
  }
  if (pcCells[5] && pcCells[8]){
    pcCell = 2;
    return 2;
  }
  if (pcCells[2] && pcCells[5]){
    pcCell = 8;
    return 8;
  }
  else {
    return 18;
  }
}
boolean checkVerticalWinCon(){
  if (pcCells[0] && pcCells[3]){
    pcCell = 6;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[0] && pcCells[6]){
    pcCell = 3;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[6] && pcCells[3]){
    pcCell = 0;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[1] && pcCells[7]){
    pcCell = 4;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[4] && pcCells[7]){
    pcCell = 1;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[1] && pcCells[4]){
    pcCell = 7;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[2] && pcCells[8]){
    pcCell = 5;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[5] && pcCells[8]){
    pcCell = 2;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[2] && pcCells[5]){
    pcCell = 8;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  else {
    return false;
  }
}
int playHorizontalWin(){
  if (pcCells[0] && pcCells[2]){
    return 1;
  }
  if (pcCells[0] && pcCells[1]){
    return 2;
  }
  if (pcCells[2] && pcCells[1]){
    return 0;
  }
  if (pcCells[3] && pcCells[5]){
    return 4;
  }
  if (pcCells[3] && pcCells[4]){
    return 5;
  }
  if (pcCells[4] && pcCells[5]){
    return 3;
  }
  if (pcCells[6] && pcCells[8]){
    return 7;
  }
  if (pcCells[6] && pcCells[7]){
    pcCell = 8;
    return 8;
  }
  if (pcCells[7] && pcCells[8]){
    return 6;
  }
  else {
    return 18;
  }
}
boolean checkHorizontalWinCon(){
  if (pcCells[0] && pcCells[2]){
    pcCell = 1;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[0] && pcCells[1]){
    pcCell = 2;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[2] && pcCells[1]){
    pcCell = 0;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[3] && pcCells[5]){
    pcCell = 4;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[3] && pcCells[4]){
    pcCell = 5;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[4] && pcCells[5]){
    pcCell = 3;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[6] && pcCells[8]){
    pcCell = 7;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[6] && pcCells[7]){
    pcCell = 8;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[7] && pcCells[8]){
    pcCell = 6;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  else {
    return false;
  }
}
int getNextFreeSpace(int lastCell){
  if (getRightCell(lastCell) != -1){
    if (!cellsFull[getRightCell(lastCell)]){
      return getRightCell(lastCell);
    } else {
      return -18;
    }
  } else if (getLeftCell(lastCell) != -1){
    if (!cellsFull[getLeftCell(lastCell)]){
      return getLeftCell(lastCell);
    } else {
      return -18;
    }
  } else if (getBelowCell(lastCell) != -1){
    if (!cellsFull[getBelowCell(lastCell)]){
      return getBelowCell(lastCell);
    } else {
      return -18;
    }
  }  else if (getAboveCell(lastCell) != -1){
    if (!cellsFull[getAboveCell(lastCell)]){
      return getAboveCell(lastCell);
    } else {
      return -18;
    }
  }
  else {
    pcCell = (int)random(9);
    while (cellsFull[pcCell]){
      pcCell = (int)random(9);
    }
    return pcCell;
  }
}
int playDiagonalWin(){
  if (pcCells[2] && pcCells[6] || pcCells[8] && pcCells[0]){
    return 4;
  }
  if (pcCells[2] && pcCells[4]){
    return 6;
  }
  if (pcCells[6] && pcCells[4]){
    return 2;
  }
  if (pcCells[4] && pcCells[8]){
    return 0;
  }
  if (pcCells[0] && pcCells[4]){
    return 8;
  } else {
    return 18;
  }
}
boolean checkDiagonalWinCon(){
  if (pcCells[2] && pcCells[6] || pcCells[8] && pcCells[0]){
    pcCell = 4;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[2] && pcCells[4]){
    pcCell = 6;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[6] && pcCells[4]){
    pcCell = 2;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[4] && pcCells[8]){
    pcCell = 0;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  }
  if (pcCells[0] && pcCells[4]){
    pcCell = 8;
    if (!cellsFull[pcCell]){
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
int getRightCell(int lastCell){
  if (lastCell != 2 && lastCell != 5 && lastCell != 8 && !cellsFull[lastCell+1]){
      return lastCell + 1;
  }
  else {
    return -1;
  }
}
int getLeftCell(int lastCell){
if (lastCell != 0 && lastCell != 3 && lastCell != 6 && !cellsFull[lastCell-1]){
      return lastCell - 1;
  }
  else {
    return -1;
  }
}
int getBelowCell(int lastCell){
  if (lastCell > 2 && lastCell < 6 && !cellsFull[lastCell+3]){
    return lastCell + 3;
  } else {
    return -1;
  }
}
int getAboveCell(int lastCell){
  if (lastCell > 2 && !cellsFull[lastCell-3]){
    return lastCell - 3;
  } else {
    return -1;
  }
}
