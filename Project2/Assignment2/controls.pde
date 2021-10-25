 
  void keyPressed() {
    if(point >= 0 && point <500){
      if (key == ' ') {
        cannon.fire();
        point = point - pointCost;
      }
      }
    }
    
