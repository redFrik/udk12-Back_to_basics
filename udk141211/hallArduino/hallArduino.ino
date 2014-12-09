//hallArduino - TLE 4905 with processing
//use together with hallProcessingCam.pde or hallProcessingSqr.pde
int last3= 0;
int last4= 0;
void setup() {
  pinMode(3, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);
  Serial.begin(57600);
}
void loop() {
  int val3= digitalRead(3);
  if(val3!=last3) {  //filter out repetitions
    Serial.write(103);  //selector
    Serial.write(1-val3);  //invert
    last3= val3;  //only send on change
  }
  int val4= digitalRead(4);
  if(val4!=last4) {  //filter out repetitions
    Serial.write(104);  //selector
    Serial.write(1-val4);  //invert
    last4= val4;  //only send on change
  }
  delay(1);  //wait 1 millisecond
}

