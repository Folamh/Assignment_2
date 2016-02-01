class Arrow extends GameObject{
  PVector pos;
  PVector aim;
  Boolean inUse;
  Boolean hit;
  float gravity;
  
  Arrow(int x, int y){
    pos = new PVector(x, y);
    aim = new PVector(0, 0);
    inUse = false;
    hit = false;
    gravity = 0;
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
    if(pos.y > height - 30){
      hit = true;
    }
    if(!hit){
      if(inUse){
        aim.sub(0, - gravity);
        gravity += 0.05;
      }
      pos.add(aim);
    }
  }
}