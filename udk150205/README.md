150205
======

own project - last meeting


sc to max
--
see the folder 'sctomax' for two examples of sending osc data from supercollider patterns to maxmsp.

![sctomax](sctomax/sctomax.png?raw=true "sctomax")

supercollider code: sctomax.scd

```supercollider
//use with sctomax.maxpat
s.latency= 0.05;
s.boot;
n= NetAddr("127.0.0.1", 9876);

Pbind(\degree, Pseq([0, 1, 5, 4, 2, 3, 2, 1], inf), \do, Pfunc({|e| e.use{~freq.value.postln}})).play

//now open sctomax.maxpat and start the [dac~]

(  //reevaluate a few times
Pdef(\tomax, Pbind(
    \dur, 0.2,
    \degree, Pseq([0, 1, 5, 4, 2, 3, 2, 1], inf),
    \stepsPerOctave, 11,
    \amp, Pseq({1.0.linrand*2.rand}!16, inf),
    \mod, Pseq({100.rand*2.rand}!12, inf),
    \do, Pfunc({|e| e.use{
        n.sendMsg(\freq, ~freq.value);
        n.sendMsg(\amp, ~amp.value);
        n.sendMsg(\mod, ~mod.value);
    }})
)).play
)

//to silence the sc default instrument, either add a \out, 10
//or make a dummy synthdef and add \instrument, \dummy

(  //reevaluate a few times
Pdef(\tomax, Pbind(
    \out, 10,
    \dur, 0.2,
    \degree, Pseq([0, 1, 5, 4, 2, 3, 2, 1.1], inf),
    \stepsPerOctave, 12,
    \amp, Pseq({1.0.linrand*2.rand}!16, inf),
    \mod, 0,
    \do, Pfunc({|e| e.use{
        n.sendMsg(\freq, ~freq.value);
        n.sendMsg(\amp, ~amp.value);
        n.sendMsg(\mod, ~mod.value);
    }})
)).play
)


//and to use different tunings try to Scale + Tuning classes

(
Pdef(\tomax, Pbind(
    \out, 10,
    \dur, 0.2,
    \scale, Scale.lydian(Tuning.just),//Tuning.et12
    \degree, Pseq((0..11), inf),
    \stepsPerOctave, 12,
    \amp, 0.5,
    \mod, 0,
    \do, Pfunc({|e| e.use{
        n.sendMsg(\freq, ~freq.value);
        n.sendMsg(\amp, ~amp.value);
        n.sendMsg(\mod, ~mod.value);
    }})
)).play
)
```


arduino with max
--
see the folder 'simple_max-arduino' for a simple example of how to read one sensor with an arduino and then get the data into maxmsp via the serial port.

![maxarduino](simple_max-arduino/maxarduino.png?raw=true "maxarduino")

arduino code: maxarduino.ino:

```cpp
void setup() {
    Serial.begin(57600);
}
void loop() {
    Serial.write(analogRead(A0)/4);  //scale from 10bits (0-1023) down to 8bits (0-255)
    delay(20);  //updaterate
}
```
