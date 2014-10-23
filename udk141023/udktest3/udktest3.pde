int cnt= 0;

void setup() {
  size(640, 480);
}
void draw() {
  background(cnt%256, cnt%100, cnt%50);
  fill(cnt%100, cnt%200, cnt%220);
  rect(cnt%200, cnt%190, cnt%width, cnt%height);
  cnt= cnt+10;
  //println(cnt % 256); //0 and 255
}
