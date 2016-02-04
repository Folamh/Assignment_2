class Target extends GameObject{
  
  Target(){
    x = 500 + int(random(0, 500));
    y = 20 + int(random(0, 450));
  }
  
  void render(){
    stroke(0);
    rectMode(CENTER);
    rect(x, y, 40, 40);
  }
  
  void update(){
    
  }
}