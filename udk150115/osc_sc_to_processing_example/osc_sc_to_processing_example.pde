//install library oscP5:
//  menu > sketch > import library > add library
//  search for oscP5 and click install

import oscP5.*;
OscP5 oscP5;
float data= -1;  //default value
void setup() {
  size(800, 600);
  frameRate(60);
  oscP5= new OscP5(this, "127.0.0.1", 57120, 9876, "oscEvent"); //9876 is incoming port
}
void draw() {
  background(int(data/5000.0*255));  //scale freq to 0-255
  textSize(64);
  fill(255);  //white text colour
  text("my data: "+data, 100, 100);
}
void oscEvent(OscMessage oscIn) {
  if (oscIn.checkAddrPattern("/abc")) {  // /abc is address
    if (oscIn.checkTypetag("f")) {  //only one float value
      data= oscIn.get(0).floatValue();  //extract the float
    }
  }
}

