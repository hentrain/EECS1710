import gifAnimation.*;

Gif bird;
PImage spring, flower;
float x, x2;
float y, y2;
float speedX = 5, speedX2 = 9;

public void setup() {
  size(1200, 1000);
  frameRate(100);
  
   spring = loadImage("spring.jpg");
   flower = loadImage("flower.png");
  x = width/2;
  y = height/2;
  x2 = width/4;
  y2 = height/4;
  imageMode(CENTER);
  
  println("gifbird " + Gif.version());
  bird = new Gif(this, "blueBird.gif");
  bird.loop();
}

void draw() {
  background(125, 255, 0);
    x += speedX;
    x2 += speedX2;
    
    image(spring, x, y, width*2, height*2);
    image(bird, x2, y2, width/2, height/2);

  if (x > width || x < 0) {
    speedX *= -1;
    speedX2 *= -1.2;
  }  
  image(spring, x, y, spring.width * (height / spring.height), height);
  image(bird, x2, y2, width/2, height/2);
  for(int i = 0; i < 10; i++ ){
    image(flower, 50 + i*120, 1000, width/4, height/2.5);
  }
}
