boolean lockedGlobal = false;

class Slider {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  float loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked = false;
  float ratio;
  String name = "";
  PVector range = new PVector(0,1);
  color sColor = #00FF00;
  color bColor = #55AA55;
  color hColor = #00EE00;
  boolean vert = false;

  Slider (float xp, float yp, int sw, int sh, int l, boolean vertical) {
   init(xp, yp, sw, sh, l, vertical);
  }
  
   void setColor(color[] c) {
    sColor = c[0];
    bColor = c[1];
    hColor = c[2];
  }
  
  void setSliderPos(float perc) {  //in percent
    float range = swidth/2 - sheight/2;
    spos = xpos + 2 * perc * range;
    newspos = spos;
  }
  
  void init(float xp, float yp, int sw, int sh, int l, boolean vertical){
    vert = vertical;
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    
    
    if(vert == true){
      xpos = xp-swidth/2;
      ypos = yp;
      spos = ypos + sw;
      sposMin = ypos;
      sposMax = ypos + sheight - swidth;
    } else{
      xpos = xp;
      ypos = yp-sheight/2;
      spos = xpos;
      sposMin = xpos;
      sposMax = xpos + swidth - sheight;
    }    
    newspos = spos;
    loose = l;
  }
  
  Slider(String name, float xp, float yp, int sw, int sh, int l, boolean vertical){
    this.name = name;
    init(xp, yp, sw, sh, l, vertical);
  }

  void defRange(float min, float max){
    range = new PVector(min,max); 
  }

  void update(int textWidth) {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over && lockedGlobal == false) {
      locked = true;
      lockedGlobal = true;
    }
    if (!mousePressed) {
      locked = false;
      lockedGlobal = false;
    }
    if (locked) {
      //println(newspos); //<>//
      if(vert == true)
        newspos = constrain(mouseY, sposMin, sposMax );
      else
        newspos = constrain(mouseX-sheight/2 - textWidth, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) { //<>//
      float nLoose = min(loose,abs(newspos - spos));
      spos = spos + (newspos-spos)/nLoose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(bColor);
    rect(xpos, ypos, swidth, sheight);   
    if (over || locked) {
      fill(sColor);
    } else {
      fill(color(hColor));
    }
    if(vert == true)
      rect(xpos, spos, swidth, swidth);
    else
      rect(spos, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
  
  float getPosCalc(){
    int round;
    if(vert == true)
      round = round(100 * ((((spos - ypos) - sheight) * ratio) / swidth));
    else
      round = round(100 * (((spos ) * ratio) / swidth)+ sheight);
    return (0.01 * round) ; 
  }
  
  float getRangedOutput(){
    return map(getPosCalc(),0,1,range.x,range.y); 
  }
  
}
