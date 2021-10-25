class Enemy {
  
  boolean isLeft;
  PVector position, target;
  color col = color(random(127)+127, random(127)+127, random(127)+127);
  float xMargin = 500;
  float yMargin = 150;
  boolean alive = true;
  PVector enemySize = new PVector(150, 80);
  PImage dragon, dragon2;

  Enemy() {
    float pickSide = random(1);
    float y = random(yMargin, height-yMargin*2);
    float x1, x2;
    dragon = loadImage("dragon.png");
    dragon2 = loadImage("dragon2.png");
    imageMode(CORNER);
    
    if (pickSide < 0.5) {
      isLeft = true;
      x1 = -xMargin;
      x2 = width + xMargin;
    } else {
      isLeft = false;
      x1 = width + xMargin;
      x2 = -xMargin;
    }
    position = new PVector(x1 , y);  
    target = new PVector(x2 , y);  
  }
  
  void update() {
    if (position.dist(target) < 5) {
      alive = false;
      point = point - 1;
    }
    for (Bullet bullet : cannon.bullets) {
      if (alive && hitDetectRect(position, bullet.position, enemySize)) {
        alive = false;
        explosions.add(new Explosion(position.x, position.y));
        point = point + 3;
      }
    }
    
    if (alive) position.lerp(target, movementSpeed);
  }
  
  void draw() {
    fill(col);

    //Detect different direction to generate different color dragon.
    if(isLeft == true){
      image(dragon, position.x + enemySize.x/2, position.y + enemySize.y/2, enemySize.x, enemySize.y);
    }else{
      image(dragon2, position.x + enemySize.x/2, position.y + enemySize.y/2, enemySize.x, enemySize.y);
    }
    
    if (debug) {
      fill(debugColor);
      noStroke();
      ellipse(position.x, position.y, 10, 10);
      
      stroke(debugColor);
      noFill();
      rect(position.x, position.y, enemySize.x, enemySize.y);
    }
  }
  
  void run() {
    update();
    draw();
  }
    
}
