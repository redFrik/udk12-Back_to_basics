general course introduction
--------------------

* links to previous semesters... <http://redfrik.github.io/udk00-Audiovisual_Programming/>
* and dates + times for this course... <https://github.com/redFrik/udk12-Back_to_basics> <-save this page

141016
======

today we will just try out four different programming languages and play with the sin math function.

very simplified we can use sin and give it a number, and it will return another number that is always in the range of -1.0 to 1.0.
so sin(1004) will give us -0.96609442513715 and sin(32.3) will give 0.77332788956622.

if we make a counter and do sin(counter) for each step we will get this smooth sine curve...
![sine](sine.png?raw=true "sine")
here the counter (horizontal axis) is counting from 0 up to 2000, and the result (the sin(counter)) is vertically displaying values from -1.0 to 1.0.

processing
==========

download and install processing (2.2.1) <http://www.processing.org>

copy and paste this code into a new sketch and click the run button.
```
for(int i= 0; i<2000; i++) {
  println( sin(i*0.01) );
}
```
it will just print out 2000 values.

this example draws a line from 0,0 to the middle of the window. the x ending position is set by the sin function. 
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
´´´
line(0, 0, map(sin(i*0.01), -1, 1, 0, width), height*0.5);
´´´

last a more while example where we copy and paste a few times and then replace some static numbers with sin functions.
```
int i= 0;
void setup() {
  size(640, 480);
}
void draw() {
  background(255*sin(i*0.05)*0.5+(255*0.5));
  //noFill();
  rect(0, 0, sin(i*0.01)*width*0.5+(width*0.5), height*0.5);
  line(0, 0, sin(i*0.01)*width*0.5+(width*0.5), height*0.5);
  line(sin(i*0.4)*400+200, 0, sin(i*0.01)*width*0.5+(width*0.5), height*0.5);
  rect(0, (sin(i*0.02)*0.5+0.5)*width, sin(i*0.01)*width*0.5+(width*0.5), height*0.5);
  i++;
}
```



supercollider
=============

download and install supercollider (3.6.6) <http://supercollider.github.io>

python
======

python should already be installed on your computer (osx + linux).

arduino
=======

download and install arduino ide (1.0.6) <http://arduino.cc>

you might also need the ftdi driver <http://www.ftdichip.com/Drivers/VCP.htm>

resources
=========

Dan Shiffman's introduction to programming (using processing) <https://vimeo.com/channels/introcompmedia>

Eli Fieldsteel's supercollider tutorials <https://www.youtube.com/watch?v=yRzsOOiJ_p4>
