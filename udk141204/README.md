141204
======

arduino experiments

download and install arduino ide 1.0.6 or 1.5.8b from <http://arduino.cc/en/Main/Software>

note: if you haven't already, you might need to install the FTDI driver from <http://www.ftdichip.com/Drivers/VCP.htm>. for mac osx get the latest 2.2.18 (and get the 64bit version if you have a recent laptop with a recent osx version (< ~4 years old)).

arduino
--

<http://arduino.cc>

there are many different models:
* nano
* pro mini
* mega
* uno (the most common one)
* etc.

here we use the [redboard](https://www.sparkfun.com/products/12757) from sparkfun. it's a version of the arduino uno.

the examples below were written for an uno but will work on almost all arduino models.

how to connect
--

just connect a mini usb cable between laptop and the arduino. you should see the device show up under tools/port menu.

overview
--

there are four very common commands/techniques and we will go through each one and try the typical use case.
two of them are `digitalWrite` and `digitalRead`. these use only 0 and 1 for reading and writing to/from pins.
the other two are `analogWrite` and `analogRead`. these use continuous values (0-255 and 0-1023) for reading and writing to special 'analogue' pins.

* digitalWrite (0/1)
* analogWrite(0-255)    //only works on pins with the ~ sign
* digitalRead(0/1)
* analogRead(0-1023)    //only works on pins A0-A5

digitalWrite
--
```cpp
//simple blink led
//connect led+resistor to pin 11 and gnd
//note the marking on the side of the led - that leg must go to gnd
void setup() {
    pinMode(11, OUTPUT);  //make pin 11 an output (it is already by default)
}
void loop() {
    digitalWrite(11, 1);  //set pin 11 to 5 volt
    delay(500);  //wait 0.5 seconds
    digitalWrite(11, 0);  //set pin to 0 volt (gnd)
    delay(250);
}
```

![blink](blink.jpg?raw=true "blink")

keep the same connection and upload the following example...

```cpp
//blink two leds (alternating)
void setup() {
    pinMode(11, OUTPUT);
    pinMode(13, OUTPUT);    //here also using the built-in on-board blue led
}
void loop() {
    digitalWrite(11, 1);
    delay(500);
    digitalWrite(11, 0);
    delay(250);

    digitalWrite(13, 1);    //turn on the built-in led
    delay(100);
    digitalWrite(13, 0);
    delay(141);
}
```

note how arduino is single threaded. that means it can only do one thing at a time and it is actually quite difficult to do two or more independent things (unlike in multithreaded programming languages like supercollider).
so in the example right above we blink the leds one after the other - and that's simple. but if we want to blink them both at different independent tempi, we need to write more code. the below example show one way to do it. the trick is to avoid `delay()` and keep the loop running by using counters.

```cpp
//independent blinking (advanced)
int cnt1= 0;
int cnt2= 0;
void setup() {
    pinMode(11, OUTPUT);
    pinMode(13, OUTPUT);    //here also using the built-in on-board blue led
}
void loop() {
    if(cnt1==0) {   //check if beginning of count
        digitalWrite(11, 1);    //turn led1 on
    } else if(cnt1==500) {  //check if waited 500 counts
        digitalWrite(11, 0);    //turn led1 off
    } else if(cnt1==750) {  //this decides how many counts to stay off before reset
        cnt1= -1;   //reset first counter
    }
    cnt1= cnt1+1;

    if(cnt2==0) {
        digitalWrite(13, 1);
    } else if(cnt2==100) {
        digitalWrite(13, 0);
    } else if(cnt2==141) {
        cnt2= -1;   //reset second counter
    }
    cnt2= cnt2+1;
    
    delay(1);   //delay 1 millisec for each count (although timing will not match 100% because of the rest of the code)
}
```

there is also more advanced options for doing multi-tasking on an arduino. one is to work with timers (see <http://arduino.cc/en/Tutorial/BlinkWithoutDelay>). another is to use a rtos like FreeRTOS, NilRTOS or ChibiOS (<http://blog.ksduino.org/post/44699789324/multitasking-and-real-time-systems-at-arduino>)

analogWrite
--
note it is called analogWrite but the functionallity is actually [pwm](http://arduino.cc/en/Tutorial/PWM) (pulse-width modulation).

```cpp
//simple fade led
//keep led+resistor connected to pin 11 and gnd
//note the little ~ marking next to pin 11
//that means it can do pwm ('analog' out)
//not all pins can be pwm outputs
int cnt= 0;
void setup() {
    pinMode(11, OUTPUT);  //make pin 11 an output (it is already by default)
}
void loop() {
    analogWrite(11, cnt);  //set pin 11 to something 0-255
    cnt= cnt+1;
    if(cnt==255) {
    cnt= 0;
    }
    delay(5);
}
```

note how the cnt variable is linear (0-255), but the percived brightness of the led isn't. the led does not fade evenly and spend most of the time very bright.

digitalRead
--
```cpp
//simple digital read
//connect a button or switch between pin 3 and gnd
//when you press the button the led should go off
void setup() {
    pinMode(3, INPUT_PULLUP);   //use the built-in pull up resistor for this input
    pinMode(11, OUTPUT);
}
void loop() {
    int val;
    val= digitalRead(3);  //read either 0 or 1 from pin 3
    digitalWrite(11, val);  //write result to pin 11

    delay(5);
}
```

![switch](switch.jpg?raw=true "switch")

keep the connections and try this...
```cpp
//a little bit more advanced switch
//digital read that read pin 3 and fade led if pressed
int cnt= 0;
void setup() {
    pinMode(3, INPUT_PULLUP);
    pinMode(11, OUTPUT);
}
void loop() {
    int val;
    val= digitalRead(3);
    if(val==0) {    //switch pressed then fade led
        analogWrite(11, cnt);
        cnt= cnt+1;
        if(cnt==255) {
            cnt= 0;
        }
    }
    delay(5);
}
```

analogRead
--
```cpp
//simple analog read
//connect a bare wire to A0
void setup() {
    pinMode(11, OUTPUT);
}
void loop() {
    int val= analogRead(A0);  //read A0 (0-1023)
    analogWrite(11, val/4);  //scale down to 0-255 and set led brightness
    delay(1);
}
```

now the bare wire in A0 will act as an antenna. touch it and the led should flicker. connect it to gnd and the led should go off. connect it to 5v and the led should go to full brightness.

![analog](analog.jpg?raw=true "analog")

a more 'normal' way to use the analog inputs is to connect one of the pins A0-A5 to the middle pin of a potentiometer. and then the other two potentiometer pins to 5v and gnd. see the instructions on [this](https://github.com/redFrik/udk10-Embedded_Systems/blob/master/udk131212/README.md#--analog-inputs) page.

communication
--
to send data to and from the laptop we need to use the serial port.

note that the serial port can only send 8bit values (from 0 to 255). if you need floats, strings or larger values, you will need to combine multiple 8bit bytes.

```cpp
//simple serial send from arduino to laptop
int cnt= 0;
void setup() {
    Serial.begin(57600);  //baudrate - must match in serial monitor / sc
}
void loop() {
    Serial.println(cnt);  //send to serial port (with newline)
    delay(100);  //wait 100 milliseconds
    cnt= cnt+1;
}
```

![serialPrint](serialPrint.png?raw=true "serialPrint")

make sure a led is connected to pin 11 and then upload and test the next example.

```cpp
//serial read from laptop to arduino
void setup() {
    Serial.begin(57600);  //baudrate - must match in serial monitor / sc
    pinMode(11, OUTPUT);
}
void loop() {
    if (Serial.available() > 0) {
        int val= Serial.read();
        if (val==65) {
            digitalWrite(11, 1);
            Serial.println("received 'A'. turning on led");
        } else if(val==66) {
            digitalWrite(11, 0);
            Serial.println("received 'B'. turning off led");
        }
    }
    delay(1);
}
```

you will need to open the serial monitor again and type 'A' or 'B' in the top send field. that will either turn the led on or off.

![serialRead](serialRead.png?raw=true "serialRead")

and note that `Serial.print` and `Serial.println` are mainly good for debugging with arduino's serial monitor. use `Serial.write` when you want to send raw bytes to other programs like supercollider and processing.

ultrasound
--
download the DistanceSRF04 library from <https://code.google.com/p/srf04-library/> and connect like in the picture below.

first try the `ultraschall_test` code. check the result in arduino serial monitor.

![ultraschall](ultraschall.jpg?raw=true "ultraschall")

then keep the same hardware setup but upload the other `ultraschall` example. it includes a supercollider patch that demonstrates how to get the serial sensor data into sc and control a filter with it.

bonus
--
table lookup can be used to make leds fade nices. if we fade them lineary like in all the analogWrite examples above, the brightness seem to dip very quickly close to 0 and not change much as we approach 255. the lookup table can compensate for that.

```cpp
//table lookup
//using bytes to save memory
int cnt= 0;
byte table[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10, 11, 11, 11, 12, 12, 13, 13, 14, 14, 14, 15, 15, 16, 16, 17, 17, 18, 18, 19, 19, 20, 21, 21, 22, 22, 23, 23, 24, 25, 25, 26, 27, 27, 28, 29, 29, 30, 31, 31, 32, 33, 34, 34, 35, 36, 37, 37, 38, 39, 40, 41, 42, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 52, 53, 54, 55, 56, 57, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 71, 72, 73, 74, 75, 77, 78, 79, 80, 82, 83, 84, 85, 87, 88, 89, 91, 92, 93, 95, 96, 98, 99, 100, 102, 103, 105, 106, 108, 109, 111, 112, 114, 115, 117, 119, 120, 122, 123, 125, 127, 128, 130, 132, 133, 135, 137, 138, 140, 142, 144, 145, 147, 149, 151, 153, 155, 156, 158, 160, 162, 164, 166, 168, 170, 172, 174, 176, 178, 180, 182, 184, 186, 188, 190, 192, 194, 197, 199, 201, 203, 205, 207, 210, 212, 214, 216, 219, 221, 223, 226, 228, 230, 233, 235, 237, 240, 242, 245, 247, 250, 252, 255};
void setup() {
    pinMode(11, OUTPUT);
}
void loop() {
    byte val = table[cnt];  //get value at index
    analogWrite(11, val);
    cnt = cnt + 1;
    if (cnt > 255) {
        cnt = 0;
    }
    delay(20);
}
```

the supercollider code i wrote for generating this lookup table...
```
c= 2.5; //curvature - try different values
Array.fill(256, {|x| x/255**c*255}).asInteger.postcs.plot;
```

similar example but fading in and out

```cpp
//more advanced table lookup
int cnt= 0;
byte table[] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10, 11, 11, 11, 12, 12, 13, 13, 14, 14, 14, 15, 15, 16, 16, 17, 17, 18, 18, 19, 19, 20, 21, 21, 22, 22, 23, 23, 24, 25, 25, 26, 27, 27, 28, 29, 29, 30, 31, 31, 32, 33, 34, 34, 35, 36, 37, 37, 38, 39, 40, 41, 42, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 52, 53, 54, 55, 56, 57, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 71, 72, 73, 74, 75, 77, 78, 79, 80, 82, 83, 84, 85, 87, 88, 89, 91, 92, 93, 95, 96, 98, 99, 100, 102, 103, 105, 106, 108, 109, 111, 112, 114, 115, 117, 119, 120, 122, 123, 125, 127, 128, 130, 132, 133, 135, 137, 138, 140, 142, 144, 145, 147, 149, 151, 153, 155, 156, 158, 160, 162, 164, 166, 168, 170, 172, 174, 176, 178, 180, 182, 184, 186, 188, 190, 192, 194, 197, 199, 201, 203, 205, 207, 210, 212, 214, 216, 219, 221, 223, 226, 228, 230, 233, 235, 237, 240, 242, 245, 247, 250, 252, 255};
void setup() {
    pinMode(11, OUTPUT);
}
void loop() {
    byte val;
    if(cnt>255) {
        val = table[511-cnt];   //invert index
    } else {
        val = table[cnt];
    }
    analogWrite(11, val);
    cnt = cnt + 1;
    if (cnt > 511) {
        cnt = 0;
    }
    delay(4);
}
```

last you can calculate curvatures etc on the fly. but note that floating-point math like in the example below may bog down the 8bit arduino processor (cpu). working in floating point quickly fills up the program memory, makes the cpu work harder and may cosume more power (e.g. if you want to save battery life do less taxing calculations and thereby put the cpu to sleep quicker).
```cpp
//advanced fading of a single led
int cnt = 0;
void setup() {
    pinMode(11, OUTPUT);
    Serial.begin(57600);
}
void loop() {
    float val = sin(((cnt % 512) / 512.0) * PI * 2.0);  //512 is period
    val = val * sin(((cnt % 190) / 190.0) * PI * 2.0);  //ring modulation
    val = val * 0.5 + 0.5;  //normalize 0.0-1.0
    val = pow(val, 2) * 255.0;  //curvature (= 2.0) and scale to 0-255
    Serial.println(val);
    analogWrite(11, val);
    cnt = cnt + 1;
    delay(4);
}
```

try to change the line `val = pow(val, 2) * 255.0;` to `val = val * 255.0;` and thereby skip the curvature brightness mapping. it's a subtle but noticable difference. without the led spends less time at the bottom (lowest brightness).
there's lot to play around with when it comes to fading leds in a nice way. small tweaks can make an important difference (ref. apple laptop standby led - someone spent time getting that breathing led exactly right).
and different leds will behave differently. higher pwm frequency and dithering are other technique to explore if you want it even smoother near the lowest brightness (e.g. the step between 0 (off) and 1 (first on)).

links
--
one of the best place to find information about what you can do with an arduino and how you do it.
<http://playground.arduino.cc>
look at section 'interfacing with hardware / input' for example.

and a year ago we did arduino <https://github.com/redFrik/udk10-Embedded_Systems/blob/master/udk131212/README.md>
