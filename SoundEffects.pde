import java.util.Collections;

class SoundEffects{
  
  FFT fft;
  AudioPlayer player;
  BeatDetect beat;
  float spectrumScale;
  
  SoundEffects(AudioPlayer player){
    this.player = player;
    fft = new FFT(player.bufferSize(), player.sampleRate());
    beat = new BeatDetect();
    spectrumScale = 100;
  }
  
  void speedMode(){
    float level = getBandMixLevel("DEFAULT");
    if (frameCount%10==0){
      if(level>=0 && level<18){
        Controller.speed = 5;
      }else if(level>=18 && level<24){
        Controller.speed = 6;
      }else if(level>=24 && level<32){
        Controller.speed = 7;
      }else{
        Controller.speed = 8;
      }
    }
    if(Controller.speed == 8){
      fill(0, 90);
      rect(0, 0, width, height);
    }else{
      background(0);
    }
  }
  
  void fallingStarMode(){
    Controller.alphaFallingStar = map(getBandMixLevel("DEFAUL"), 0, 40, 5, 50);
  }
  
  void bassEffects(){
    float zoomSpeed = 0.075;
    int bassLevel = (int)getBandMixLevel("BASS");
    float targetZoom = map(bassLevel, 0, 300, 1.0, 1.20);
    Controller.zoom += (targetZoom-Controller.zoom)*zoomSpeed;
    smooth();
    translate(width/2, height/2);
    scale(Controller.zoom);
    translate(-width/2, -height/2);
  }
  
  void circleHighsEffects(Factory factory){
    noStroke();
    int preLevel = (int)getBandMixLevel("PRESENCE");
    ArrayList<HashMap<String, Integer>> pcd = Controller.presenceCirclesData;
    
    if(frameCount%15==0){
      if((preLevel>=0 && preLevel<=5) || (preLevel>=15 && preLevel<=20) || (preLevel>=40 && preLevel<=45)){
        factory.createSoundCircle(preLevel);
      }
    }
    
    if(!pcd.isEmpty()){
      for(int i=0; i<pcd.size(); i++){
        HashMap<String, Integer>item = pcd.get(i);
        if(item.get("diameter") <= 0){
          pcd.remove(i);
        }else{
          pcd.set(i, getModifiedCircle(item));
        }
      }
      Controller.presenceCirclesData = pcd;
    }
  }
  
  HashMap<String, Integer> getModifiedCircle(HashMap<String, Integer> item){
    HashMap<String, Integer> i = item;
    color c = color(20, map(i.get("level"), 30, 0, 255, 180), map(i.get("level"), 0, 30, 150, 255));
    fill(c , i.get("alpha"));
    circle(i.get("x"), i.get("y"), i.get("diameter"));
    i.put("diameter", i.get("diameter")-1);
    i.put("alpha", i.get("alpha")-1);
    return i;
  }
  
  ArrayList<Float> getSpectrum(){
    ArrayList<Float> spectrum = new ArrayList<>();
    fft.linAverages(7);
    fft.forward(player.mix);
    for(int i=0; i<fft.avgSize(); i++){
      spectrum.add(fft.getAvg(i)*spectrumScale);
    }
    return spectrum;
  }
  
  float getBandMixLevel(String band){
    switch(band){
      case "SUBBASS":
        return getSpectrum().get(0);
      case "BASS":
        return getSpectrum().get(1);
      case "LOW-MIDRANGE":
        return getSpectrum().get(2);
      case "MIDRANGE":
        return getSpectrum().get(3);
      case "UPPER-MIDRANGE":
        return getSpectrum().get(4);
      case "PRESENCE":
        return getSpectrum().get(5);
      case "BRILLIANCE":
        return getSpectrum().get(6);
      default:
        return player.mix.level()*spectrumScale;
    }
  }
  
  void stopMusic(){
    if(player.isPlaying()){
      player.pause();
    }
  }
}
