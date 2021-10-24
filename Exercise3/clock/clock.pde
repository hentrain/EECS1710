float rotSeconds = 0;
float rotMinutes = 0;
float rotHours = 0;
int lastSecond = 0;
int lastMinute = 0;
int lastHour = 0;

float faceSize = 500;
float lengthSecondHand = 200;
float lengthMinuteHand = 180;
float lengthHourHand = 100;

color outlineCol = color(0);
color secondCol = color(255, 0, 0);
color faceCol = color(100, 200, 255);

void setup() {
  size(1400, 800); 
  strokeWeight(2);
}

void draw() {
  int s = second();
  int m = minute();
  int h = hour();
  
  if (s != lastSecond) {
    rotSeconds = ((float) s / 60) * TWO_PI;
    lastSecond = s;
  }
  
  if (m != lastMinute) {
    rotMinutes = ((float) m / 60) * TWO_PI; 
    lastMinute = m;
  }
  
  if (h != lastHour) {
    rotHours = ((float) h / 12) * TWO_PI;  
    lastHour = h;
  }
  
  fill(faceCol);
  stroke(outlineCol);
  ellipse(width/2, height/2, faceSize, faceSize);
  
  
  //hour indicator
  for(int i=0; i<12; i++) {
    stroke(0, 127, 255, 150);
    float rot = ((float) i/12) * TWO_PI;
    pushMatrix();
    translate(width/2, height/2);
    rotate(rot);
    line(0, faceSize/4, 0, faceSize/2);
    strokeWeight(3);
    popMatrix();
  }
  //minutes indicator
  for(int i=0; i<60; i++) {
    stroke(0, 127, 255, 100);
    float rot = ((float) i/60) * TWO_PI;
    pushMatrix();
    translate(width/2, height/2);
    rotate(rot);
    line(0, faceSize/3, 0, faceSize/2);
    strokeWeight(1);
    popMatrix();
  }
  
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(rotSeconds);
  fill(secondCol);
  stroke(secondCol);
  line(0, 0, 0, -lengthSecondHand);
  ellipse(0, -lengthSecondHand, 10,10);
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(rotMinutes);
  fill(0);
  stroke(outlineCol);
  line(0, 0, 0, -lengthMinuteHand);
  ellipse(0, -lengthMinuteHand, 10,10);
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(rotHours);
  line(0, 0, 0, -lengthHourHand);
  ellipse(0, -lengthHourHand, 10,10);
  popMatrix();
  
  fill(faceCol);
  ellipse(width/2, height/2, 10, 10);
}
