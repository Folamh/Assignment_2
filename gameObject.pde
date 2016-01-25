abstract class GameObject{
  int x, y;
  
  GameObject(){
    
  }
  
  abstract void render();
  abstract void update();
}