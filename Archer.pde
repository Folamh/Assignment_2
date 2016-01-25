class Archer extends GameObject{
  int handX;
  int armX;
  int armY;
  float vX, vY, x1, y1, x2, y2;
  boolean firing;
  
  ArrayList<Arrow> arrows;
  
  Archer(int x, int y){
    this.x = x;
    this.y = y;
    
    vX = 0;
    vY = 0;
    x1 = 0;
    y1 = 0;
    x2 = 0; 
    y2 = 0;
    
    handX = x + 10;
    armX = x + 5;
    armY = y + 3;
    
    firing = false;
    
    arrows = new ArrayList<Arrow>();
  }
  
  void render(){
    stroke(0);
    fill(0);
    
    drawArcher();
    pull();
  }
  
  void update(){
    
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

  void pull(){
    if((mousePressed) && (firing == false)){
      x1 = mouseX;
      y1 = mouseY;
      println("Pressed");
      firing = true;
    }
    if((mousePressed == false) && (firing)){
      x2 = mouseX;
      y2 = mouseY;
      println("Released");
      firing = false;
    }
    
    vX = x1 - mouseX;
    vY = y2 - mouseY;
    
    if(firing){
      line(x1, y1, mouseX, mouseY);
      text(atan(vX/vY) + " " + abs(degrees(atan(vX/vY))) + "°", mouseX - 20, mouseY - 10);
    }
    
    vX = x1 - x2;
    vY = y2 - y1;
  }
}