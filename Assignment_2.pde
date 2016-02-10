/*Global Variables*/
int gameState = 0;
int wait;
int wait2;
int wait3;
int timer;
boolean runOnce = true;
boolean paused;
boolean scoresName;
int score;
String name;
String highscore;
String scores[];
ArrayList<String> toLoad = new ArrayList<String>();

/*Game Objects*/
ArrayList<GameObject> targetObjects = new ArrayList<GameObject>();

/*Output*/
PrintWriter output;

/*Setup*/
void setup(){
  size(1000, 500);
  if(runOnce){
    scores = loadStrings("highscore.txt");
    runOnce = false;
    for(int i = 0; i < scores.length; i++){
      toLoad.add(scores[i]);
    }
  }
  
  /*Init. Variables*/
  score = wait = wait2 = wait3 = timer = 0;
  scoresName = false;
  paused = false;
  name = "";
  
  /*Target Objects Init.*/
  targetObjects.clear();
  targetObjects.add(new Archer(20, height - 50));
  targetObjects.add(new Target());
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
        
      case 2: /*Shoot Targets*/
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
        
      case 3: /*Highscores*/
        gameState = loadScores();
        break;
        
      default:    //Error handling.
        println("ERROR: gameState broke switch.");
        break;
    }
  }
}

/*Methods*/
int loadStart(){    /*Start Screen*/
  background(0);
  fill(255);
  textAlign(CENTER);
  text("Press any key to start", width/2, height - 20);
  textSize(50);
  text("ARCHER", width/2, height/2);
  textSize(16);
  
  if(keyPressed){    //Input into gameState.
    return 1;
  }
  else{
    return 0;
  }
}

int loadMenu(){    /*Main Menu*/
  background(0);
  int buttonXTM = width/2;
  int buttonYTM = height/2 - 50;
  int buttonXVM = width/2;
  int buttonYVM = height/2;
  int buttonXHS = width/2;
  int buttonYHS = height/2 + 50;
  
  /*If hover overed the buttons will highlight blue*/
  if(mouseX >= (buttonXTM - 55) && mouseX <= (buttonXTM + 55) && mouseY >= (buttonYTM - 15) && mouseY <= (buttonYTM)){
      fill(25, 25, 125);
  }
  else{
    fill(255);
  }
  text("Shoot Targets", buttonXTM, buttonYTM);
  
  if(mouseX >= (buttonXVM - 55) && mouseX <= (buttonXVM + 55) && mouseY >= (buttonYVM - 15) && mouseY <= (buttonYVM)){
      fill(25, 25, 125);
  }
  else{
    fill(255);
  }
  text("Highscores", buttonXVM, buttonYVM);
  
  if(mouseX >= (buttonXHS - 55) && mouseX <= (buttonXHS + 55) && mouseY >= (buttonYHS - 15) && mouseY <= (buttonYHS)){
      fill(25, 25, 125);
  }
  else{
    fill(255);
  }
  text("Exit", buttonXHS, buttonYHS);
  
  if(mousePressed){    //Checks if the button is clicked
    if(mouseX >= (buttonXTM - 55) && mouseX <= (buttonXTM + 55) && mouseY >= (buttonYTM - 20) && mouseY <= (buttonYTM + 20)){
      return 2;    //Shoot Targets
    }
    if(mouseX >= (buttonXVM - 55) && mouseX <= (buttonXVM + 55) && mouseY >= (buttonYVM - 20) && mouseY <= (buttonYVM + 20)){
      return 3;    //Highscores
    }
    if(mouseX >= (buttonXHS - 55) && mouseX <= (buttonXHS + 55) && mouseY >= (buttonYHS - 20) && mouseY <= (buttonYHS + 20)){
      exit();    //Exit
    }
  }
  return 1;
}

int loadTarget(){
  background(255);
  if(timer < 0.5*60*60){    //Game timer check
    float time = (0.5*60*60) - float(timer);
    text(String.format("%.0f", time), width/2, 50);
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
    if(wait3 < 60){    //Wait timer to help stop input carry over
      background(0);
      wait3++;
      scoresName = true;
    }
    else{
      background(0);
      int buttonXTM = width/2;
      int buttonYTM = height/2 - 50;
      int buttonXVM = width/2;
      int buttonYVM = height/2;
      int buttonXHS = width/2;
      int buttonYHS = height/2 + 50;
      
      fill(255);
      textAlign(RIGHT);
      text("Name (3 characters):", 450, 150);
      textAlign(CENTER);
      text(name, width/2, 150);
      fill(125);
      text("Press enter to confirm", width/2, 170);
      
      fill(255);
      text("Score: " + score, buttonXTM, buttonYTM);
      
          //Highlighter
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
      
      if(mousePressed){    //Button check
        if(mouseX >= (buttonXVM - 55) && mouseX <= (buttonXVM + 55) && mouseY >= (buttonYVM - 20) && mouseY <= (buttonYVM + 20)){
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

int loadScores(){ /*Highscores*/
  background(0);
  fill(255);
  for(int i = 0; i <= 10 && i < toLoad.size(); i++){    //Shows the scores on screen
    textAlign(CENTER);
    text("#" + (i+1) + " " + toLoad.get(i), width/2, 50 + ((height - 100)/10)*i);
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
  return 3;
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
    if(key == RETURN || name.length() >= 3){
      toLoad.add(name + " " + String.format("%03d", score));  //formats the name and score in the format used in the file
      String temp;
      for(int i = 0; i < ( toLoad.size() - 1 ); i++){
        for(int j = 0; j < toLoad.size() - i - 1; j++){
          if(Integer.parseInt(toLoad.get(j).substring(5, 7)) < Integer.parseInt(toLoad.get(j+1).substring(5, 7))){    //Bubble sort of the scores
              temp = toLoad.get(j);
              toLoad.set(j, toLoad.get(j+1));
              toLoad.set(j+1, temp);
           }
        }
      }
      output = createWriter("data\\highscore.txt"); //Creates the file to write to
      for(int i = 0; i < 10 && i < toLoad.size(); i++){    //Output to file
        println(toLoad.get(i));
        output.println(toLoad.get(i));
      }
      output.flush();
      output.close();    //Closes the file
      scoresName = false;
    }
    else{    //Takes keyboard input, coverts it to uppercase
      name += key;
      name = name.toUpperCase();
    }
  }
}