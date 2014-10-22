int cnt= 0;
void setup() {
  size(640, 480, P2D);
  smooth(8);
  strokeWeight(0.1);
  background(255);
}
void draw() {
  float off= 1;
  line(width*0.5, height*0.5, (sin(cnt*0.01)*0.5+0.5)*width, (sin(cnt*0.01+off)*0.5+0.5)*height);
  cnt= cnt+1;
}
