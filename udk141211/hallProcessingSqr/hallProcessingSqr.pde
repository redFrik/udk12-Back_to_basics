//hallProcessingSqr
//use together with hallArduino.pde
//one sensor draws on the left, the other on the right hand side
import processing.serial.*;
Serial port;
void setup() {
  size(800, 600);
  println(Serial.list());
  port= new Serial(this, Serial.list()[0], 57600);
  background(0);
}
void draw() {
  while (port.available()>1) {
    int selector= port.read();
    if(selector==103) {
      int val= port.read();
      //println("103 is "+val);  //debug
      fill(val*255, 127);
      rect(0, random(height), width*0.6, random(height*0.5));
    } else if(selector==104) {
      int val= port.read();
      //println("104 is "+val);  //debug
      fill(val*255, 127);
      rect(width*0.4, random(height), width*0.6, random(height*0.5));
    }
  }
}

