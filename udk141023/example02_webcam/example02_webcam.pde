import processing.video.*;
Capture cam;
int cnt= 0;
void setup() {
  size(640, 480);
  cam= new Capture(this, width, height);
  cam.start();
}
void draw() {
  if(cam.available()) {
    cam.read();
  }
  float x= sin(cnt*0.01)*(width*0.5)+(width*0.5);
  image(cam, x, 0);
  cnt= cnt+1;
}

