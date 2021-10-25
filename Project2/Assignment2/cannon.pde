class Cannon {

  PVector position;
  ArrayList<Bullet> bullets;
  PImage cannon;
  boolean armRecoil = false;
  float recoilAmount = 4;
  
  Cannon(float x, float y) {
    position = new PVector(x, y);
    bullets = new ArrayList<Bullet>();
    cannon = loadImage("cannon.png");
    cannon.resize(200, 200);
  }
  
  void update() {
    rot += rotDelta;    
    if (rot < -90 || rot > 90) rotDelta *= -1;  
    
    // remove bullets that are no alive
    for (int i=bullets.size()-1; i>=0; i--) {
      Bullet bullet = bullets.get(i);
      if (bullet.alive) {
        bullet.run();
      } else {
        bullets.remove(i);
      }
    }
  }
  
  void fire() {
    bullets.add(new Bullet(position.x, position.y, rot + rotDelta*2));
    armRecoil = true;
  }
  
  void draw() {
    fill(0); 
    imageMode(CENTER);
    //rotating cannon
    pushMatrix(); 
    if (armRecoil) {
      translate(position.x, position.y + recoilAmount);
    } else {
      translate(position.x, position.y);
    }
    
    rotate(radians(rot));
    line(position.x, position.y,position.x*2, position.y*2);
    image(cannon, 0, 0);
    popMatrix();
  }
  
  void run() {
    update();
    draw();
  }

}
