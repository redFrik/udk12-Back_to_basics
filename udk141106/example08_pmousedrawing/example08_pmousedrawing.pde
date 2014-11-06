//drawing using delta (pmouse = previous mouse position)
void setup() {
  size(640, 480);
}
void draw() {
  background(255, 255, 255);
  float x= mouseX;
  float y= mouseY;
  line(x, y, pmouseX, pmouseY);
}

