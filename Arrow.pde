class Arrow extends GameObject{
  Arrow(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  void render(){
    line(x, y, x - 5, y - 3);
    line(x, y, x - 5, y + 3);
    line(x - 5, y - 3, x - 5, y + 3);
    line(x - 5, y, x - 25, y);
    line(x - 23, y, x - 25, y - 3);
    line(x - 23, y, x - 25, y + 3);
    line(x - 21, y, x - 23, y - 3);
    line(x - 21, y, x - 23, y + 3);
    line(x - 19, y, x - 21, y - 3);
    line(x - 19, y, x - 21, y + 3);
  }
}