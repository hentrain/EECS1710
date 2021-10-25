//universal variables
float friction = 0.99;
float floor;
//cannon rotation
float rot = 0;
float rotDelta = 2;
//dragon movement
float movementSpeed = 0.006;

Cannon cannon;
ArrayList<Enemy> dragons;
ArrayList<Explosion> explosions;
int carInterval = 1000;
int markTime = 0;
boolean debug = true;
color debugColor = color(255, 80, 80);
int point = 5;

PImage explosionImg, background;

void setup() {
  size(1600, 1000, P2D);
  textAlign(CENTER);
  textSize(128);
  floor = height;
  
  cannon = new Cannon(width/2, height - 100);
  dragons = new ArrayList<Enemy>();
  explosions = new ArrayList<Explosion>();

  explosionImg = loadImage("explosion.png");
  explosionImg.resize(256, 256);
  background = loadImage("background.png");
  background.resize(width, height);
  imageMode(CORNER);
}

void draw() {
  int t = millis();
  background(background);
  
  if (t > markTime + carInterval) {
    dragons.add(new Enemy());
    markTime = t;
  }
  
  cannon.run();
    
  // loop through arrays and clean up "dead" objects
  for (int i=dragons.size()-1; i>=0; i--) {
    Enemy dragon = dragons.get(i);
    
    if (dragon.alive) {
      dragon.run();
    } else {
      dragons.remove(i);
    }
  }
  
  for (int i=explosions.size()-1; i>=0; i--) {
    Explosion explosion = explosions.get(i);
    
    if (explosion.alive) {
      explosion.run();
    } else {
      explosions.remove(i);
    }
  } 
  
  //test if gameover
  if (point <0 ){
    text("Game Over", width/2, height/2);
    markTime = 0;
    rotDelta = 0;
    movementSpeed = 0;
  }else{
    text(point, width/2, height/2);
  }
  
  println("Number of bullets: " + cannon.bullets.size());
  
  surface.setTitle("Current frameRate" + frameRate);
}

boolean hitDetectRect(PVector p1, PVector p2, PVector hitbox) {
  hitbox = hitbox.copy().div(2);
  
  if (p1.x >= p2.x - hitbox.x && p1.x <= p2.x + hitbox.x && p1.y >= p2.y - hitbox.y && p1.y <= p2.y + hitbox.y) {
    return true;
  } else {
    return false;
  }

}
