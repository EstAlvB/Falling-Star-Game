class Planet{

  float x;
  float y;
  float gray;
  int size, i;
  PImage planet;
  
  Planet(float x, float y, int i){
    this.x = x;
    this.y = y;
    this.i = i;
    size = (int)random(50, 700);
    gray = map(size, 50, 700, 50, 200);
    planet = loadImage("planet"+str(i)+".png");
  }
  
  void drawPlanet(){
    tint(gray);
    planet.resize(size, 0);
    imageMode(CENTER);
    image(planet, x, y);
    noTint();
  }
  
  void movePlanet(int speed){
    x-=speed;
  }
}
