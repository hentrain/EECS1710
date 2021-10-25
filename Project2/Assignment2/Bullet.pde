class Bullet {
  
  PVector position;
  float rot;
  int timestamp;
  boolean alive = true;
  int lifetime = 2000;
  PImage bullet;

  Bullet(float x, float y, float _rot) {
    position = new PVector(x, y);
    rot = _rot;
    timestamp = millis();
    bullet = loadImage("bullet.png");
    bullet.resize(60,60);
  }
   
  void update() {
    // https://www.emanueleferonato.com/2007/04/28/create-a-flash-artillery-game-step-1/
    position.x += velocity * sin(radians(rot));
    position.y -= velocity * cos(radians(rot));
    
    // set bullets past their lifetime as not alive so they can be removed
    if (alive && millis() > timestamp + lifetime) alive = false;
  }
  
  void draw() {
    stroke(255);
    if (random(1) < 0.5) {
      fill(255, 0, 0);
    } else {
      fill(0, 0, 255);
    }
    image(bullet, position.x, position.y);
  }
  
  void run() {
    update();
    draw();  
  }
  

}
