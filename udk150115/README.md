150115
======

own project + oscP5 + tracking


simple text
--
first run and study this processing code...

```cpp
//simple example just to show how to draw text
void setup() {
    size(800, 600);
    frameRate(30);  //try different like 25, 40, 60
}
void draw() {
    background(0);
    textSize(64);
    fill(255);  //white text colour
    text("framerate:"+frameRate, 100, 100);
    text("framecount:"+frameCount, 100, 170);
}
```

osc from sc to processing
--
install the oscP5 library and run this processing code...
```cpp
//--osc_sc_to_processing_example
//install library oscP5:
//  menu > sketch > import library > add library
//  search for oscP5 and click install
import oscP5.*;
OscP5 oscP5;
float data= -1;  //default value
void setup() {
    size(800, 600);
    frameRate(60);
    oscP5= new OscP5(this, "127.0.0.1", 57120, 9876, "oscEvent"); //9876 is incoming port
}
void draw() {
    background(int(data/5000.0*255));  //scale freq to 0-255
    textSize(64);
    fill(255);  //white text colour
    text("my data: "+data, 100, 100);
}
void oscEvent(OscMessage oscIn) {
    if (oscIn.checkAddrPattern("/abc")) {  // /abc is address
        if (oscIn.checkTypetag("f")) {  //only one float value
            data= oscIn.get(0).floatValue();  //extract the float
        }
    }
}
```

then try this supercollider code...
```
n= NetAddr("127.0.0.1", 9876);
n.sendMsg(\abc, 567.432);
n.sendMsg(\abc, 4000.0);//make sure to send a float
n.sendMsg(\abc, 3000);//this will not be accepted by processing (an integer)
```

9876 is the port and "127.0.0.1" is the localhost (or loopback) ip address. the port number can be nearly anything, but use "127.0.0.1" exactly as written when you want to send osc data between applications on the same computer.

if the above works, we can then move on to some more advanced code.

```
//--osc_sc_to_processing.scd
//analyze pitch and send to processing
(
n= NetAddr("127.0.0.1", 9876);
OSCFunc({|msg|
    msg.postln;
    n.sendMsg(\abc, msg[3]);
}, "/fre");
Ndef(\fretrk, {
    var pitch= Pitch.kr(SoundIn.ar)[0].lag(0.3);    //0.3 is smooth factor
    SendReply.kr(Impulse.kr(60), "/fre", pitch);    //60 is updaterate
    SinOsc.ar(pitch, 0, 0.5);
}).play;
)
```
