/*Global Variables*/
int gameState = 0;
Archer bowMan;

/*Setup*/
void setup(){
  size(1000, 500);
  bowMan = new Archer(20, height - 50);
}

/*Draw*/
void draw(){
  switch(gameState){
    case 0: /*Start Menu*/
      gameState = loadStart();
      break;
    case 1: /*Main Menu*/
      gameState = loadMenu();
      break;
    case 2: /*Target Mode*/
      gameState = loadTarget();
      break;
    case 3: /*Versus Mode*/
      gameState = loadVersus();
      break;
    case 4: /*Highscores*/
      gameState = loadScores();
      break;
    default:
      println("ERROR: gameState broke switch.");
      break;
  }
}

/*Methods*/
int loadStart(){/*Start Screen*/
  background(0);
  fill(255);
  textAlign(CENTER);
  text("Press any key to start", width/2, height - 20);
  textSize(50);
  text("HUNTER", width/2, height/2);
  textSize(16);
  if(keyPressed){
    return 1;
  }
  else{
    return 0;
  }
}

int loadMenu(){/*Main Menu*/
  background(0);
  int buttonXTM = width/2;
  int buttonYTM = height/2 - 50;
  int buttonXVM = width/2;
  int buttonYVM = height/2;
  int buttonXHS = width/2;
  int buttonYHS = height/2 + 50;
  
  if(mouseX >= (buttonXTM - 55) && mouseX <= (buttonXTM + 55) && mouseY >= (buttonYTM - 15) && mouseY <= (buttonYTM)){
      fill(25, 25, 125);
  }
  else{
    fill(255);
  }
  text("Target Mode", buttonXTM, buttonYTM);
  
  if(mouseX >= (buttonXVM - 55) && mouseX <= (buttonXVM + 55) && mouseY >= (buttonYVM - 15) && mouseY <= (buttonYVM)){
      fill(25, 25, 125);
  }
  else{
    fill(255);
  }
  text("Versus Mode", buttonXVM, buttonYVM);
  
  if(mouseX >= (buttonXHS - 55) && mouseX <= (buttonXHS + 55) && mouseY >= (buttonYHS - 15) && mouseY <= (buttonYHS)){
      fill(25, 25, 125);
  }
  else{
    fill(255);
  }
  text("Highscores", buttonXHS, buttonYHS);
  
  if(mousePressed){
    if(mouseX >= (buttonXTM - 55) && mouseX <= (buttonXTM + 55) && mouseY >= (buttonYTM - 20) && mouseY <= (buttonYTM + 20)){
      return 2;
    }
    if(mouseX >= (buttonXVM - 55) && mouseX <= (buttonXVM + 55) && mouseY >= (buttonYVM - 20) && mouseY <= (buttonYVM + 20)){
      return 3;
    }
    if(mouseX >= (buttonXHS - 55) && mouseX <= (buttonXHS + 55) && mouseY >= (buttonYHS - 20) && mouseY <= (buttonYHS + 20)){
      return 4;
    }
  }
  return 1;
}

int loadTarget(){
  background(255);
  bowMan.update();
  bowMan.render();
  
  return 2;
}

int loadVersus(){
  return 3;
}

int loadScores(){
  return 4;
}