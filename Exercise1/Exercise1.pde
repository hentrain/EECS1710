color bgColor = color(255, 255, 255);
float circleSize = 5;
float randomColor = 0;

void setup() {
  size(1200, 1200, P3D);
  frameRate(60);
  background(bgColor);
}

void draw() {
  rectMode(RADIUS);
  fill(bgColor, 0);
  rect(600, 600, 500, 500);
  
  ellipseMode(CENTER);
  rectMode(CENTER);
  line(mouseX, mouseY, pmouseX, pmouseY);
  rect(mouseX, mouseY, circleSize, circleSize);

  textSize(30);
  fill(randomColor, randomColor+50, randomColor-50);
  String s = "Press your mouse to reset and change everything.";
  text(s, 100, 70);
  
  if (mousePressed) {
    background(random(255), random(255), random(255));
    stroke(random(255), random(255), random(255));
    strokeWeight(random(5, 30));
    fill(random(255), random(255), random(255));
    randomColor = (random(255));
  }
}
