//added changes in colour and size, stroke instead of fill
int cnt= 0;
void setup() {
  size(640, 480);
  noFill();  //only stroke ellipse
  smooth(8);
  background(0);  //set background once
}
void draw() {
  float alpha= (sin(cnt*0.08)*0.5+0.5)*255;
  float radius= (sin(cnt*0.07)*0.5+0.5)*100;
  float y= (sin(cnt*0.06)*0.5+0.5)*height;
  stroke(255, 255, 255, alpha);
  ellipse(cnt%width, y, radius*2, radius*2);
  cnt= cnt+1;
}

