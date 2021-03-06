class Arrow extends GameObject{
  PVector pos;
  PVector aim;
  PVector plane;
  Boolean inFlight;
  Boolean hit;
  float gravity;
  float angle;
  
  Arrow(int x, int y){
    pos = new PVector(x, y);
    aim = new PVector(0, 0);
    plane = new PVector(0, 0);
    plane.set(10, 0);
    inFlight = false;
    hit = false;
    gravity = 0;
  }
  
  void render(){
    angle = PVector.angleBetween(aim, plane);    //This beauty gives the arrow a trail while it moves.
    if(aim.y < 0) angle = - angle;
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    stroke(0);
    line(0, 0, -5, - 3);
    line(0, 0, -5, 3);
    line(-5, -3, -5, 3);
    line(-5, 0, - 25, 0);
    line(-23, 0, -25, -3);
    line(-23, 0, -25, 3);
    line(-21, 0, -23, -3);
    line(-21, 0, -23, 3);
    line(-19, 0, -21, -3);
    line(-19, 0, -21, 3);
    popMatrix();
  }
  
  void update(){
    if(pos.y > height - 25){    //Checks if it hit the ground
      hit = true;
    }
    if(!hit){    //Checks if it has hit anything, if not run code
      if(inFlight){    //Apply gravity
        aim.sub(0, - gravity);
        gravity += 0.05;
      }
      pos.add(aim);
    }
  }
}