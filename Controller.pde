static class Controller{
  //GAME CONTROLLERS
  static ArrayList <Star> stars = new ArrayList<>();
  static ArrayList <Planet> planets = new ArrayList<>();
  static ArrayList <Asteroid> asteroids = new ArrayList<>();
  static FallingStar fallingStar;
  static float lastPlanetTime = 0;
  static float lastAsteroidTime = 0;
  static float lastStarTime = 0;
  static float startShieldTime = 0;
  static int genStarInterval = 30;
  static int genPlanetInterval = 6000;
  static int genAsteroidInterval = 3000;
  static boolean gameOver = false;
  static boolean giveShield = false;
  static int speed = 5;
  static int UATraveled = 0;
  
  //SOUND CONTROLLERS
  static float alphaFallingStar = 5;
  static ArrayList<HashMap<String, Integer>> presenceCirclesData = new ArrayList<HashMap<String, Integer>>();
  static float zoom = 1.0;
}
