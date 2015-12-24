/*Global Variables*/
int gameState = 0;

/*Setup*/
void setup(){
  size(1000, 500);
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
    case 2:
      background(255);
      Archer bowMan = new Archer(20, 20);
      bowMan.render();
      Arrow arrow = new Arrow(50, 50);
      arrow.render();
      break;
    case 3:
      background(255);
      break;
    default:
      println("ERROR: gameState broke switch.");
      break;
  }
}

/*Methods*/
int loadStart(){
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
  int buttonXVM = width/2;
  int buttonYVM = height/2;
  int buttonXHS = width/2;
  int buttonYHS = height/2 + 50;
  
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
    if(mouseX >= (buttonXVM - 55) && mouseX <= (buttonXVM + 55) && mouseY >= (buttonYVM - 20) && mouseY <= (buttonYVM + 20)){
      return 2;
    }
    if(mouseX >= (buttonXHS - 55) && mouseX <= (buttonXHS + 55) && mouseY >= (buttonYHS - 20) && mouseY <= (buttonYHS + 20)){
      return 3;
    }
  }
  return 1;
}