class Target extends GameObject{
  
  Target(){
    x = 500 + random(0, 500);
    y = 20 + random(0, 450);
  }
  
  void render(){
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(5, 30);
  }
  
  void update(){
    
  }
}