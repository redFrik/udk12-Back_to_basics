//for testing the ultrasound HC-SR04 sensor
//use the Serial Monitor in Arduino IDE to see data posted

//download and install library from https://code.google.com/p/srf04-library/
//(i.e. put the DistanceSRF04 folder in ~/Documents/Arduino/libraries/)
//connect pin 2 to echo and pin 3 to trig
//connect pin 1 to 5v and pin 4 to gnd
//select board (here Arduino Uno) and port (here /dev/tty.usbserial-A101NB76)
//upload and then open the Serial monitor, set baudrate to 57600

#include <DistanceSRF04.h>

DistanceSRF04 Dist;
int distance;

void setup() {
  Serial.begin(57600);  //make sure same baudrate in serial monitor
  Dist.begin(2, 3);  //connect pin 2 to echo and 3 to trig
}

void loop() {
  distance= Dist.getDistanceCentimeter();
  Serial.println(distance);  //use println to send to serial monitor
  delay(20);  //updaterate
}

