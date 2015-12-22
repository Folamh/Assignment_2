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
      break;
    case 3:
      break;
    default:
      println("ERROR: gameState broke switch.");
      break;
  }
}

/*Methods*/
int loadStart(){
  background(0);
  textAlign(CENTER);
  text("Press any key to start", width/2, height/2);
  if(keyPressed){
    return 1;
  }
  else{
    return 0;
  }
}

int loadMenu(){/*Main Menu*/
  background(0);
  return 1;
}