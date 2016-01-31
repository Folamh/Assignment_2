class Arrow extends GameObject{
  PVector pos;
  Boolean inUse;
  Boolean hit;
  
  Arrow(int x, int y){
    pos = new PVector(x, y);
    inUse = false;
    hit = false;
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
    if(!hit){
      pos.add(x, y);
      if(inUse){
        pos.sub(0, -0.15);
      }
    }
  }
}