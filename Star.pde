class Star{
  
  float x;
  float y;
  float radius1;
  float radius2;
  int npoints;
  float alpha;
  boolean specialStar;
  
  Star(float x, float y, float radius1, float radius2, int npoints) {
    this.x = x;
    this.y = y;
    this.radius1 = radius1;
    this.radius2 = radius2;
    this.npoints = npoints;
    specialStar = false;
  }
  
  void drawStar(){
    noStroke();
    if(specialStar){
      fill(255, random(0, 255));
    }else{
      fill(255, alpha);
    }
    
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    createShape();
    beginShape();
      for (float a = 0; a < TWO_PI; a += angle) {
        float sx = x + cos(a) * radius2;
        float sy = y + sin(a) * radius2;
        vertex(sx, sy);
        sx = x + cos(a+halfAngle) * radius1;
        sy = y + sin(a+halfAngle) * radius1;
        vertex(sx, sy);
      }
    endShape(CLOSE);
  }
  
  void moveStar(int speed){
    x-=speed;
  }
  
  void setAlpha(float alpha){
    this.alpha = alpha;
  }
  
  void setAsSpecialStar(){
    specialStar = true;
    radius1 += 4;
    radius2 += 4;
  }
  
  boolean hasTouchedSpecialStar(float mx, float my){
    if (mx > x-10 && mx < x+10 && my > y-10 && my < y+10 && specialStar == true){
      return true;
    }
    return false;
  }
}
