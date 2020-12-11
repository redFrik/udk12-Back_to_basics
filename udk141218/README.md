141218
======

arduino and supercollider

simple
--
upload this sketch to your arduino. it will read A0, scale down from 0-1023 to 0-255 and send this as a raw byte value over serial.

note the difference between `Serial.write` and `Serial.println`. the latter is only really useful for debugging in arduino's serial monitor. use .write when sending to supercollider (or processing).

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

(the above is the same example and then one we started with last week)

then run this code in supercollider. it will try to connect to your arduino serial port (edit the port name to match your arduino port). 
```supercollider
s.boot;
SerialPort.listDevices.postln; //post available ports

(
var port;
port= SerialPort("/dev/tty.usbserial-A101NAZV", 57600, crtscts: true); //edit to match your arduino portname
Ndef(\snd, {|freq= 400| SinOsc.ar(freq*[1, 1.01], 0, 0.4)}).play;
Routine.run({
    inf.do{
        var val;
        val= port.read;
        val.postln; //debug
        Ndef(\snd).set(\freq, val.linexp(0, 255, 300, 3000));
    };
});
CmdPeriod.doOnce({port.close});
)
```

connect a bare wire to A0 to get some noise input.

it should sound and post values. stop it with cmd+period.

now try lowering the delay time in arduino, change the sound in supercollider, change the mapping (.linexp) also in supercollider, maybe add a smoothing .lag(1) to freq etc etc.

then try connect a potentiometer like this...

![simple_analog_read](simple_analog_read.jpg?raw=true "simple_analog_read")

and perhaps try a light sensor (photoresistor / LDR). you can connect it with a voltage divider like this...

![simple_analog_read2](simple_analog_read2.jpg?raw=true "simple_analog_read2")

(the resistor here is 10K)

multiple sensors
--
if you want to read more than one analog input, the code gets a little bit more involved.

```cpp
void setup() {
    Serial.begin(57600);
}
void loop() {
    Serial.write(100); //'header'
    int val= analogRead(A0);  //0-1023 (10bit)
    Serial.write(val/4);  //scaled down to 0-255 (8bit)
    int val2= analogRead(A1);
    Serial.write(val2/4);
    delay(20);  //try to lower or remove for quicker update rate
}
```

and the matching supercollider code then needs to look like this...
```supercollider
(
var port;
port= SerialPort("/dev/tty.usbserial-A101NB79", 57600, crtscts: true); //edit to match your arduino portname
Ndef(\snd, {|freq= 400, amp= 0.4| SinOsc.ar(freq*[1, 1.01], 0, amp)}).play;
Routine.run({
    var header, val, val2;
    inf.do{
        while({header= port.read; header!=100}, {});
        val= port.read;
        //val.postln; //debug
        Ndef(\snd).set(\freq, val.linexp(0, 255, 300, 3000));
        val2= port.read;
        Ndef(\snd).set(\amp, val2.linlin(0, 255, 0, 1));
    };
});
CmdPeriod.doOnce({port.close});
)
```

so connect sensors to A0 and A1 and run the code above. A0 should control frequency and A1 volume.

the added complexity here is because we probably want to know which of the values A0 or A1 we are receiving in supercollider. to do that we can first send out a special value (here 100), then the A0 value and last the A1 value. so the whole 'package' will be [100, A0, A1].
in supercollider we then read input values and wait until a 100 is received. then we know that we can read the following two incoming values into the right variables (here A0 and A1 into val and val2).
this is not 100% failsafe, but for now it's ok. (e.g. it will fail at upstart if both analog inputs are also 100). to improve it you can send more 'header' and even 'footer' values, but that also comes to with a price of more data overhead more cpu load.

controlling soundfile playback
--
last we change the supercollider code a little bit so that it will loop a soundfile instead of playing a synthetic sound. A0 will control playback rate (think tape speed) and A1 the volume - just like before.
```supercollider
s.boot;
b= Buffer.read(s, "/Users/Helmut/sounds/drums/hhat5.aiff"); //edit this to point to an .aiff or .wav
b.play; //test to see if it loaded

(
var port;
port= SerialPort("/dev/tty.usbserial-A101NB79", 57600, crtscts: true); //edit to match your arduino portname
Ndef(\snd, {|rate= 1, amp= 0.4| PlayBuf.ar(b.numChannels, b, rate, loop:1)*amp}).play;
Routine.run({
    var header, val, val2;
    inf.do{
        while({header= port.read; header!=100}, {});
        val= port.read;
        //val.postln; //debug
        Ndef(\snd).set(\rate, val.linlin(0, 255, -1, 3));   //try with different min/max (-1 and 3)
        val2= port.read;
        Ndef(\snd).set(\amp, val2.linlin(0, 255, 0, 1));
    };
});
CmdPeriod.doOnce({port.close});
)
```

extra
--
how to connect a 12V dc motor or 12V lamp(s).

```cpp
//arduino code for testing mosfet_dcmotor
void setup() {
    pinMode(9, OUTPUT);
}
void loop() {
    digitalWrite(9, 1);
    delay(2000);
    digitalWrite(9, 0);
    delay(3000);
}
```

here in the picture is an arduino nano, but it will work with any type of arduino (just double check it has an onboard regulator and can take 12V on the vin pin - most can).

![mosfet_dcmotor](mosfet_dcmotor.png?raw=true "mosfet_dcmotor")

![mosfet_dcmotor_schem](mosfet_dcmotor_schem.png?raw=true "mosfet_dcmotor_schem")

note that the mosfet might need a [heatsink](https://blog.adafruit.com/2012/08/28/new-product-to-220-clip-on-heatsink/). depends on how much current your motor is using and for how long you keep it running. (rule of thumb: if the component is so hot that you can't touch it - add a heatsink - the bigger the better - and best result with a drop of [thermal grease](https://en.wikipedia.org/wiki/Thermal_paste)).

the 'flyback' diode can be a 1N4001, 1N4007 or anything in between.

use thick short wires for the 12V and motor. don't connect it on a breadboard if you need to draw more than maybe 1A - then it is better to solder the components on a protoboard.

extra2
--
synthetic piano with effects. for the following example to work you will need to download and install [sc3-plugins](https://supercollider.github.io/sc3-plugins/).
```supercollider
s.boot;

(
SynthDef(\pi, {|out=0, freq=440, amp=0.5, gate=1, rho=1|
    var src= OteyPiano.ar(freq, amp, gate, rho:rho);
    OffsetOut.ar(out, Pan2.ar(src));
}).add;
SynthDef(\ringmod, {|in= 10, out=0, freq= 20|
    var src= In.ar(in, 2);
    Out.ar(out, src*SinOsc.ar(freq));
}).add;
)

(
d= Synth(\ringmod);
Pbind(
    \instrument, \pi,
    \delta, 0.25,
    \dur, 0.5,
    \degree, Pseq([1, 3, 5], inf),
    //\rho, Pwhite(0.1,3) //effect
    \out, Pseq([0, 0, 0, 0, 0, 0, 10, 10, 10, 10, 10], inf) //ringmod
).play;
)

d.set(\freq, 2000)
d.set(\freq, 200)
d.set(\freq, 20)
d.set(\freq, 2)
```
