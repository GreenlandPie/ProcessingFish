public static final int NUM_CHROMOSOMES = 1500;
public static final int NUM_POP = 500;
public static final int START_X = 500;
public static final int START_Y = 200;
public static final int END_X = 500;
public static final int END_Y = 950;
public static final int MOVE = 2;

public static final int NUM_WALLS = 4;

public static final float EXT = 0.1; 

Population currPop;

public static int deads=0;

Wall[] walls = new Wall[NUM_WALLS];

void setup(){
  size(1000, 1000);
  background(0);
  frameRate(120);
  currPop = new Population();
  
  walls[0] = new Wall(200, 500, 50, 200);
  walls[1] = new Wall(300, 500, 195, 200); 
  walls[2] = new Wall(505, 500, 195, 200);
  walls[3] = new Wall(750, 500, 50, 200);
  
  //simulate(500);
}

void draw(){
  background(0);
  
  for(int i=0;i<currPop.population.length;i++){
    currPop.population[i].display();
    currPop.population[i].check(walls);
    if(currPop.population[i].alive && !currPop.population[i].reached){
      if(currPop.population[i].distanceFromTarget()<currPop.population[i].closestDistance){
        currPop.population[i].closestDistance=currPop.population[i].distanceFromTarget();
      }    
      currPop.population[i].finalDistance = currPop.population[i].distanceFromTarget(); 
      currPop.population[i].timeDead = frameCount%GA.NUM_CHROMOSOMES;
      currPop.population[i].move(frameCount%NUM_CHROMOSOMES);
    }
  }
  
  for(int i=0;i<walls.length;i++){
    walls[i].display();
  }
  
  
  stroke(255, 0, 0);
  line(END_X, END_Y, currPop.getFittest().x, currPop.getFittest().y);
  
  for(int i=0;i<currPop.population.length;i++){
    if(currPop.population[i].distanceFromTarget() < 20){
      currPop.population[i].reached = true;
      currPop.population[i].finalDistance = 15;
      currPop.population[i].timeReached = frameCount%GA.NUM_CHROMOSOMES;
    }
  }
  
  if(frameCount%NUM_CHROMOSOMES==0){
    evolve();
  }
}

public void simulate(int gen){
    for(int i=0;i<gen;i++){
      for(int j=0;j<NUM_CHROMOSOMES;j++){
        for(int k=0;k<currPop.population.length;k++){
          currPop.population[k].check(walls);
          if(currPop.population[k].alive) currPop.population[k].move(j);
        }
      }
      
      evolve();
    }
}

public void evolve(){
  
  Population newPop = new Population();
  Chrome fittest = currPop.getFittest();
  print(fittest.fitness(), fittest.distanceFromTarget()+"\n");
  
  
  newPop.population[0] = fittest;
  newPop.population[0].reset();
  for(int i=1;i<newPop.population.length;i++){
    newPop.population[i] = crossover(fittest, currPop.population[i]);
  }
  
  currPop = newPop;
}

public Chrome crossover(Chrome a, Chrome b){

  Chrome c = new Chrome(START_X, START_Y, b.crossoverRate, b.mutationRate);
  
  for(int index=0;index<c.genes.length;index++){
    if(random(1) > b.crossoverRate){
      c.genes[index] = a.genes[index];
    }
    else{
      c.genes[index] = b.genes[index];
    }
  }
    
  for(int i=0;i<NUM_CHROMOSOMES;i++){
    if(random(1) > c.mutationRate){
      c.genes[int(random(c.genes.length))] += random(-EXT, EXT);
    }
  }
  
  return c;
}