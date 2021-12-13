import processing.sound.*;
SoundFile pianoA3, pianoB3, pianoC3, pianoD3, pianoE3, pianoF3, pianoG3, pianoA4, clap;

Button buttonA3, buttonB3, buttonC3, buttonD3, buttonE3, buttonF3, buttonG3, buttonA4;

FFT fft;
AudioIn in;
int bands = 512;
float[] spectrum = new float[bands];

PFont font;
int fontSize = 24;
PImage img;
int max;
float amp = 1;
int timeInterval = 1000;
int markTime1 = 0;
int markTime2 = 0;


void setup(){
   size(1800, 800);
   background(127);
   frameRate(60);
   rectMode(CENTER);
   
   buttonA3 = new Button(200,600,200,400,color(0,100,150),fontSize,"C3","toggle");
   buttonB3 = new Button(400,600,200,400,color(20,100,130),fontSize,"D3","toggle");
   buttonC3 = new Button(600,600,200,400,color(40,100,110),fontSize,"E3","toggle"); 
   buttonD3 = new Button(800,600,200,400,color(60,100,90),fontSize,"F3","toggle");
   buttonE3 = new Button(1000,600,200,400,color(80,100,70),fontSize,"G3","toggle");
   buttonF3 = new Button(1200,600,200,400,color(100,100,50),fontSize,"A4","toggle");
   buttonG3 = new Button(1400,600,200,400,color(120,100,30),fontSize,"B4","toggle");
   buttonA4 = new Button(1600,600,200,400,color(140,100,10),fontSize,"C4","toggle");
   font = createFont("Arial",fontSize);
   
   //input each piano key sound from A3 to G3
   pianoA3 = new SoundFile(this, "pianoA3.mp3");
   pianoB3 = new SoundFile(this, "pianoB3.mp3");
   pianoC3 = new SoundFile(this, "pianoC3.mp3");
   pianoD3 = new SoundFile(this, "pianoD3.mp3");
   pianoE3 = new SoundFile(this, "pianoE3.mp3");
   pianoF3 = new SoundFile(this, "pianoF3.mp3");
   pianoG3 = new SoundFile(this, "pianoG3.mp3");
   pianoA4 = new SoundFile(this, "pianoA4.mp3");
   clap = new SoundFile(this, "clap.mp3");
   img = loadImage("ACNH.jpg");
   
   fft = new FFT(this);
   in = new AudioIn(this, 0);
   
   //start the Audio Input
   in.start();
   
   //patch the AudioIn
   fft.input(in);

}

void draw(){
  image(img, 0, 0, 1800, 800);
  fill(255);
  textAlign(CENTER);
  textFont(font,fontSize);
  
  for(int i = 0; i<32; i++){
    rect(i*75, 390, 50, random(0 ,max));
    fill(random((int)mouseY/4, 200), random(0,(int)mouseX/7), random((int)mouseY/5,(int)mouseX/7));
  }
  for(int i = 0; i<32; i++){
    rect(i*75, 10, 50, random(0, max));
    fill(255);
  }
   
  buttonA3.update();
  buttonB3.update();
  buttonC3.update();
  buttonD3.update();
  buttonE3.update();
  buttonF3.update();
  buttonG3.update();
  buttonA4.update();
    
  fft.analyze(spectrum);
  print(max); 
}
