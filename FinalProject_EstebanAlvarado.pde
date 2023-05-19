import gifAnimation.*; //<>//
import ddf.minim.*;
import ddf.minim.analysis.*;

Factory factory;
GameMotion gameMotion;
SoundEffects se;
Minim minim = new Minim(this);
AudioPlayer player;

void setup(){
  size(1000, 700);
  factory = new Factory();
  gameMotion = new GameMotion();
  selectInput("Select a file to process:", "setGameSound");
  noLoop();
}

void draw(){
  if(player!=null){
    se = new SoundEffects(player);
    factory.createFallingStar();
    se.bassEffects();
    se.speedMode();
    if(genStar()){factory.createStar();}
    if(genAsteroid()){factory.createAsteroid();}
    if(genPlanet()){factory.createPlanet();}
    se.circleHighsEffects(factory);
    gameMotion.moveStars();
    gameMotion.movePlanets();
    gameMotion.moveAsteroids();
    if(shieldIsAvailable()){factory.createShield();}
    gameMotion.moveFallingStar();
    Controller.UATraveled++;
    showScore();
    if(Controller.gameOver){gameOver();}
    se.fallingStarMode();
    if(Controller.speed == 8){filter(DILATE);}
  }
}

boolean genStar(){
  if(millis() - Controller.lastStarTime > Controller.genStarInterval){
    return true;
  }
  return false;
}

boolean genAsteroid(){
  if(millis() - Controller.lastAsteroidTime > Controller.genAsteroidInterval){
    return true;
  }
  return false;
}

boolean genPlanet(){
  if(millis() - Controller.lastPlanetTime > Controller.genPlanetInterval){
    return true;
  }
  return false;
}

boolean shieldIsAvailable(){
  if(Controller.giveShield && millis() - Controller.startShieldTime < 5000){
    return true;
  }else{
    Controller.giveShield = false;
    return false;
  }
}

void setGameSound(File selection){
  if(selection!=null){
    player = minim.loadFile(selection.getAbsolutePath());
    player.play();
    loop();
  }
}

void gameOver(){
  fill(0);
  rect(0, 0, width, height);
  fill(255, 0, 0);
  textSize(100);
  textAlign(CENTER, CENTER);
  text("GAME OVER", width/2, height/2);
  fill(255);
  textSize(80);
  textAlign(CENTER, BOTTOM);
  text("UA Traveled: " + str(Controller.UATraveled), width/2, height);
  se.stopMusic();
  noLoop();
}

void showScore(){
  textSize(60);
  fill(255);
  textAlign(RIGHT, BOTTOM);
  text("UA: " + str(Controller.UATraveled), width, height);
}
