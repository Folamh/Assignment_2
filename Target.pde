class Target extends GameObject{
  
  Target(){
    x = 500 + int(random(0, 500));
    y = 20 + int(random(0, 450));
  }
  
  void render(){
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(x, y, 6, 30);
  }
  
  void update(){
    
  }
}