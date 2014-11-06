//drawing using a simple filter
float dragX= 0, dragY= 0;
float factor= 0.1;  //smoothness
void setup() {
  size(640, 480);
}
void draw() {
  background(255, 255, 255);
  float x= mouseX;
  float y= mouseY;
  dragX= dragX+((x-dragX)*factor);
  dragY= dragY+((y-dragY)*factor);
  line(0, 0, dragX, dragY);
}

