class Factory{
  
  Factory(){}
  
  void createPlanet(){
    Planet planet = new Planet(
        random(width+600, width*2), 
        random(0, height), 
        (int)random(1, 6)
    );
    Controller.planets.add(planet);
    Controller.lastPlanetTime = millis();
  }
  
  void createAsteroid(){
    Asteroid asteroid = new Asteroid(
        random(width, width*2), 
        random(-height, height*2), 
        (int)random(100, 300), 
        (int)random(1, 4)
    );
    Controller.asteroids.add(asteroid);
    Controller.lastAsteroidTime = millis();
  }
  
  void createStar(){
    Star star = new Star(random(width, width*2), random(0, height), 2, 5, 7);
    star.setAlpha(random(100, 255));
    if(frameCount%200 == 0){
      star.setAsSpecialStar();
    }
    Controller.stars.add(star);
    Controller.lastStarTime = millis();
  }
  
  void createFallingStar(){
    Controller.fallingStar = new FallingStar(mouseX, mouseY, 30, 40, color(247, 242, 75));
  }
  
  void createShield(){
    blendMode(ADD);
    noFill();
    color c1 = color(255);
    color c2 = color(0, 0);
    for(float i=0; i<=80; i++){
      float t = map(i, 0, 80, 0, 1);
      color c = lerpColor(c1, c2, t);
      stroke(c);
      circle(mouseX, mouseY, i);
    }
    blendMode(BLEND);
  }
  
  void createSoundCircle(int level){
    HashMap<String, Integer> item = new HashMap<>(){{
      put("diameter", (int)random(60, 100));
      put("x", (int)random(0, width));
      put("y", (int)random(0, height));
      put("alpha", (int)map(level, 30, 0, 0, 100));
      put("level", level);
    }};
    Controller.presenceCirclesData.add(item);
  }
}
