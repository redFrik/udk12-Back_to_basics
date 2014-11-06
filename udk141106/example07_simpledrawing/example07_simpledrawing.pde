//super simple drawing with mouse
void setup() {
  size(640, 480);
}
void draw() {
  float x= mouseX;
  float y= mouseY;
  line(0, 0, x, y);
}

