int cellSize = 2;
Circle[] circles = new Circle[30];
int cols;
int rows;
float[][] grid;
PFont f;
float threshold = 1;

float getAdjustedPosition(float onCoordinate, float offCoordinate, float onVal, float offVal){
  //Qy = By + (Dy - By)((threshold - f(Bx, By)/(f(Dx, Dy) - f(Bx, By))), B = off, D = on, Q = target
  return offCoordinate + (onCoordinate - offCoordinate)*((threshold - offVal)/(onVal - offVal));
}

void drawCountour(int i, int j, int xPos, int yPos, int state){
  PVector top = new PVector(xPos, yPos - cellSize/2);
  PVector right = new PVector(xPos + cellSize/2, yPos);
  PVector bottom = new PVector(xPos, yPos + cellSize/2);
  PVector left = new PVector(xPos - cellSize/2, yPos);
  stroke(map(xPos, 0, width, 0, 255), 255, 255);
  strokeWeight(2);  
  switch(state){
    case 1: //TL
    
      //finds position for top.x and left.y
      top.x = getAdjustedPosition(i * cellSize, (i + 1) * cellSize, grid[i][j], grid[i + 1][j]);
      left.y = getAdjustedPosition(j * cellSize, (j + 1) * cellSize, grid[i][j], grid[i][j + 1]);
      line(top.x, top.y, left.x, left.y);
      break;
      
    case 2: //TR
    
      //finds position for top.x and right.y
      top.x = getAdjustedPosition((i + 1) * cellSize, i * cellSize, grid[i + 1][j], grid[i][j]);
      right.y = getAdjustedPosition(j * cellSize, (j + 1) * cellSize, grid[i + 1][j], grid[i + 1][j + 1]);
      line(top.x, top.y, right.x, right.y);
      break;
      
    case 3: //TL + TR
    
      //finds position for left.y and right.y
      left.y = getAdjustedPosition(j * cellSize, (j + 1) * cellSize, grid[i][j], grid[i][j + 1]);
      right.y = getAdjustedPosition(j * cellSize, (j + 1) * cellSize, grid[i + 1][j], grid[i + 1][j + 1]);
      line(left.x, left.y, right.x, right.y);
      break;
      
    case 4: //BR
    
      //finds position for bottom.x and right.y
      bottom.x = getAdjustedPosition((i + 1) * cellSize, i * cellSize, grid[i + 1][j + 1], grid[i][j + 1]);
      right.y = getAdjustedPosition((j + 1) * cellSize, j * cellSize, grid[i + 1][j + 1], grid[i + 1][j]);
      line(bottom.x, bottom.y, right.x, right.y);
      break;
      
    case 5: //TL + BR
    
      //finds position for top.x, left.y, right.y and bottom.y
      top.x = getAdjustedPosition(i * cellSize, (i + 1) * cellSize, grid[i][j], grid[i + 1][j]);
      left.y = getAdjustedPosition(j * cellSize, (j + 1) * cellSize, grid[i][j], grid[i][j + 1]);
      bottom.x = getAdjustedPosition((i + 1) * cellSize, i * cellSize, grid[i + 1][j + 1], grid[i][j + 1]);
      right.y = getAdjustedPosition((j + 1) * cellSize, j * cellSize, grid[i + 1][j + 1], grid[i + 1][j]);
      line(top.x, top.y, left.x, left.y);
      line(right.x, right.y, bottom.x, bottom.y);
      break;
      
    case 6: // TR + BR
    
      //finds position for top.x and bottom.x
      top.x = getAdjustedPosition((i + 1) * cellSize, i * cellSize, grid[i + 1][j], grid[i][j]);
      bottom.x = getAdjustedPosition((i + 1) * cellSize, i * cellSize, grid[i + 1][j + 1], grid[i][j + 1]);
      line(top.x, top.y, bottom.x, bottom.y);
      break;
      
    case 7: //TL + TR + BR
    
      //finds position for left.y and bottom.x
      left.y = getAdjustedPosition((j + 1) * cellSize, j * cellSize, grid[i][j + 1], grid[i][j]);
      bottom.x = getAdjustedPosition(i * cellSize, (i + 1) * cellSize, grid[i][j + 1], grid[i + 1][j + 1]);
      line(left.x, left.y, bottom.x, bottom.y);
      break;
      
    case 8: //BL
    
      //finds position for left.y and bottom.x
      left.y = getAdjustedPosition((j + 1) * cellSize, j * cellSize, grid[i][j + 1], grid[i][j]);
      bottom.x = getAdjustedPosition(i * cellSize, (i + 1) * cellSize, grid[i][j + 1], grid[i + 1][j + 1]);
      line(left.x, left.y, bottom.x, bottom.y);
      break;
      
    case 9: //TL + BL
    
      //finds position for top.x and bottom.x
      top.x = getAdjustedPosition(i * cellSize, (i + 1) * cellSize, grid[i][j], grid[i + 1][j]);
      bottom.x = getAdjustedPosition(i * cellSize, (i + 1) * cellSize, grid[i][j + 1], grid[i + 1][j + 1]);
      line(top.x, top.y, bottom.x, bottom.y);
      break;
      
    case 10: //TR + BL
    
      //finds position for left.y, top.x, bottom.x and right.y
      top.x = getAdjustedPosition((i + 1) * cellSize, i * cellSize, grid[i + 1][j], grid[i][j]);
      right.y = getAdjustedPosition(j * cellSize, (j + 1) * cellSize, grid[i + 1][j], grid[i + 1][j + 1]);
      left.y = getAdjustedPosition((j + 1) * cellSize, j * cellSize, grid[i][j + 1], grid[i][j]);
      bottom.x = getAdjustedPosition(i * cellSize, (i + 1) * cellSize, grid[i][j + 1], grid[i + 1][j + 1]);
      line(left.x, left.y, top.x, top.y);
      line(bottom.x, bottom.y, right.x, right.y);
      break;
      
    case 11: //TL + TR + BL
    
      //finds position for bottom.x and right.y
      bottom.x = getAdjustedPosition((i + 1) * cellSize, i * cellSize, grid[i + 1][j + 1], grid[i][j + 1]);
      right.y = getAdjustedPosition((j + 1) * cellSize, j * cellSize, grid[i + 1][j + 1], grid[i + 1][j]);
      line(bottom.x, bottom.y, right.x, right.y);
      break;
      
    case 12: //BR + BL
    
      //finds position for left.y and right.y
      left.y = getAdjustedPosition((j + 1) * cellSize, j * cellSize, grid[i][j + 1], grid[i][j]);
      right.y = getAdjustedPosition((j + 1) * cellSize, j * cellSize, grid[i + 1][j + 1], grid[i + 1][j]);
      line(left.x, left.y, right.x, right.y);
      break;
      
    case 13: //TL + BR + BL
    
      //finds position for top.x and right.y
      top.x = getAdjustedPosition((i + 1) * cellSize, i * cellSize, grid[i + 1][j], grid[i][j]);
      right.y = getAdjustedPosition(j * cellSize, (j + 1) * cellSize, grid[i + 1][j], grid[i + 1][j + 1]);
      line(top.x, top.y, right.x, right.y);
      break;
      
    case 14: //TR + BR + BL
    
      //finds position for top.x and left.y
      top.x = getAdjustedPosition(i * cellSize, (i + 1) * cellSize, grid[i][j], grid[i + 1][j]);
      left.y = getAdjustedPosition(j * cellSize, (j + 1) * cellSize, grid[i][j], grid[i][j + 1]);
      line(top.x, top.y, left.x, left.y);
      break;
      
    //case 15: //TL + TR + BR + BL (never processed because identical to case 0)
    default:
  }
}

void printDebugInformation(){
  // points, squares and point values (debug info)
  for(int i = 0; i < cols - 1; i++){
    for(int j = 0; j < rows - 1; j++){
      if(i < cols - 2 && j < rows - 2){ //draws squares
        stroke(255);
        strokeWeight(1);
        square(i * cellSize, j * cellSize, cellSize);
      }
      stroke(0, 0, 180); //default case for points are gray
      if(grid[i][j] >= threshold){ //highlights valid points in green
        stroke(85, 255, 255);
      }
      strokeWeight(8);
      point(i * cellSize, j * cellSize); //draws points
      
      fill(0, 0, 255);
      text(grid[i][j], i * cellSize + 4, j * cellSize + 10); //prints the values
      noFill();
    }
  }
}

float getDistanceFromCircle(int x, int y){
  // r^2 / (x - x0)^2 + (y - y0)^2 == distance of a point to a circle (values >= 1 mean point is within circle)
  float maxDist = 0;
  for(int i = 0; i < circles.length; i++){
    float xDistance = x - circles[i].xPos;
    float yDistance = y - circles[i].yPos;
    maxDist += float(circles[i].radius * circles[i].radius) / max(1.0, (xDistance * xDistance + yDistance * yDistance));
  }
  return maxDist;
}

int getStateFromCorners(float a, float b, float c, float d){
  //returns a specific integer according to the corner values (basically converting from binary to decimal with floating points)
  return ((a >= threshold) ? 1 : 0) + ((b >= threshold) ? 2 : 0) + ((c >= threshold) ? 4 : 0) + ((d >= threshold) ? 8 : 0);
}

void setup(){
  fullScreen();
  colorMode(HSB, 255, 255, 255); //HSB = Hue, Saturation, Brightness
  f = createFont("Arial", 12, true);
  textFont(f, 12);
  cols = width / cellSize + 2;
  rows = height / cellSize + 2;
  grid = new float[cols][rows];
  for(int i = 0; i < circles.length; i++){
    circles[i] = new Circle(int(random(100, width - 100)), int(random(100, height - 100)), //xPos, yPos
                            int(random(20, 80)), random(0.1, 2.5), random(0.1, 2.5)); //radius, xSpeed, ySpeed
    circles[i].hitBottom = (random(1) >= 0.5) ? true : false;
    circles[i].hitRight = (random(1) >= 0.5) ? true : false;
  }
}

void draw(){
  background(0);
  noFill();
  for(int i = 0; i < cols - 1; i++){
    for(int j = 0; j < rows - 1; j++){
      grid[i][j] = getDistanceFromCircle(i * cellSize, j * cellSize);
    }
  }
  //printDebugInformation();
  for(int i = 0; i < cols - 1; i++){
    for(int j = 0; j < rows - 1; j++){
      int state = getStateFromCorners(grid[i][j], grid[i + 1][j], grid[i + 1][j + 1], grid[i][j + 1]);
      if(state > 0){
        drawCountour(i, j, i * cellSize + cellSize/2, j * cellSize + cellSize/2, state);
      }
    }
  }
  for(int i = 0; i < circles.length; i++){
    //circles[i].show();
    circles[i].update();
  }
}

/*
Notes:
- 24 Jan: made simplified marching squares algorithm with circles
- 25 Jan: added color schemes for each object, 
- 25 Jan: fixed the getDistanceFromCircle function, now maxDist takes the sum instead of the max
- 25 Jan: added support for floating point values, finished the metaballs functions

https://jamie-wong.com/2014/08/19/metaballs-and-marching-squares/ (main article used in the making of this project)
*/
