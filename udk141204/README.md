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

here we use the [redboard](https://www.sparkfun.com/products/12757) from sparkfun. it's a version of the arduino uno, but the examples below will work on almost all arduino models.

how to connect
--

just connect a mini usb cable between laptop and the arduino. you should see the device show up under tools/port menu.

overview
--

there are four very common commands/techniques and we will go through each one and try the typical use case.
two of them are `digitalWrite` and `digitalRead`. these use only 0 and 1 for reading and writing to/from pins.
the other two are `analogWrite` and `analogRead`. these use continuous values (0-255 and 0-1023) for reading and writing to special 'analog' 'pins.

* digitalWrite (0/1)
* analogWrite(0-255)    //only works on pins with the ~ sign
* digitalRead(0/1)
* analogRead(0-1023)    //only works on pins A0-A5


digitalWrite
--
```
//--simple blink led
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

[img] TODO

keep the same connection and upload the following example...

```
//--blink two leds (alternating)
void setup() {
    pinMode(11, OUTPUT);
    pinMode(13, OUTPUT);    //here also using the built-in on-board blue led
}
void loop() {
    digitalWrite(11, 1);
    delay(500);
    digitalWrite(11, 0);
    delay(250);

    digitalWrite(13, 1);
    delay(100);
    digitalWrite(13, 0);
    delay(141);
}
```

note how arduino is single threaded. that means it can only do one thing at a time and it is actually quite difficult to do two or more independent things (unlike in multithreaded programming languages like supercollider).
so in the example right above we blink the leds one after the other - and that's simple. but if we want to blink them both at different independent tempi, we need to write more code. the below example show one way to do it. the trick is to avoid `delay()`, keep the loop running and instead use counters.

```
//--independent blinking (advanced)
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


analogWrite
--
note it is called analogWrite but the functionallity is actually [pwm](http://arduino.cc/en/Tutorial/PWM) (pulse-width modulation).

```
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
```
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

```
//digital read that read pin 3 and fade led if pressed
int cnt= 0;
void setup() {
    pinMode(3, INPUT_PULLUP);
    pinMode(11, OUTPUT);
}
void loop() {
    int val;
    val= digitalRead(3);
    if(val==0) {
        analogWrite(11, cnt);
        cnt= cnt+1;
        if(cnt==255) {
            cnt= 0;
        }
    }
    delay(5);
}
```

```
//analogRead
```

TODO


communication
--
to send data to and from the laptop we need to use the serial port.

TODO

ultrasound
--
 (serial test exempel)

TODO

//--bonus:

TODO kurvatur (table lookup)


links
--
one of the best place to find information about what you can do with an arduino and how you do it.
<http://playground.arduino.cc>
look at section 'interfacing with hardware / input' for example.
