/*Global Variables*/
int gameState = 0;
int wait;
int wait2;
int wait3;
int timer;
boolean paused = false;
boolean finished;
boolean scoresName;
int score;
String name;
String highscore;
String scores[];
ArrayList<String> toLoad = new ArrayList<String>();

/*Game Objects*/
ArrayList<GameObject> targetObjects = new ArrayList<GameObject>();
ArrayList<GameObject> versusObjects = new ArrayList<GameObject>();

PrintWriter output;

/*Setup*/
void setup(){
  size(1000, 500);
  output = createWriter("highscore.txt"); 
  scores = loadStrings("highscore.txt");
  name = "";
  
  toLoad.clear();
  for(int i = 0; i < scores.length; i++){
    toLoad.add(scores[i]);
  }
  
  /*Init. Variables*/
  score = wait = wait2 = wait3 = timer = 0;
  finished = false;
  scoresName = false;
  /*Target Objects Init.*/
  targetObjects.add(new Archer(20, height - 50));
  targetObjects.add(new Target());
  
  /*Versus Objects Init.*/
  
}

/*Draw*/
void draw(){
  if(wait2 < 30){    //Wait timer to stop previous input carry over.
    wait2++;
  }
  else{
    switch(gameState){
      case 0: /*Start Menu*/
        gameState = loadStart();
        break;
        
      case 1: /*Main Menu*/
        gameState = loadMenu();
        break;
        
      case 2: /*Target Mode*/
        if (keyPressed || paused) {    //Allow pause menu.
          if (key == ' ' || paused) {
            wait = 0;
            paused = true;
            gameState = pause(gameState);
          }
        }
        else{    //Wait timer to stop previous input carry over.
          if(wait < 30){
            wait++;
          }
          else{
            gameState = loadTarget();
          }
        }
        break;
        
      case 3: /*Versus Mode*/
        if (keyPressed || paused) {    //Allow pause menu.
          if (key == ' ' || paused) {
            wait = 0;
            paused = true;
            gameState = pause(gameState);
          }
        }
        else{    //Wait timer to stop previous input carry over.
          if(wait < 30){
            wait++;
          }
          else{
            gameState = loadVersus();
          }
        }
        break;
        
      case 4: /*Highscores*/
        gameState = loadScores();
        break;
        
      default:    //Error handling.
        println("ERROR: gameState broke switch.");
        break;
    }
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
  
  if(keyPressed){//Input into gameState.
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
  if(timer < 0.2*60*60 && finished == false){    //Game timer check
    for(GameObject o: targetObjects){    //Update and render of objects.
      o.update();
      o.render();
    }
    for(int i = 0; i < targetObjects.size(); i++){    //Collision detection.
      GameObject bowMan = targetObjects.get(i);
      if(bowMan instanceof Archer){
        for(int j = targetObjects.size() - 1; j >= 0; j--){
          GameObject target = targetObjects.get(j);
          if(target instanceof Target){
            if((((Archer)bowMan).arrows.get(((Archer)bowMan).curArrow).pos.x > target.x - 20) && (((Archer)bowMan).arrows.get(((Archer)bowMan).curArrow).pos.x < target.x + 20) && (((Archer)bowMan).arrows.get(((Archer)bowMan).curArrow).pos.y > target.y - 20) && (((Archer)bowMan).arrows.get(((Archer)bowMan).curArrow).pos.y < target.y + 20) && (((Target)target).hit == false)){
              ((Archer)bowMan).arrows.get(((Archer)bowMan).curArrow).hit = true;
              ((Target)target).hit = true;
              targetObjects.add(new Target());
              score++;
            }
          }
        }
      }
    }
    timer++;
  }
  else{    //Game finished screen.
    if(wait3 < 60){
      wait++;
    }
    else{
      background(0);
      scoresName = true;
      int buttonXTM = width/2;
      int buttonYTM = height/2 - 50;
      int buttonXVM = width/2;
      int buttonYVM = height/2;
      int buttonXHS = width/2;
      int buttonYHS = height/2 + 50;
      
      fill(255);
      text("Name?(3 characters)", 250, 150);
      text(name, width/2, 150);
      text("Press enter to confirm", width/2, 170);
      
      fill(255);
      text("Score: " + score, buttonXTM, buttonYTM);
      
      if(mouseX >= (buttonXVM - 55) && mouseX <= (buttonXVM + 55) && mouseY >= (buttonYVM - 15) && mouseY <= (buttonYVM)){
          fill(25, 25, 125);
      }
      else{
        fill(255);
      }
      text("Main Menu", buttonXVM, buttonYVM);
      if(mouseX >= (buttonXHS - 55) && mouseX <= (buttonXHS + 55) && mouseY >= (buttonYHS - 15) && mouseY <= (buttonYHS)){
        fill(25, 25, 125);
      }
      else{
        fill(255);
      }
      text("Exit", buttonXHS, buttonYHS);
      
      if(mousePressed){
        if(mouseX >= (buttonXVM - 55) && mouseX <= (buttonXVM + 55) && mouseY >= (buttonYVM - 20) && mouseY <= (buttonYVM + 20)){
          paused = false;
          targetObjects.clear();
          setup();
          return 1;
        }
        if(mouseX >= (buttonXHS - 55) && mouseX <= (buttonXHS + 55) && mouseY >= (buttonYHS - 20) && mouseY <= (buttonYHS + 20)){
          paused = false;
          exit();
        }
      }
    }
  }
  stroke(0);
  line(0, height - 25, width, height - 25);
  return 2;
}

int loadVersus(){
  return 3;
}

int loadScores(){
  background(0);
  for(int i = 0; i <= 10 && i < toLoad.size(); i++){
    textMode(CENTER);
    text(toLoad.get(i), width/2, 50 + ((height - 100)/10)*i);
  }
  
  if(mouseX >= (width/2 - 55) && mouseX <= (width/2 + 55) && mouseY >= (height - 40) && mouseY <= (height - 20)){
      fill(25, 25, 125);
  }
  else{
    fill(255);
  }
  text("Main Menu", width/2, height - 20);
  if(mousePressed){
    if(mouseX >= (width/2 - 55) && mouseX <= (width/2 + 55) && mouseY >= (height - 40) && mouseY <= (height - 20)){
      return 1;
    }
  }
  return 4;
}

int pause(int game){
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
  text("Resume Game", buttonXTM, buttonYTM);
  
  if(mouseX >= (buttonXVM - 55) && mouseX <= (buttonXVM + 55) && mouseY >= (buttonYVM - 15) && mouseY <= (buttonYVM)){
      fill(25, 25, 125);
  }
  else{
    fill(255);
  }
  text("Main Menu", buttonXVM, buttonYVM);
  
  if(mouseX >= (buttonXHS - 55) && mouseX <= (buttonXHS + 55) && mouseY >= (buttonYHS - 15) && mouseY <= (buttonYHS)){
      fill(25, 25, 125);
  }
  else{
    fill(255);
  }
  text("Exit", buttonXHS, buttonYHS);
  
  if(mousePressed){
    if(mouseX >= (buttonXVM - 55) && mouseX <= (buttonXVM + 55) && mouseY >= (buttonYVM - 20) && mouseY <= (buttonYVM + 20)){
      paused = false;
      targetObjects.clear();
      setup();
      return 1;
    }
    if(mouseX >= (buttonXHS - 55) && mouseX <= (buttonXHS + 55) && mouseY >= (buttonYHS - 20) && mouseY <= (buttonYHS + 20)){
      paused = false;
      exit();
    }
  }
  return game;
}

void keyPressed(){
  if(scoresName){
      println("p1");
      if(key == RETURN || name.length() >= 3){
        println("p");
        toLoad.add(name + " " + String.format("%03d", score));
        String temp;
        for(int i = 0; i < ( scores.length - 1 ); i++){
            for(int j = 0; j < scores.length - i - 1; j++){
                if(Integer.parseInt(toLoad.get(j).substring(5)) > Integer.parseInt(toLoad.get(j+1).substring(5))){
                    temp = toLoad.get(j);
                    toLoad.set(j, toLoad.get(j+1));
                    toLoad.set(j+1, temp);
                 }
            }
        }
        for(int i = 0; i < 10 && i< toLoad.size(); i++){
          output.println(toLoad.get(i));
        }
      }
      else{
        println("P");
        name = name + key;
      }
    }
}