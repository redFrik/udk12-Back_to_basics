int cnt= 0;
float width2, height2;
void setup() {
  size(640, 480);
  width2= width*0.5;
  height2= height*0.5;
}
void draw() {
  background(255, 255, 255);  //try with and without clearing background
  //fill(127, 127, 127, 30); rect(0, 0, width, height); //try fading background
  
  fill(255, 255, 255);
  stroke(0, 0, 0);
  for(int i= 0; i<10; i++) {
    rect(
      sin( (cnt*0.01)+(i*0.1) )*width2+width2,
      sin( (cnt*0.03)+(i*0.1) + PI )*height2+height2,
      10+i,
      10+i
    );
  }
  cnt= cnt+1;
}
