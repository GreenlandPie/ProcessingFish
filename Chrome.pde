class Chrome{
  
  double crossoverRate, mutationRate;
  double[] genes = new double[GA.NUM_CHROMOSOMES];
  
  float angle;
  
  int timeStart, timeDead, timeReached=GA.NUM_CHROMOSOMES;
  
  int x, y;
  int r, g, b;
  
  boolean alive, reached;
  
  float closestDistance=width*height, finalDistance;
  
  public Chrome(int x, int y, double cRate, double mRate){
    crossoverRate = cRate;
    mutationRate = mRate;
    
    this.x = x;
    this.y = y;
    
    angle = 0;
    alive = true;
    reached=false;
    
    timeStart = frameCount%GA.NUM_CHROMOSOMES;
    
    for(int i=0;i<genes.length;i++){
      genes[i] = random(-GA.EXT, GA.EXT);
    }
    
    r = int(random(100, 255));
    g = int(random(100, 255));
    b = int(random(100, 255));
  }
  
  public void setGenes(double[] newGenes){
    genes = newGenes;
  }
  
  public float distanceFromTarget(){
    return sqrt(pow((x-GA.END_X), 2)+pow((y-GA.END_Y), 2));
  }
  
  public float fitness(){
    return 1*(GA.NUM_CHROMOSOMES-finalDistance)+0.5*(GA.NUM_CHROMOSOMES-closestDistance)+0.3*(GA.NUM_CHROMOSOMES-timeDead)+1*(GA.NUM_CHROMOSOMES-timeReached);
  }
  
  public void reset(){
    x = GA.START_X;
    y = GA.START_Y;
    angle = 0;
   
    alive = true;
    reached=false;
    
    timeStart = frameCount%GA.NUM_CHROMOSOMES;
    
    finalDistance=0;
    closestDistance=width*height;
  }
  
  public void set(boolean b){
    alive=b;
  }
  
  public void move(int fRate){
    
    angle += genes[fRate];
    
    this.x += GA.MOVE*cos(angle);
    this.y += GA.MOVE*sin(angle);
  }
  
  public void check(Wall[] walls){
    if(alive){
      for(int i=0;i<walls.length;i++){
        if(this.x > walls[i].x && this.y > walls[i].y && this.x < (walls[i].x+walls[i].wallWidth) && this.y < (walls[i].y+walls[i].wallHeight)){
          GA.deads++;
          timeDead = frameCount%GA.NUM_CHROMOSOMES;
          finalDistance = distanceFromTarget();
          set(false);
          break;
        }
      }
      
      if(x<0 || y<0 || x>width || y>height){
          GA.deads++;
          finalDistance = distanceFromTarget();
          timeDead = frameCount%GA.NUM_CHROMOSOMES;
          set(false);
      }
    }
  }
  
  public void display(){
    fill(r, g, b);
    stroke(0);
    
    pushMatrix();
    translate(x, y);
    rotate(angle-PI/2);
    triangle(-5, -5, 5, -5, 0, 10);
    popMatrix();  
  }
}