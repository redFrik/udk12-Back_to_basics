//many things to study in this example:
// • sine function
// • scaling
// • inversion
// • proportional size (percentages instead of pixels)

float cnt= 0;
void setup() {
  size(displayWidth, displayHeight);
  noStroke();  //no border for the rect
}

/*
  -1.0 to 1.0 //staring range from sin
  /2
  -0.5 to 0.5 //half range
  +0.5
  0.0 to 1.0 //normalized range
  *255.0
  0-255 //final range
*/

void draw() {
  float col= (sin(cnt)*0.5+0.5)*255.0;  //sine and scale from -1.0 to 1.0 to 0-255 
  background(col);
  
  fill(255-col);  //invert the col value (0-255 becomes 255-0)
  rect(width*0.15, height*0.15, width*0.7, height*0.7); //percentages
  
  cnt= cnt+(mouseX*0.001);
}

