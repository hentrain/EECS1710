//universal variables
float friction = 0.99;
float floor;
//cannon rotation
float rot = 0;
float rotDelta = 2;
//bullet speed
 float velocity = 15;
//dragon movement
float movementSpeed = 0.006;

Cannon cannon;
ArrayList<Enemy> dragons;
ArrayList<Explosion> explosions;
int timeInterval = 1300;
int markTime = 0;
boolean debug = true;
color debugColor = color(255, 80, 80);

int point = 10;
int pointCost = 1;
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
  
  if (t > markTime + timeInterval) {
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
  if (point < 0){
    text("Game Over", width/2, height/2);
    rotDelta = 0;
    movementSpeed = 0;
  }else{
    text(point, width/2, height/2);
  }
  
      //Stage point detection
  if(point < 50){
    textSize(84);
    text("Stage1", width/2, height/2 + 100);
     
    movementSpeed = 0.0065;
    timeInterval = 900;
    velocity = 20; 
  }else if(point >= 50 && point < 100){
    fill(170, 0, 0);
    text("Stage2", width/2, height/2 + 100);
    
    movementSpeed = 0.0085;
    timeInterval = 750;
    velocity = 18;
    
  }else if(point >= 100 && point < 200){
    fill(225, 0, 50);
    text("Stage3", width/2, height/2 + 100);
    
    movementSpeed = 0.01;
    timeInterval = 450;
    velocity = 15;
  }else if(point >= 200 && point < 500){
    fill(255, 0, 100);
    text("FinalStage", width/2, height/2 + 100);
    
    movementSpeed = 0.013;
    timeInterval = 180;
    velocity = 12;
    pointCost = 2;
  }else if(point >=500){
    fill(255, 0, 200);
    text("Mission Complete", width/2, height/2 + 100);
    rotDelta = 0;
    movementSpeed = 0;
    timeInterval = 99999999;
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
