//connect led with resistor between pin9 and gnd
void setup() {
  Serial.begin(57600);
  pinMode(9, OUTPUT);
}
void loop() {
  if(Serial.available()) {
    int val= Serial.read();  //0-255
    analogWrite(9, val);  //0-255
  }
  delay(1);
}
