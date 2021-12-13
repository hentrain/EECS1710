class Button {
  
  float posX, posY, sizeX, sizeY;
  color offColor, hoverColor, clickColor, nowColor;
  PFont font;
  String label, buttonType;  //types are ellipse, rect, toggle
  int fontSize;
  boolean hovered=false;
  boolean clicked=false;
  boolean toggleSwitch=false;
  float degLocal;
  boolean repeater=false;
  boolean debug=false;
  boolean atleast = false;

  Button(float x, float y, float w, float h, color oc, int fs, String d, String bt) {
    posX = x;
    posY = y;
    sizeX = w;
    sizeY = h;
    offColor = oc;
    colorsInit();
    nowColor = offColor;
    fontSize=fs;
    font = createFont("Arial", fontSize);
    label = d;
    buttonType = bt;
  }
  
  void colorsInit(){
    hoverColor = blendColor(offColor, color(40), ADD);
    clickColor = blendColor(offColor, color(120), ADD);
  }

  void update() {
    checkButton();
    drawButton();
  }

  void checkButton() {
    if(!mousePressed){
        if(max > 0){
          int t2 = millis();
            if(t2 > markTime2 + timeInterval){
              max = max - 45;
              markTime2 = t2;
             }
        }
        if(!hitDetect(mouseX, mouseY, 0, 0, posX, posY, sizeX, sizeY)){
          if(atleast == true && max <= 0){
            int t1 = millis();
            if(t1 > markTime1 + timeInterval*4){
              clap.play();
              atleast = false;
              markTime1 = t1;
            }
          }
        }
    }
        
    if (hitDetect(mouseX, mouseY, 0, 0, posX, posY, sizeX, sizeY)) {
      if (!mousePressed) {
        repeater = false;
        hovered = true;
        clicked = false;
      } else if (mousePressed&&!repeater) {
        repeater = true;
        hovered = true;
        clicked = true;
        toggleSwitch = !toggleSwitch;
        atleast = true;
        //depends on the pressed area to play different sound
        if(mouseY >= 400 && mouseY <= 800){
          if(mouseX >= 100 && mouseX < 300){
            pianoA3.play();
            max = (int)random(50,250);
        }else if(mouseX >= 300 && mouseX < 500){
            pianoB3.play();
            max = (int)random(75,275);
        }else if(mouseX >= 500 && mouseX < 700){
            pianoC3.play();
            max = (int)random(100,300);
        }else if(mouseX >= 700 && mouseX < 900){
            pianoD3.play();
            max = (int)random(125,325);
        }else if(mouseX >= 900 && mouseX < 1100){
            pianoE3.play();
            max = (int)random(150,350);
        }else if(mouseX >= 1100 && mouseX < 1300){
            pianoF3.play();
            max = (int)random(175,375);
        }else if(mouseX >= 1300 && mouseX < 1500){
            pianoG3.play();
            max = (int)random(200,400);
        }else if(mouseX >= 1500 && mouseX < 1700){
            pianoA4.play();
            max = (int)random(250,450);
        }
      }
      }
    } else {
      hovered=false;
      clicked=false;
    }
    if(debug){
    println("hovered: " + hovered + "   clicked: " + clicked + "   toggle: " + toggleSwitch);
    }
  }

  void drawButton() {
    ellipseMode(CENTER);
    rectMode(CENTER);
    if (hovered && !clicked) {
      nowColor = hoverColor;
      hoverColor = blendColor(offColor, color(40), ADD);
    } else if (hovered && clicked) {
      offColor = color(random((int)mouseX/8, 200), random(0,(int)mouseX/7), random((int)mouseY/5,(int)mouseX/7));
      nowColor = clickColor;
    } else if (!hovered && !clicked) {
      nowColor = offColor;
    }
    fill(0, 10);
    if (buttonType == "ellipse") {
    ellipse(posX + 2, posY + 2, sizeX, sizeY);
    } else {
      rect(posX + 2, posY + 2, sizeX, sizeY);
    }
    fill(nowColor);
    if (buttonType == "ellipse") {
      ellipse(posX, posY, sizeX, sizeY);
    } else {
      rect(posX, posY, sizeX, sizeY);
    }
    if (buttonType == "toggle") {
      if (toggleSwitch) {
        pushMatrix();
        translate(0 - (sizeX / 2), 0 - (sizeY / 2));
        stroke(0);
        strokeWeight(2);
        popMatrix();
      }
    }
    fill(0);
    textFont(font, fontSize);
    textAlign(CENTER, CENTER);
    text(label, posX, posY - (fontSize / 4));
  }

  boolean hitDetect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
    w1 /= 2;
    h1 /= 2;
    w2 /= 2;
    h2 /= 2; 
    if (x1 + w1 >= x2 - w2 && x1 - w1 <= x2 + w2 && y1 + h1 >= y2 - h2 && y1 - h1 <= y2 + h2) {
      return true;
    } 
    else {
      return false;
    }
  }
  
}
