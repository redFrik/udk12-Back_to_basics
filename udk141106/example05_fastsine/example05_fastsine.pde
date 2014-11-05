//only faster (higher frequency) and ellipse instead of rect
int cnt= 0;
void setup() {
  size(640, 480);
  noStroke();  //only fill ellipse
  background(0);  //set background once
}
void draw() {
  fill(255, 255, 255);  //white fill color
  ellipse(cnt%width, (sin(cnt*0.1)*0.5+0.5)*height, 5, 5);
  cnt= cnt+1;
}

