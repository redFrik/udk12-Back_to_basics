void setup() {
  size(displayWidth, displayHeight); //720p
}
void draw() {
  stroke(255, 0, 0); //red
  //println(width); //debug
  line(0, 0, random(width), random(height));
}
