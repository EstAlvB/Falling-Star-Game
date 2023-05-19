class FallingStar{
  
  float x;
  float y;
  float radius;
  int trailLength;
  color c;
  
  FallingStar(float x, float y, float radius, int trailLength, color c){
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.trailLength = trailLength;
    this.c = c;
  }
  
  void drawFallingStar(){
    blendMode(ADD);
    noStroke();
    fill(c);
    circle(x, y, radius);
    fill(19, 221, 237, Controller.alphaFallingStar);
    circle(x, y, radius);
    Trail.positions.add(new PVector(x, y));
    drawTrail();
    drawParticles();
    blendMode(BLEND);
  }
  
  void drawTrail(){
    if(Trail.positions.size() > trailLength){
      Trail.positions.remove(0);
    }
    if(!Trail.positions.isEmpty()){
      for(int i=0; i<Trail.positions.size(); i++){
         float offsetX = map(i, 0, trailLength, trailLength*5, 0);
         fill(c, map(i, 0, trailLength, 0, 100));
         circle(Trail.positions.get(i).x-offsetX, Trail.positions.get(i).y, map(i, 0, trailLength, 0, radius));
         fill(19, 221, 237, Controller.alphaFallingStar);
         circle(Trail.positions.get(i).x-offsetX, Trail.positions.get(i).y, map(i, 0, trailLength, 0, radius));
      }
    }
  }
  
  void drawParticles(){
    float offset = radius + 20;
    if (frameCount%10==0){
      stroke(c);
      strokeWeight(4);
      for(int i=0; i<random(2, 5); i++){
        point(random(x-offset, x+offset), random(y-offset, y+offset));
      }
      noStroke();
    }
  }
}

static class Trail{
  static ArrayList<PVector> positions = new ArrayList<PVector>();
}
 
