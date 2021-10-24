int secondSize = 60;
int minuteSize = 60;
int hourSize = 24;
ArrayList<PVector> seconds = new ArrayList<PVector>(secondSize);
ArrayList<PVector> minutes = new ArrayList<PVector>(minuteSize);
ArrayList<PVector> hours = new ArrayList<PVector>(hourSize);

int markTime = 0;
int timeout = 1000;

void setup() {
  size(1400, 800, P2D);
  textAlign(CENTER);
  textSize(64);
  frameRate(360);
  
  //setup the clock presentation for the default time
  for (int i=0; i<60-second(); i++) {
    seconds.add(new PVector(random(width), random(height)));
  }
  for (int i=0; i<minute(); i++) {
    minutes.add(new PVector(random(width), random(height)));
  }
  for (int i=0; i<hour(); i++) {
    hours.add(new PVector(random(width), random(height)));
  }
}
  

void draw() {
  background(100, 100, 255);
  
  if (millis() > markTime + timeout) {
 
    if (seconds.size() > 0) {
      seconds.remove(seconds.size()-1);
    }
    
    markTime = millis();
  }
  
  //generate corresponding ellipse according to the time unit size.
  for (int i=0; i<seconds.size(); i++) {
    ellipse(seconds.get(i).x, seconds.get(i).y, 10, 10);
  }
  
  for (int i=0; i<minutes.size(); i++) {
    fill(220, 120, 0);
    ellipse(minutes.get(i).x, minutes.get(i).y, 30, 30);
  }
  
  for (int i=0; i<hours.size(); i++){
    fill(255, 80, 0);
    ellipse(hours.get(i).x, hours.get(i).y, 60, 60);
  }
  
  //generate a minute ellipse every 60 seconds ellipse elimated
  if(seconds.size() == 0){
    for (int i=0; i<secondSize; i++) {
      seconds.add(new PVector(random(width), random(height)));
    }
    minutes.add(new PVector(random(width), random(height)));
  }
  
  //generate a hour ellipse every 60 minutes ellipse generated
  if(minutes.size() == minuteSize){
    for(int i=0; i<minuteSize; i++){
      minutes.remove(minutes.size()-1);
    }
    hours.add(new PVector(random(width), random(height)));
  }
  
  //Check if 24 hours have passed in a day
  if(hours.size() >= hourSize){
    for(int i=0; i<24; i++){
      hours.remove(hours.size()-1);
    }
  }
  
  surface.setTitle("" + frameRate);
  fill(64);
  text(60-seconds.size(), width/2, height/2+100);
  text(minutes.size(),width/2, height/2);
  text(hours.size(),width/2, height/2-100);
}

void keyPressed(){
  timeout = 1;
}
