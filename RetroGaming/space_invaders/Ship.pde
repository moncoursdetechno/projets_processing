class Ship extends Entity 

{float minLimit;
 float maxLimit;
 float shipVelocity = 3;
  
 Ship(float x_, float y_) 
 {super(new PVector(x_, y_));
  this.minLimit = width*0.05;
  this.maxLimit = width*0.95;}

 Ship()
 {super(new PVector(width/2, height*0.9));
  super.setHitbox(new PVector(-15, -10), new PVector(30, 14));
  this.minLimit = width*0.05;
  this.maxLimit = width*0.95; }

 public void display() 
 {float x = location.x;
  float y = location.y;
  noStroke();
  fill(0, 255, 0);
  rectMode(CENTER);
  rect(x, y, 30, 14);rect(x, y - 10, 6, 6);rect(x, y - 14, 2, 2);
  fill(0);
  rect(x-14, y-6, 2, 2);rect(x+14, y-6, 2, 2);}

 void move(float delta)
 {location.x = constrain(location.x+delta, minLimit, maxLimit);}
  
 void moveLeft()
 {move(-shipVelocity);}
  
 void moveRight()
 {move(shipVelocity);}
  
 void setPosition(float newPosition)
 {location.x = constrain(newPosition, minLimit, maxLimit);}}