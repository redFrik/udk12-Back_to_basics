//drawing using manual delta (position-prev)
float lastX= 0, lastY= 0;
void setup() {
  size(640, 480);
}
void draw() {
  background(255, 255, 255);
  float x= mouseX;
  float y= mouseY;
  line(x, y, lastX-x+(width*0.5), lastY-y+(height*0.5));
  lastX= x;  //store x in lastx until next frame
  lastY= y;
}

