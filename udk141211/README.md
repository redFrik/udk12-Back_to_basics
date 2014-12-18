141211
======

arduino and processing

simple
--
upload this sketch to your arduino. it will read A0, scale down from 0-1023 to 0-255 and send this as a raw byte value over serial.
```cpp
void setup() {
    Serial.begin(57600);
}
void loop() {
    int val= analogRead(A0);  //0-1023 (10bit)
    Serial.write(val/4);  //scaled down to 0-255 (8bit)
    delay(20);  //try to lower or remove for quicker update rate
}
```

then run this code in processing. it will try to connect to your arduino serial port (edit [5] to match port index). 
```cpp
import processing.serial.*;
import processing.video.*;
Capture cam;
Serial port;
int val= 0;
void setup() {
    size(800, 600);
    println(Serial.list()); //post available serial ports (get index from here)
    port= new Serial(this, Serial.list()[5], 57600); //edit [5] to match your port index
    String[] cameras= Capture.list();
    cam= new Capture(this, cameras[0]);
    cam.start();
}
void draw() {
    while (port.available()>0) {
        val= port.read();
        //println(val);  //debug
    }
    if (cam.available()==true) {
        cam.read();  //get new frame from camera
    }
    tint(val);  //fade the camera image
    image(cam, 0, 0);  //draw the camera image
}
```

if everything is working you should be able to fade the image from the webcamera with the voltage present at pin A0. connect a bare wire to A0 for noise input (antenna) - the camera image should flicker and fade in/out in a semi-random fashion. try to connect the wire from A0 to 5v and to GND.
then try to connect potentiometer, light sensor or some other type of sensor.

if the webcamera does not work, try running the 'GettingStartedCapture' example found under file/examples/libraries/video/capture/ to validate that you can use the camera at all.

hall effect sensors
--
detect magnetic fields. useful when you want/need a no contact, no cable sensor. e.g. spinning wheels or other rotating things (just attach a magnet to the wheel and put the hall sensor close to where the magnet passes by).

a simple digital (0/1) magnet switch sensor is the TLE4095L. it needs 3.8v to 24v, is easy to connect and relatively cheap.
see this pdf [datasheet](http://pdf.datasheetcatalog.com/datasheet/infineon/1-tle4905l.pdf) for pinouts etc.

upload this code to the arduino and connect the sensor as in the picture below.
```cpp
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

below a similar example but with a fading led...
```cpp
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
read more about it [here](http://playground.arduino.cc/Main/InterfacingWithHardware#Magnetic_Hall). and also check out reed switches while you're there - they are even simpler to work with.

more advanced example
--
now connect two hall sensors. upload the `hallArduino` code to the arduino and try out the `hallProcessingSqr` and `hallProcessingCam` in processing.

![hall2](hall2.jpg?raw=true "hall2")
