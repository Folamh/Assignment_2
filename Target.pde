class Target extends GameObject{
  boolean hit;
  
  Target(){
    x = 250 + int(random(0, 700));  //Places the target randomly on the screen
    y = 50 + int(random(0, 400));
    
    hit = false;
  }
  
  void render(){
    if(hit){  //If the target is hit it will fade out
      stroke(125);
    }
    else{
      stroke(255, 0, 0);
    }
    rectMode(CENTER);
    rect(x, y, 40, 40);
  }
  
  void update(){//It doesn't move so this method is useless
    
  }
}