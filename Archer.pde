class Archer extends GameObject{
  /*Variables*/
  int handX;
  int armX;
  int armY;
  float vX, vY, x1, y1, x2, y2;
  boolean firing;
  PVector aim;
  PVector arm;
  float angle;
  PVector plane;
  AudioPlayer shoot;
  
  /*Arrows*/
  ArrayList<Arrow> arrows;
  int curArrow;
  
  Archer(int x, int y){
    shoot = minim.loadFile("shoot.wav", 2048);
    this.x = x;
    this.y = y;
    aim = new PVector(0, 0);
    arm = new PVector(0, 0);
    plane = new PVector(0, 0);
    plane.set(10, 0);
    
    vX = vY = x1 = y1 = x2 = y2 = 0;
    
    handX = 10;
    armX = 5;
    armY = 3;
    
    firing = false;
    
    /*Load the first Arrow*/
    arrows = new ArrayList<Arrow>();
    curArrow = -1;
    loadArrow();
  }
  
  void render(){
    textAlign(CENTER);    //Instructions to play
    fill(125);
    if(curArrow == 0) text("Click, hold & drag the mouse to aim, release to fire", width/2, height/2);
    
    stroke(0);
    fill(0);
    
    for(int i = 0; i < curArrow; i++){    //Render the shot arrows
      arrows.get(i).render();
    }
    if(arrows.get(curArrow).inFlight == true){     //If the arrow is in flight render it
      arrows.get(curArrow).render();
    }
    
    drawArcher();    //Call the fucion that just draws the archer without arms
    if(firing){
      handX = int(map(arm.mag(), 0, 100, 10, 0));    //Sets the Archer pulling animation
      armX = int(map(arm.mag(), 0, 100, 5, -5));
    }
    
    angle = PVector.angleBetween(arm, plane);    //Sets the angle of the aiming
    if(arm.y < 0) angle = - angle;  //Inverts the angle so it can aim omni-directional
    pushMatrix();
    translate(x, y);
    rotate(angle);
    if(arrows.get(curArrow).inFlight == false){    //Moves the arrowback when drawing
      if(firing){
        arrows.get(curArrow).pos.sub(map(handX,10, 0, 0, 10), 0);
      }
      arrows.get(curArrow).render();
      if(firing){
        arrows.get(curArrow).pos.add(map(handX,10, 0, 0, 10), 0);
      }
    }
    drawBow();
    popMatrix();
    
  }
  
  void update(){
    pull();
    if(arrows.get(curArrow).hit == true){
      loadArrow();
    }
    
    for(Arrow a: arrows){
      a.update();
    }
  }
  
  void drawArcher(){  /*Draw Stickman*/
    ellipseMode(CENTER);
    ellipse(x, y - 10, 10, 10);
    line(x, y - 10, x, y + 10);
    line(x, y + 10, x + 2, y + 25);
    line(x, y + 10, x - 2, y + 25);
  }
  
  void drawBow(){  /*Draw Bow*/
    stroke(0);
    fill(0);
    line(0, 0, 11, 0);
    line(0, 0, armX, armY);
    line(armX, armY, handX, 0);
    line(10, 10, handX, 0);
    line(10, -10, handX, 0);
    noFill();
    curve(-10, 15, 10, -10, 10, 10, -10, -15);
    
  }

  void loadArrow(){    //Adds an new arrow to the list and sets it to the current arrow
    curArrow++;
    arrows.add(new Arrow(35, 0));
  }
  
  void pull(){    //Method for calculating the force applied to the arrow + aiming
    if((mousePressed) && (firing == false)){    //When the mouse is clicked and held
      x1 = mouseX;
      y1 = mouseY;
      println("Pressed");
      firing = true;
    }
    
    vX = vY = 0;
    vX = x1 - mouseX;
    vY = y1 - mouseY;
    
    float deg = abs(degrees(atan(vX/vY)));
    float mag = sqrt(sq(vX) + sq(vY));
    
    if(firing){    //While the mouse button is being held down
      line(x1, y1, mouseX, mouseY);
      mag = map(mag, 0, 300, 0, 100);
      if(mag > 100) mag = 100;
      text(int(mag) + " " + int(deg) + "°", mouseX - 20, mouseY - 10);
      
      arm.set(vX, vY);
      if(arm.mag() > 100) arm.setMag(100);
    }
    
    if((mousePressed == false) && (firing)){    //If the mouse is released
      shoot.play();
      shoot.rewind();
      arrows.get(curArrow).pos.set(x, y);
      x2 = mouseX;
      y2 = mouseY;
      
      vX = x1 - x2;
      vY = y1 - y2;
      
      aim.set(vX, vY);    //Main calculation for the arrow
      aim.setMag(map(aim.mag(), 0, 300, 0, 100)); //to match up with the pull indicator
      if(aim.mag() > 100) aim.setMag(100);    //Limit the max speed of the arrow
      aim.setMag(map(aim.mag(), 0, 100, 0, 35));    //Reduce to physical(ish) speeds
      arrows.get(curArrow).inFlight = true;
      arrows.get(curArrow).aim.set(aim);
      println("Released");
      
      handX = 10;
      armX = 5;
      armY = 3;
      firing = false;
    }
  }
}