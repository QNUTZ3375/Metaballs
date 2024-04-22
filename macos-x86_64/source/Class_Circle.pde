class Circle{
  float xPos, yPos;
  float xSpeed, ySpeed;
  int radius;
  boolean hitBottom = false;
  boolean hitRight = false;
  
  Circle(float x, float y, int r, float xSp, float ySp){
    xPos = x;
    yPos = y;
    radius = r;
    xSpeed = xSp;
    ySpeed = ySp;
  }
  
  void show(){
    strokeWeight(2);
    stroke(0, 0, 255);
    noFill();
    circle(xPos, yPos, radius * 2);
  }
  
  void update(){
    //updates xPos according to hitBottom and updates hitBottom according to the current xPosition
    xPos += (!hitBottom) ? xSpeed : -1 * xSpeed;
    if(!hitBottom && xPos >= width - radius){
        hitBottom = true;
    }else if(hitBottom && xPos <= radius){
        hitBottom = false;
    }
    //updates yPos according to hitRight and updates hitRight according to the current yPosition
    yPos += (!hitRight) ? ySpeed : -1 * ySpeed;
    if(!hitRight && yPos >= height - radius){
        hitRight = true;
    }else if(hitRight && yPos <= radius){
        hitRight = false;
    }
  }
}
