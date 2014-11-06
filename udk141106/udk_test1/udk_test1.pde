int cnt= 0; //global
void setup() { //one time (at startup)
  int mywidth= displayWidth; //local
  size(mywidth, displayHeight);
  println(mywidth);
}
void draw() { //multiple times (for each new frame)
  line(0, 0, width, cnt);
  cnt= cnt+10;
}

