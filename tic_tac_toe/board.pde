int userCell = -1;
int lastCell = -1;

boolean isTurnOne = true;
boolean userMoveNeeded = false;
boolean pcWin = false;
boolean playerWin = false;
boolean gameOver = false;

boolean[] cellsFull = new boolean[9];
boolean [] pcCells = new boolean[9];
boolean [] playerCells = new boolean[9];

void checkGameOver(){
	boolean allCellsFull = true;

	for (int i = 0; i < cellsFull.length; i++){
		allCellsFull &= cellsFull[i];
	}

	if (allCellsFull || checkWin()) {
		gameOver = true;
	}
  if (gameOver){
    println("The Game Is Over");
  }
}
void keyPressed(){
	userCell = key - '0';
	checkGameOver();
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
void userTurn(){
	if (!gameOver){
		if (userCell != -1) {
			drawCircle(userCell);
		}
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

	if (playerWin && !gameOver) {
		println("You Have Won The Game");
		noLoop();
	}
	if (pcWin){
		println("The Computer Has Won The Game");
		noLoop();
	}
	if (!pcWin && !playerWin && gameOver && !isTurnOne){
		println("Nobody Has Won The Game");
		noLoop();
	}
	return isWin;
}
boolean checkTie(){
	return !playerWin && !pcWin && gameOver;
}
void pcTurn(){
	int cornerCell = (int)random(4);
	int pcCell = cornerCell;
	checkTie();
	checkWin();
	if (isTurnOne) {
		switch (cornerCell) {
			case 1:
				pcCell = 0;
				break;
			case 2:
				pcCell = 2;
				break;
			case 3:
				pcCell = 6;
				break;
			case 4:
				pcCell = 8;
				break;
		}
		isTurnOne = false;
	} else {
		pcCell = getNextMove();
	}

	drawX(pcCell);
	cellsFull[pcCell] = true;
	pcCells[pcCell] = true;
	lastCell = pcCell;
	userMoveNeeded = true;
}
int getNextMove(){
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
		return getNextFreeSpace(lastCell);
	}
}
int playVerticalWin(){
	if (pcCells[0] && pcCells[3]){
		return 6;
	}
	if (pcCells[0] && pcCells[6]){
		return 3;
	}
	if (pcCells[6] && pcCells[3]){
		return 0;
	}

	if (pcCells[1] && pcCells[7]){
		return 4;
	}
	if (pcCells[4] && pcCells[7]){
		return 1;
	}
	if (pcCells[1] && pcCells[4]){
		return 7;
	}

	if (pcCells[2] && pcCells[8]){
		return 5;
	}
	if (pcCells[5] && pcCells[8]){
		return 2;
	}
	if (pcCells[2] && pcCells[5]){
		return 8;
	}
	else {
		return 18;
	}
}
boolean checkVerticalWinCon(){
	int nextPcCell;
	if (pcCells[0] && pcCells[3]){
		nextPcCell = 6;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[0] && pcCells[6]){
		nextPcCell = 3;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[6] && pcCells[3]){
		nextPcCell = 0;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[1] && pcCells[7]){
		nextPcCell = 4;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[4] && pcCells[7]){
		nextPcCell = 1;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[1] && pcCells[4]){
		nextPcCell = 7;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[2] && pcCells[8]){
		nextPcCell = 5;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[5] && pcCells[8]){
		nextPcCell = 2;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[2] && pcCells[5]){
		nextPcCell = 8;
		if (!cellsFull[nextPcCell]){
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
	int nextPcCell;
	if (pcCells[0] && pcCells[2]){
		nextPcCell = 1;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[0] && pcCells[1]){
		nextPcCell = 2;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[2] && pcCells[1]){
		nextPcCell = 0;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[3] && pcCells[5]){
		nextPcCell = 4;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[3] && pcCells[4]){
		nextPcCell = 5;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[4] && pcCells[5]){
		nextPcCell = 3;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[6] && pcCells[8]){
		nextPcCell = 7;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[6] && pcCells[7]){
		nextPcCell = 8;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[7] && pcCells[8]){
		nextPcCell = 6;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	else {
		return false;
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
	int nextPcCell;
	if (pcCells[2] && pcCells[6] || pcCells[8] && pcCells[0]){
		nextPcCell = 4;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[2] && pcCells[4]){
		nextPcCell = 6;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[6] && pcCells[4]){
		nextPcCell = 2;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[4] && pcCells[8]){
		nextPcCell = 0;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	}
	if (pcCells[0] && pcCells[4]){
		nextPcCell = 8;
		if (!cellsFull[nextPcCell]){
			return true;
		} else {
			return false;
		}
	} else {
		return false;
	}
}
int getNextFreeSpace(int lastCell){
	int pcCell;
	if (getRightCell(lastCell) != -1){
			return getRightCell(lastCell);

	} else if (getLeftCell(lastCell) != -1){
			return getLeftCell(lastCell);

	} else if (getBelowCell(lastCell) != -1){
			return getBelowCell(lastCell);

	} else if (getAboveCell(lastCell) != -1){
			return getAboveCell(lastCell);
	} else {
		pcCell = (int)random(9);
		while (cellsFull[pcCell]){
			pcCell = (int)random(9);
		}
		return pcCell;
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
