PImage img1, img2;
ArrayList<Dot> dots;
ArrayList<PVector> targets1, targets2;
int scaler = 10; // will use only every 10th pixel from the image
int threshold = 180;
int r, g, b, t;
boolean imageToggled = false;
color col1, col2;

float scaleAmp = 20;
float scaleFreq = 10000;
float ampValue, freqValue;

void setup() {
  size(50, 50, P2D);  
  frameRate(30);
  setupSound();
  img1 = loadImage("doge.jpg");
  img2 = loadImage("doge2.jpg");
  
  surface.setSize(img1.width,img1.height);
  
  img1.loadPixels();
  img2.loadPixels();
  
  targets1 = new ArrayList<PVector>();
  targets2 = new ArrayList<PVector>();
  
  col1 = color(155, 127, 0, 80);
  col2 = color(0, 127, 155, 80);
  
  for (int x = 0; x < img2.width; x += scaler) {
    for (int y = 0; y < img2.height; y += scaler) {
      // this translates x and y coordinates into a location in the pixels array
      int loc = x + y * img2.width;

      if (brightness(img2.pixels[loc]) > threshold) {
        targets2.add(new PVector(x, y));
      }
    }
  }

  dots = new ArrayList<Dot>();

  for (int x = 0; x < img1.width; x += scaler) {
    for (int y = 0; y < img1.height; y += scaler) {
      int loc = x + y * img1.width;
      
      if (brightness(img1.pixels[loc]) > threshold) {
        int targetIndex = int(random(0, targets2.size()));
        targets1.add(new PVector(x, y));
        Dot dot = new Dot(x, y, col1, targets2.get(targetIndex));
        dots.add(dot);
      }
    }
  }
}

void draw() { 
  background(0);
  updateSound();
  ampValue = amp * scaleAmp;
  freqValue = freq / scaleFreq;
  println("amp: " + amp + " freq: " + freq + " ampValue: " + ampValue + " scaleFreq: " + freqValue);
  
  blendMode(REPLACE);
  
  boolean flipTargets = true;

  for (Dot dot : dots) {
    dot.run();
    if (!dot.ready) flipTargets = false;
  }
  
  if (flipTargets) {
    for (Dot dot : dots) {
      if (!imageToggled) {
        int targetIndex = int(random(0, targets1.size()));
        dot.target = targets1.get(targetIndex);
        col1 = color(random(155,255), random(55, 255), random(55, 255),random(40,60));
        dot.col = col1;
      } else {
        int targetIndex = int(random(0, targets2.size()));
        dot.target = targets2.get(targetIndex);
        col2 = color(random(55,255), random(55, 255), random(155, 255),random(40,60));
        dot.col = col2;
      }
    }
    imageToggled = !imageToggled;
  }
    
  surface.setTitle("" + ampValue);
}
