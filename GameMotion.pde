class GameMotion{
  
  GameMotion(){}
  
  void moveStars(){
    ArrayList<Star> stars = Controller.stars;
    if(!stars.isEmpty()){
      for(int i=0; i<stars.size(); i++){
        if (stars.get(i).x < 0){
          stars.remove(i);
        }
        stars.get(i).drawStar();
        stars.get(i).moveStar(Controller.speed);
        if(stars.get(i).hasTouchedSpecialStar(mouseX, mouseY)){
          Controller.giveShield = true;
          stars.remove(i);
          Controller.startShieldTime = millis();
        }
      }
    }
    Controller.stars = stars;
  }
  
  void movePlanets(){
    ArrayList<Planet> planets = Controller.planets;
    if(!planets.isEmpty()){
      for(int i=0; i<planets.size(); i++){
        planets.get(i).drawPlanet();
        planets.get(i).movePlanet(Controller.speed);
        if(planets.get(i).x < -planets.get(i).size){
          planets.remove(i);
        }
      }
    }
    Controller.planets = planets;
  }

  void moveAsteroids(){
    ArrayList<Asteroid> asteroids = Controller.asteroids;
    for(int i=0; i<asteroids.size(); i++){
      if(asteroids.get(i).x < -asteroids.get(i).size || (Controller.giveShield && asteroids.get(i).hasTouchedAsteroid(mouseX, mouseY))){
        asteroids.remove(i);
      }else{
        asteroids.get(i).drawAsteroid();
        asteroids.get(i).moveAsteroid(Controller.speed);
        if(!Controller.giveShield && asteroids.get(i).hasTouchedAsteroid(mouseX, mouseY)){
          Controller.gameOver = true;
        }
      }
    }
    Controller.asteroids = asteroids;
  }
  
  void moveFallingStar(){
    Controller.fallingStar.drawFallingStar();
  }
}
