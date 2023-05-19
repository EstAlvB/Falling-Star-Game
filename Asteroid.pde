class Asteroid {
  
  float x;
  float y;
  int size;
  int Y_DIRECTION;
  PImage asteroid;
  
  Asteroid(float x, float y, int size, int i){
    this.x = x;
    this.y = y;
    this.size = size;
    asteroid = loadImage("asteroid"+str(i)+".png");
    Y_DIRECTION = (int) random(2);
  }
  
  void drawAsteroid(){
    tint(150);
    asteroid.resize(size, 0);
    imageMode(CENTER);
    image(asteroid, x, y);
    noTint();
  }
  
  void moveAsteroid(int speed){
    x-=speed*1.3;
    if(Y_DIRECTION == 0){
      y-=speed*0.2;
    }else{
      y+=speed*0.2;
    }
  }

  boolean hasTouchedAsteroid(float mx, float my){
    float eof = size/2;
    if (mx > x-eof && mx < x+eof && my > y-eof && my < y+eof){
      return true;
    }
    return false;
  }
}
