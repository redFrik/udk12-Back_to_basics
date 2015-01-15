150108
======

own projects


sinewaves
--

```
s.boot

//beating sines
Ndef(\clicksine, {SinOsc.ar([50, 50.1], 0, 0.5)}).play
Ndef(\clicksine, {SinOsc.ar([50, 49], 0, 0.5)}).play

Ndef(\clicksine, {SinOsc.ar([150, 164], 0, 0.5)}).play

Ndef(\clicksine, {SinOsc.ar([150, 150+SinOsc.ar(0.1, 0, 10)], 0, 0.5)}).play


Ndef(\clicksine, {SinOsc.ar([150, 151], 0, 0.5)}).play
Ndef(\clicksine, {SinOsc.ar([150, 151], 0, 0.5)*(SinOsc.ar(2.01)>0)}).play

Ndef(\clicksine, {SinOsc.ar([150, 151], 0, 0.5)*(SinOsc.ar([2.01, 2.02])>0)}).play

Ndef(\clicksine, {SinOsc.ar([150, 151], 0, 0.5)*(SinOsc.ar([3, 4])>0)}).play


{SinOsc.ar(5000)*SinOsc.ar(200)}.plot
{SinOsc.ar(5000)+SinOsc.ar(200)}.plot
```

analyzing sound
---

three ways (out of many) to extract/track data from microphone input (or any sound)

* amplitude
* pitch (frequency)
* centroid (kind of timbre (if the sound is noisy or pure))

amplitude tracking
--
```
Ndef(\amptrk, {SinOsc.ar([400, 404])*(Amplitude.ar(SoundIn.ar)>0.3).poll}).play

//using mouse to set a good threshold
Ndef(\amptrk, {SinOsc.ar([400, 404])*(Amplitude.ar(SoundIn.ar)>MouseX.kr(0, 1).poll).poll}).play

Ndef(\amptrk, {SinOsc.ar([400, 404])*(Amplitude.ar(SoundIn.ar).lag(0.5)>MouseX.kr(0, 1).poll).poll}).play

//schmidt trigger
Ndef(\amptrk, {SinOsc.ar([400, 404])*(Schmidt.ar(Amplitude.ar(SoundIn.ar).lag(0.75), 0.005, 0.2)).poll}).play

//messing with input sound from mic (here adding delay and echo (comb))
Ndef(\amptrk, {SinOsc.ar([400, 404])*(Schmidt.ar(Amplitude.ar(DelayN.ar(SoundIn.ar, 1, 1)).lag(0.75), 0.08, 0.1)).poll}).play

Ndef(\amptrk, {SinOsc.ar([400, 404])*(Schmidt.ar(Amplitude.ar(CombN.ar(SoundIn.ar, 0.5, 0.5, 5)).lag(0.3), 0.02, 0.1)).poll}).play
```

pitch tracking
--

```
Ndef(\pchtrk, {SinOsc.ar(Pitch.kr(SoundIn.ar)[0].poll, 0, 0.5)}).play

//lag is very useful for smoothing out the resulting control signal (also see lag2, lagud, lag3)
Ndef(\pchtrk, {SinOsc.ar(Pitch.kr(SoundIn.ar)[0].lag(2).poll, 0, 0.5)}).play
//try with lag(0.001) for birdy chatter

//using mouse to find a good lagtime
Ndef(\pchtrk, {SinOsc.ar(Pitch.kr(SoundIn.ar)[0].lag(MouseX.kr(0, 3)).poll, 0, 0.5)}).play


Ndef(\pchtrk, {SinOsc.ar(Pitch.kr(CombN.ar(SoundIn.ar, 1, 1))[0].lag(0.5).poll, 0, 0.5)}).play
```


routing the pitch to another synth
--
```
(
Ndef(\freqtracker, {Pitch.kr(SoundIn.ar)[0].lag(0.2)});

Ndef(\mysynth, {SinOsc.ar(Ndef.kr(\freqtracker), 0, 0.5)}).play;
)

b= Buffer.read(s, "/Applications/Max 6.1/patches/media/talk.aiff")
Ndef(\mysecondsynth, {PlayBuf.ar(b.numChannels, b, Ndef(\freqtracker).kr.explin(60, 5000, 0, 2), loop:1)*0.5}).play
```


centroid
--

```
//try whistle versus blowing into the mic
(
Ndef(\noisetrk, {
var chain, freq, centroid;
chain= FFT(LocalBuf(2048, 1), SoundIn.ar);
centroid= SpecCentroid.kr(chain);
freq= centroid.linexp(1300, 7000, 100, 1000).lag(0.1);
SinOsc.ar(freq, 0, 0.4);
}).play
)

//'consonant' detector
(
Ndef(\noisetrk, {
var chain, amp, centroid;
chain= FFT(LocalBuf(2048, 1), SoundIn.ar);
centroid= SpecCentroid.kr(chain);
amp= centroid.linlin(1300, 7000, 0, 1).lag(0.1)>0.4;
SinOsc.ar([400, 404], 0, amp);
}).play
)

//'vowel' detector - note only changed from > to < for
(
Ndef(\noisetrk, {
var chain, amp, centroid;
chain= FFT(LocalBuf(2048, 1), SoundIn.ar);
centroid= SpecCentroid.kr(chain);
amp= centroid.linlin(1300, 7000, 0, 1).lag(0.1)<0.4;
SinOsc.ar([400, 404], 0, amp);
}).play
)
```

sc to arduino examples
--

first connect an arduino and upload this code...
```cpp
//save as simple_sc_to_pwm.ino
//connect led with resistor between pin9 and gnd
//upload to arduino
void setup() {
Serial.begin(57600);
pinMode(9, OUTPUT);
}
void loop() {
if(Serial.available()) {
int val= Serial.read();  //0-255
analogWrite(9, val);  //0-255
}
delay(1);
}
```

```
//--amplitude turning led on/off
SerialPort.listDevices  //should show your arduino

(
//use together with simple_sc_to_pwm.ino
var sp= SerialPort("/dev/tty.usbserial-A101NAZV", 57600, crtscts: true);    //edit to match your arduino
CmdPeriod.doOnce({sp.close});
OSCFunc({|msg|
    msg.postln; //debug
    sp.put(msg[3]*255);
}, "/amp");
Ndef(\amptrk, {
    var amp= Schmidt.ar(Amplitude.ar(SoundIn.ar).lag(0.75), 0.01, 0.1);
    SendReply.ar(Changed.ar(amp), "/amp", amp); //send back to sclang and oscfunc
    SinOsc.ar([400, 404], 0, 0.5)*amp;
}).play;
)

//--pitch controlling led brightness
(
var sp= SerialPort("/dev/tty.usbserial-A101NAZV", 57600, crtscts: true);    //edit to match your arduino
CmdPeriod.doOnce({sp.close});
OSCFunc({|msg|
    msg.postln;
    sp.put(msg[3].expexp(60, 4000, 0.1, 255).asInteger);
}, "/fre");
Ndef(\fretrk, {
    var pitch= Pitch.kr(SoundIn.ar)[0].lag(0.3);
    SendReply.kr(Impulse.kr(60), "/fre", pitch);
    SinOsc.ar(pitch, 0, 0.5);
}).play;
)
```
