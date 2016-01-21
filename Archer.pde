class Archer extends GameObject{
  int handX;
  int armX;
  int armY;
  
  ArrayList<Arrow> arrows;
  
  Archer(int x, int y){
    this.x = x;
    this.y = y;
    
    handX = x + 10;
    armX = x + 5;
    armY = y + 3;
    
    arrows = new ArrayList<Arrow>();
  }
  
  void render(){
    stroke(0);
    fill(0);
    
    drawArcher();
  }
  
  void drawArcher(){
    /*Draw Stickman*/
    ellipseMode(CENTER);
    ellipse(x, y - 10, 10, 10);
    line(x, y - 10, x, y + 10);
    line(x, y + 10, x + 2, y + 25);
    line(x, y + 10, x - 2, y + 25);
    
    /*Draw Bow*/
    stroke(0);
    fill(0);
    line(x, y, x + 11, y);
    line(x, y, armX, armY);
    line(armX, armY, handX, y);
    line(x + 10, y + 10, handX, y);
    line(x + 10, y - 10, handX, y);
    noFill();
    curve(x - 10, y + 15, x + 10, y - 10, x + 10, y + 10, x - 10, y - 15);
    
  }
}