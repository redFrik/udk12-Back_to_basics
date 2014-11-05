int cnt= 0;
void setup() {
  size(640, 480);
  noStroke();  //only fill rect
  background(0);  //set background once
}
void draw() {
  fill(255, 255, 255);  //white fill color
  rect(cnt%width, (sin(cnt*0.01)*0.5+0.5)*height, 1, 1);
  cnt= cnt+1;
}

