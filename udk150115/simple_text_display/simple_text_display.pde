//simple example just to show how to draw text
void setup() {
  size(800, 600);
  frameRate(30);  //try different like 25, 40, 60
}
void draw() {
  background(0);
  textSize(64);
  fill(255);  //white text colour
  text("framerate:"+frameRate, 100, 100);
  text("framecount:"+frameCount, 100, 170);
}

