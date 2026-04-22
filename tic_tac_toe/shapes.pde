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
