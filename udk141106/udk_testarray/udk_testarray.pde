//more advanced example saving all the speed data in an array 
float[] mousedata;
int cnt= 0;
void setup() {
  size(640, 480);
  mousedata= new float[width];
}
void draw() {
  float difference= mouseX-pmouseX;  //current minus previous position
  float speed= abs(difference);  //absolute value
  background(speed);
  stroke(255, 0, 0);
  for(int i= 0; i<width; i++) {
    line(i, height*0.5, i, height*0.5-mousedata[i]);
    line(i, height*0.5, i, height*0.5+mousedata[i]);
  }
  mousedata[cnt%width]= speed;
  cnt= cnt+2;
}

