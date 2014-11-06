//here we use pmouse to find the speed/direction/slope
int cnt= 0;
void setup() {
  size(640, 480);
}
void draw() {
  float difference= mouseX-pmouseX;  //current minus previous position
  float speed= abs(difference);  //absolute value
  //background(speed);  //also try uncommenting this line
  stroke(speed*2, 0, 0);  //red color
  line(cnt%width, height, cnt%width, height-speed);
  cnt= cnt+1;
}

