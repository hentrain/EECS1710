PVector position, target;
PImage bg, candy, expression, apollo01, apollo02, apollo03;

float x, y;
float easing = 0.018;
int apolloX = 355;
int apolloY = 275;

boolean angry = false;
boolean happy = false;



void setup() { 
  size(1800, 1000, P2D);
  
  bg = loadImage("space.jpg");
  candy = loadImage("food.png");
  candy.resize(300, 300);
  bg.resize(width, height);
  
  apollo01 = loadImage("apollo01.png");
  apollo01.resize(apolloX, apolloY);
  apollo02 = loadImage("apollo02.png");
  apollo02.resize(apolloX, apolloY);
  apollo03 = loadImage("apollo03.png");
  apollo03.resize(apolloX, apolloY);

  imageMode(CENTER);
}

void draw() {
  background(bg);

  
  //detect distance between apollo and the mouse cursor(candy), and reflect different reactions.
  position = new PVector(x, y);
  target = new PVector(random(width), random(height));  
  
  PVector mousePos = new PVector(mouseX, mouseY);
  angry = position.dist(mousePos) > 600;
  happy = position.dist(mousePos) < 200;
  
  if (angry) {
    expression = apollo02;
  }else if (happy){
    expression = apollo03;
  }else if (position.dist(mousePos) <= 600 || position.dist(mousePos) >= 200){
    expression = apollo01;
  }
  
  //source code from https://processing.org/examples/easing.html
  //make apollo keeps following the mouse cursor(candy), closer it gets, slower apollo moves.
 float targetX = mouseX;
  float dx = targetX - x;
  x += dx * easing ;
  
  float targetY = mouseY;
  float dy = targetY - y;
  y += dy * easing ;
  
  //make the candy exactly follow the mouse
  image(candy, mouseX, mouseY);
  image(expression, x, y);
}
