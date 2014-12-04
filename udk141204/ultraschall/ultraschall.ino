//use together with ultraschall.scd

//download and install library from https://code.google.com/p/srf04-library/

#include <DistanceSRF04.h>

DistanceSRF04 Dist;
int distance;

void setup() {
  Serial.begin(115200);  //make sure same baudrate in sc
  Dist.begin(2, 3);  //connect pin 2 to echo and 3 to trig
}

void loop() {
  distance= Dist.getDistanceCentimeter();
  Serial.write(min(255, distance));  //use write to send raw byte
  delay(20);  //updaterate
}

