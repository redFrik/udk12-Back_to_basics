void setup() {
  size(640, 380);
  println(width);  //print an integer
  println(float(width)); //print as a float
  //640  //integer
  //640.0 //float
}
void draw() {
  background(mouseX/float(width)*255.0, mouseY/float(height)*255.0, 100);
  stroke(mouseY%256, mouseX%256, mouseY%256);
  line(0, 0, mouseX, mouseY);
}

