int cnt= 0;
void setup() {
  size(640, 480, P2D);
  smooth(8); //try 2, 4, 8 for different aliasing
}
void draw() {
  //background(0, 255, 0);
  float offset= PI*0.45;
  strokeWeight(sin(cnt*0.02)*0.5+0.5); //line thickness
  line(
    width*0.5,
    height*0.5,
    sin(cnt*0.01)*(width*0.5)+(width*0.5),
    sin(cnt*0.01+offset)*(height*0.5)+(height*0.5)
  );
  //line(width*0.5, height*0.5, map(sin(cnt*0.01), -1, 1, 0, width), 100);
  cnt= cnt-1;
}
