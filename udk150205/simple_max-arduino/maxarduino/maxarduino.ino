void setup() {
  Serial.begin(57600);
}
void loop() {
  Serial.write(analogRead(A0)/4);  //scale from 10bits (0-1023) down to 8bits (0-255)
  delay(20);  //updaterate
}
