class Arrow extends GameObject{
  PVector pos;
  Boolean inUse;
  
  Arrow(int x, int y){
    pos = new PVector(x, y);
    inUse = true;
  }
  
  void render(){
    stroke(0);
    line(pos.x, pos.y, pos.x - 5, pos.y - 3);
    line(pos.x, pos.y, pos.x - 5, pos.y + 3);
    line(pos.x - 5, pos.y - 3, pos.x - 5, pos.y + 3);
    line(pos.x - 5, pos.y, pos.x - 25, pos.y);
    line(pos.x - 23, pos.y, pos.x - 25, pos.y - 3);
    line(pos.x - 23, pos.y, pos.x - 25, pos.y + 3);
    line(pos.x - 21, pos.y, pos.x - 23, pos.y - 3);
    line(pos.x - 21, pos.y, pos.x - 23, pos.y + 3);
    line(pos.x - 19, pos.y, pos.x - 21, pos.y - 3);
    line(pos.x - 19, pos.y, pos.x - 21, pos.y + 3);
  }
  
  void update(){
    
  }
  
  void shoot(float vX, float vY){
    pos.set(vX, vY);
  }
}