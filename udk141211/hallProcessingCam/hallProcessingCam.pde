//hallProcessingCam
//use together with hallArduino.pde
//this example only uses one of the two sensors
import processing.serial.*;
import processing.video.*;
Serial port;
Capture cam;
int cnt= 0;
int val= 0;
void setup() {
  size(800, 600);
  String[] cameras= Capture.list();
  cam= new Capture(this, cameras[0]);
  cam.start();
  println(Serial.list());
  port= new Serial(this, Serial.list()[0], 57600);
}
void draw() {
  if (cam.available()==true) {
    cam.read();  //get new frame from camera
  }
  tint(cnt);  //fade the camera image
  image(cam, 0, 0);  //draw the camera image

  if(val==0) {  //check if last sensor reading was 0 
    cnt= cnt-1;  //fade out
  } else {
    cnt= cnt+2;  //fade up a bit quicker
  }
  cnt= constrain(cnt, 0, 255);

  while (port.available ()>1) {
    int selector= port.read();
    if (selector==103) {
      val= port.read();
      //println("103 is "+val);  //debug
    }
  }
}

