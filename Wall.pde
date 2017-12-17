class Wall{
  
  int x, y, wallWidth, wallHeight;
  
  public Wall(int x, int y, int w, int h){
    this.x=x;
    this.y=y;
    this.wallWidth=w;
    this.wallHeight=h;
  }
  
  public void display(){
    fill(255);
    rect(x, y, wallWidth, wallHeight);
  }
}