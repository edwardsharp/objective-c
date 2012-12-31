/**
 * A simple binary clock.
 * ...with a weird set of features
 * 
 * author: edward sharp
 * year: 2012
 * license: creative commons
 */

int FRAMERATE = 10;
String info="";
boolean showTime=false; 
boolean clickAndHold=false;
int clickAndHoldTimer=0;
float blockHue = 12;
float s = 200;
float b = 200;
PFont font;
int startingTime;
int seconds;

Block binClock;


void setup() {
  
  //iPhone
  size(480,320);
  
  //full
  //size(displayWidth, displayHeight);
  
  //hue, saturation, bal with 200 limit
  colorMode(HSB, 200);
  
  background(0);
  
  //generally only need 1fps for a clock 
  // however a faster framerate makes the mouseclick more responsive
  frameRate(FRAMERATE);
  // cons1ructor, no parameters
  binClock = new Block();

  //#TODO: use createFont
  //font = loadFont("SansSerif-100.vlw");
  //textFont(font, 100);
  
  //String[] fontList = PFont.list();
  //println(fontList);
  font = createFont("SansSerif", 100);
  textFont(font);

}

void draw() {
  binClock.display();
  
  if( mousePressed ){ 

    clickAndHoldTimer +=1;
    if( clickAndHoldTimer > 3 ){
      clickAndHold = true;
    }
    //println("CLICKAndHold: "+clickAndHold);
  }
  
}

void keyPressed(){
  if (key=='s') {
    showTime=!showTime;
  }
  if (key == CODED && keyCode == KeyEvent.KEYCODE_MENU) {
    showTime=!showTime;
  }
    
}

void mousePressed(){
    /*if( mouseButton==RIGHT ){
      showTime=!showTime;
    } */
 
}

void mouseReleased(){
  
  if(!clickAndHold) {
    //println("GONNA CHANGE THE TIME");
    showTime=!showTime;
  }
  clickAndHold = false;
  clickAndHoldTimer = 0;
  //println(" clickAndHold:"+clickAndHold);
}

void mouseDragged(){
  if(clickAndHold) {
    blockHue = map(mouseX, 0, width, 0.0, 200.0);
    s =  map(mouseY, 0, width, 50.0, 200.0);
    b =  map(mouseY, 0, width, 50.0, 200.0);
  }
  
}
class Block {
  //class varz
  int strk = 0;
  int c_bg = 0;
  int sqr = 2;
  int alphaDelta = 1; 
  int alphaValue = 255;   
  int c_on = #ff6600;
  int c_off = 0;
  int timeColor1 = #ededed;
  int timeColor2 = #ff6600;
  // #TODO: constructor?
  Block() {
  }
  
  // with parameters
  /*Block(float xpos, float ypos, float r) {
    x = xpos;
    y = ypos;
    radius = r;
  }*/
  void display() {
    
    // mod 10 the current time into 6 columnz
    int s = second();
    int s0 = s % 10;
    int s1 = (s - s0)/10;
    int m = minute();
    int m0 = m % 10;
    int m1 = (m - m0)/10;
    int h = hour();
    int h0 = h % 10;
    int h1 = (h - h0)/10;

    //step the alpha an entire step every second 
    // multiply by FRAMERATE == steppin, yo.
    alphaValue += alphaDelta + ( alphaValue / FRAMERATE );
    alphaDelta++;
    if ( alphaDelta >= FRAMERATE-1 ) { alphaDelta = 0; }
    if (alphaValue > 255) { alphaValue = 0; } 
    
    //if (alphaValue <= 0) { alphaValue = 0;} 
    //println("alphaValue:"+alphaValue+" alphaDelta:"+alphaDelta);
  
    int rectSize = 80; 
    int iOffset = 80;
    int yRect = 240;
    int xRect0 = 0;
    //#TODO: increment iterator? could this be more fluid for various resolutions?
    //int xRectOffset = 10;
    int xRect1 = 80;
    int xRect2 = 160;
    int xRect3 = 240;
    int xRect4 = 320;
    int xRect5 = 400;
    
    int yBlock = 80;

    //for each HH, MM, SS turn on the results from last run, recalculate next second.
    for (int i=3; i>=0; i--) {
        on (xRect0, yBlock, i);
        if (h1 >= pow(sqr,i))
            h1 -= pow(sqr,i);
        else
            fill(c_off);
            
        rect(xRect0,yRect-(i*iOffset),rectSize, rectSize);
 
        on (xRect1, yBlock, i);
        if (h0 >= pow(sqr,i))
            h0 -= pow(sqr,i);
        else
            fill(c_off);
            
        rect(xRect1,yRect-(i*iOffset),rectSize, rectSize);
  
        on (xRect2, yBlock, i);
        if (m1 >= pow(sqr,i))
            m1 -= pow(sqr,i);
        else
            fill(c_off);
            
        rect(xRect2,yRect-(i*iOffset),rectSize, rectSize);
 
        on (xRect3, yBlock, i);
        if (m0 >= pow(sqr,i))
            m0 -= pow(sqr,i);
        else
            fill(c_off);
        rect(xRect3,yRect-(i*iOffset),rectSize, rectSize);
 
        on (xRect4, yBlock, i);
        if (s1 >= pow(sqr,i))
            s1 -= pow(sqr,i);
        else
            fill(c_off);
        rect(xRect4,yRect-(i*iOffset),rectSize, rectSize);
 
        on (xRect5, yBlock, i);
        if (s0 >= pow(sqr,i))
            s0 -= pow(sqr,i);
        else
            fill(c_off);
        rect(xRect5,yRect-(i*iOffset),rectSize, rectSize);
        
        
    }
    
    
    if (showTime) 
    {
      displayTime(h,m,s);
      
    }
  }
  
  void displayTime(int h, int m, int s) {
    if(blockHue>10 && blockHue<20){
      fill(timeColor1);
    }else {
      fill(timeColor2);
    }
    //#TODO: text outline? text is bitmap based, so stroke attributes are ignored.
    // a work-around is to just draw the text again slightly smaller.

    text(nf(h, 2), 22, 315);
    text(":", 144, 315);
    text(nf(m, 2), 173, 315);
    text(":", 304, 315);
    text(nf(s, 2), 341, 315);
  }
  void on (int xstart, int ystart, int abit) {
    //#TODO: fix 4th param...
    
    //strokeWeight(strk);
    noFill();
    //stroke(c_on);
    
    rect(xstart,ystart-(abit*50),24,24);
    noStroke();
    //fill(c_on, alphaValue);
    fill(blockHue, s, b, alphaValue);
  }
  
  void off (int xstart, int ystart, int abit){
    
    //noFill();
    rect(xstart,ystart-(abit*50),24,24);
    noStroke();
    fill(c_off, alphaValue); 
  }

}