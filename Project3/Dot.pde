class Dot {

  PVector position, target;
  color col;
  float speed;
  float dotSize;
  boolean ready;
  
  Dot(float x, float y, color _col, PVector _target) {
    position = new PVector(x, y);
    col = _col;
    target = _target;
    speed = ampValue;
    dotSize = 10;
    ready = false;
  }
  
  void update() {
    //adjust the value of amp so the moving speed of the dot wont be too small or too big to recognize
    if(ampValue < 0.01){
      ampValue = 0.01;
    }else if(ampValue > 0.12){
      ampValue = 0.12;
    }
    position.lerp(target, ampValue);
    ready = position.dist(target) < 8;

  }
  
  void draw() {
    stroke(color(random(0,200), random(0, 200), random(0, 200),random(0,60)));
    strokeWeight(dotSize);
    point(position.x, position.y);
  }
  
  void run() {
    update();
    draw();
  }

}
