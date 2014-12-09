141211
======

arduino and processing

hall effect sensors
--
detect magnetic fields. useful when you want/need a no contact, no cable sensor. e.g. spinning wheels or other rotating things (just attach a magnet to the wheel and put the hall sensor close to where the magnet passes by).

a simple digital (0/1) magnet sensor is the TLE4095L. it needs 3.8 to 24v, is easy to connect to a 5v arduino and is cheap.
see pdf [datasheet](http://pdf.datasheetcatalog.com/datasheet/infineon/1-tle4905l.pdf) for pinouts etc.

```
//TLE 4905 hall switch sensor
//connect sensor to 5v, gnd and pin3
//connect led+resistor to 11 and gnd
void setup() {
    pinMode(3, INPUT_PULLUP);
    pinMode(11, OUTPUT);
}
void loop() {
    digitalWrite(11, 1-digitalRead(3));
    delay(2);
}
```

![hall1](hall1.jpg?raw=true "hall1")

similar example but with a fading led
```
//TLE 4905 hall switch sensor
//fading in and out at different rates
int cnt= 0;
void setup() {
    pinMode(3, INPUT_PULLUP);
    pinMode(11, OUTPUT);
}
void loop() {
    if(digitalRead(3)==0) {
        cnt= cnt+3;  //fade in faster
    } else {
        cnt= cnt-1;  //fade out slower
    }
    cnt= constrain(cnt, 0, 255);
    analogWrite(11, cnt);
    delay(4);  //update rate
}
```

there are also hall sensors that give an analogue reading - not only on and off.

processing and arduino
--
now connect two hall sensors. upload the hallArduino code to the arduino and try out the hallProcessingSqr and hallProcessingCam in processing.

![hall2](hall2.jpg?raw=true "hall2")
