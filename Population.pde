class Population{

  Chrome[] population = new Chrome[GA.NUM_POP];
  
  public Population(){
    for(int i=0;i<population.length;i++){
      population[i] = new Chrome(GA.START_X, GA.START_Y, 0.3, 0.995);
    }
  }
  
  public Chrome getFittest(){
    
    Chrome fit = population[0];
    for(int i=1;i<population.length;i++){
      if(population[i].fitness() > fit.fitness() /*&& population[i].alive*/){
        fit = population[i];
      }
  }
    
    return fit;
  }
}