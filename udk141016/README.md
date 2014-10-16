general course introduction
--------------------

* links to previous semesters... <http://redfrik.github.io/udk00-Audiovisual_Programming/>
* and dates + times for this course... <https://github.com/redFrik/udk12-Back_to_basics> <-save this page

141016
======

today we will just try out four different programming languages and play with the sin math function.

very simplified we can use sin and give it a number, and it will return another number that is always in the range of -1.0 to 1.0.
so sin(1004) will give us -0.96609442513715 and sin(32.3) will give 0.77332788956622.

if we in code make a counter and perform sin(counter) for each step we will get this nice curve...

![sine](sine.png?raw=true "sine")

here the counter (horizontal axis) is counting from 0 up to 1999, and the result (of the sin(counter)) is vertically displayed and show the values running smoothly from -1.0 to 1.0.

processing
==========

download and install processing (2.2.1) from <http://www.processing.org>

copy and paste this code into a new sketch and click the run button.

```
for(int i= 0; i<2000; i++) {
  println( sin(i*0.01) );
}
```
it will just print out 2000 values.

this example on the other hand draws a line from 0,0 to the middle of the window. the x ending position is set by the sin function. 
```
int i= 0;
void setup() {
  size(640, 480);
}
void draw() {
  background(255);
  line(0, 0, sin(i*0.01)*width*0.5+(width*0.5), height*0.5);
  i++;
}
```

note you can also code the same thing using the built-in map function...

`line(0, 0, map(sin(i*0.01), -1, 1, 0, width), height*0.5);`

play around and change some numbers. try to remove the background(255) line. swap line for rect etc etc.

last a more wild example where we copy and paste a few times and then replace some static numbers with sin functions.

```
int i= 0;
void setup() {
  size(640, 480); //window size
}
void draw() {
  background(255*sin(i*0.05)*0.5+(255*0.5)); //use 0-255 background grey color fade
  //noFill(); //try uncomment this line
  rect(0, 0, sin(i*0.01)*width*0.5+(width*0.5), height*0.5);
  line(0, 0, sin(i*0.01)*width*0.5+(width*0.5), height*0.5);
  line(sin(i*0.4)*400+200, 0, sin(i*0.01)*width*0.5+(width*0.5), height*0.5);
  rect(0, (sin(i*0.02)*0.5+0.5)*width, sin(i*0.01)*width*0.5+(width*0.5), height*0.5);
  //try adding more rect or line here
  i++;
}
```

and a bonus example...

```
int i= 0;
void setup() {
  frameRate(60);
  size(640, 480, P2D);
  smooth(4);
}
void draw() {
  stroke(sin(i*0.003)*127.5+127.5); //grey color
  line( //arguments can be written on separate lines - easier to read
    sin(i*0.023)*width*0.5+(width*0.5), //start x
    sin(i*0.024)*height*0.5+(height*0.5), //start y
    sin(i*0.01)*width*0.5+(width*0.5), //stop x
    sin(i*0.012+0.3)*height*0.5+(height*0.5) //stop y
  );
  i++;
}
```



supercollider
=============

download and install supercollider (3.6.6) from <http://supercollider.github.io>

copy this and paste in to a new document. select all and do 'evaluate selection, line or region' under language menu. (cmd+return osx shortcut)

```
2000.do{|i|
	sin(i*0.01).postln;
}
```

it should post 2000 values.

but supercollider is mainly for sound. and to make sound we need first boot the sound server program...
```
s.boot
```
check the post window to see if there are any errors. open the meter window (cmd+m) and see if you have any signal.

run each line separate...

```
Ndef(\sound, {|freq= 500| SinOsc.ar(freq)}).play

Ndef(\sound).set(\freq, 500)

fork{ 200.do{|i| Ndef(\sound).set(\freq, sin(i*0.01)*5000+800); 0.002.wait}}
```

open the stethoscope window with this command...
```
s.scope
```

now we try similar code but with a sawtooth oscillator and added amplitude (volume) control...

```
Ndef(\saw, {|freq= 500, amp= 0.1| Saw.ar(freq*[1, 1.01], amp)}).play

Ndef(\saw).set(\freq, 150)
Ndef(\saw).set(\amp, 0.1)

fork{ 20000.do{|i| Ndef(\saw).set(\freq, sin(i*0.01)*100+100, \amp, sin(i*0.1)); 0.01.wait}}

fork{ 20000.do{|i| Ndef(\saw).set(\freq, sin(i*0.015)*50+200, \amp, sin(i*0.1)); 0.01.wait}}

fork{ 20000.do{|i| Ndef(\saw).set(\freq, sin(i*0.015)*50+2000, \amp, sin(i*0.12)); 0.008.wait}}
```

one can change the oscillator while the program is running and add filters etc...

```
Ndef(\saw, {|freq= 500, amp= 0.1| HPF.ar(Saw.ar(freq*[1, 1.01], amp),1000)}).play
Ndef(\saw, {|freq= 500, amp= 0.1| LPF.ar(Blip.ar(freq*[1, 1.01], 400, amp),1000)}).play
Ndef(\saw, {|freq= 500, amp= 0.1| BPF.ar(PinkNoise.ar(amp!2),freq*[1, 1.01])}).play
```

python
======

python should already be installed on your computer (at least on osx and linux).

open the Terminal application (on osx it is in applications/utilities)

type...
`pico pythontest1.py`

that will create a file and start the pico/nano text editor.  then write the following python program...

```
import math
i= 0
for i in range(200):
	print math.sin(i*0.01) 
```

type `ctrl+o` to save and `ctrl+x` to exit.

next run the python program like this...

```
python pythontest1.py
```


arduino
=======

download and install arduino ide (1.0.6) from <http://arduino.cc>

note: you might also need the ftdi driver <http://www.ftdichip.com/Drivers/VCP.htm>

note2: for the code below you will need an arduino board of some sort.

this first example will just send back value via the serial port. open the serial monitor in the arduino ide to see the result (set baudrate in popup to 38400).

```
int i= 0; //our counter
void setup() {
  Serial.begin(38400); //set up serial port
}
void loop() {
  Serial.println( sin(i*0.01) ); //print to serial port
  i= i+1; //increase counter
  delay(50); //wait 50milliseconds
}
```

using a led. try changing from pin 13 to pin 9 and add a real led + resistor.

```
int i= 0;
void setup() {
  pinMode(13, OUTPUT); //activate builtin led
}
void loop() {
  analogWrite(13, int(sin(i*0.01)*127.5+127.5));
  i= i+1;
  delay(10);
}
```



resources
=========

Dan Shiffman's introduction to programming (using processing) <https://vimeo.com/channels/introcompmedia>

Eli Fieldsteel's supercollider tutorials <https://www.youtube.com/watch?v=yRzsOOiJ_p4>
