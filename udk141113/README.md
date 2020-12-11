141113
======

more [supercollider](https://supercollider.github.io).

```supercollider
//questions from last week?

//today more sc

//note: NO class next week! (20nov2014)

//question: how does .tanh distort
//compare different kinds of distortion / clipping techniques...
//try replacing 1.3 with values 0.5..100
//if this value is equal to or below 1.0 - then no change (or not much at least)
//if this value is above 1.0 the signal either clips, folds back, wraps around, smooths out
s.boot
s.scope
Ndef(\snd).play
Ndef(\snd, {SinOsc.ar(200, 0, 1.3).clip(-1, 1)})
Ndef(\snd, {SinOsc.ar(200, 0, 1.3).tanh})
Ndef(\snd, {SinOsc.ar(200, 0, 1.3).softclip})
Ndef(\snd, {SinOsc.ar(200, 0, 1.3).fold(-1, 1)})
Ndef(\snd, {SinOsc.ar(200, 0, 1.3).wrap(-1, 1)})
Ndef(\snd).stop








s.reboot
Ndef.all.clear

//MouseX - used as a fake sensor for today
//but could be any kind of input: light, temp, movment, slider, accelerometer etc.

//sensor absolut position controls only volume
//one to one mapping of sensor to some sound parameter
Ndef(\sensor, {MouseX.kr(0, 1)})
Ndef(\sine, {SinOsc.ar([400, 404])*Ndef.kr(\sensor)})
Ndef(\sine).play

//change so that sensor control multiple parameters (freq and vol)
//one to many mapping
Ndef(\sine, {SinOsc.ar([800, 804]*Ndef.kr(\sensor))*Ndef.kr(\sensor)})

//now change sensor
//here it is now rate-of-change instead of absolute position
Ndef(\sensor, {MouseX.kr(0, 1) - DelayN.kr(MouseX.kr(0, 1))})
//much more interesting result and the sensor is not depending on exact position. only amount of change.

//different delay times give different sensitivity
Ndef(\sensor, {MouseX.kr(0, 1) - DelayN.kr(MouseX.kr(0, 1), 0.5, 0.5)})
Ndef(\sensor, {MouseX.kr(0, 1) - DelayN.kr(MouseX.kr(0, 1), 1, 1)})

//for shorted delay one might need to boost the sensor signal a bit
Ndef(\sensor, {MouseX.kr(0, 1) - DelayN.kr(MouseX.kr(0, 1), 0.1, 0.1)*5})

//so a super sensitive sensor that detect change...
Ndef(\sensor, {MouseX.kr(0, 1) - DelayN.kr(MouseX.kr(0, 1), 0.05, 0.05)*30})

//in supercollider any signal/sound can be delayed like this...
//DelayN.kr(snd, 1, 1)
//where the first 1 is max delatime and the second 1 is actual delay time.
//that means the second should never be larger than the first. and the first you can not modulate with a signal.

//now we change the \sine sound to be a more complex phase modulation synth
//controlling: freq, phasemod, amp
Ndef(\sine, {SinOsc.ar(0, SinOsc.ar([400, 404]*Ndef.kr(\sensor).lag(0.1))*Ndef.kr(\sensor).lag(1)*50)*Ndef.kr(\sensor).lag(2)})

//phase modulation in supercollider can look like this...
//SinOsc.ar(freq, phase, amp)
//SinOsc.ar(0, SinOsc.ar(freq)*2pi, amp)

//rewriting the code using variables (just to make it more readable)
(
Ndef(\sensor, {MouseX.kr(0, 1)-DelayN.kr(MouseX.kr(0, 1), 1, 1)});
Ndef(\sine, {
    var phaseamp= Ndef.kr(\sensor).lag(0.2)*50;
    var phasefreq= [400,404]*Ndef.kr(\sensor).lag(0.01);
    var phasemod= SinOsc.ar(phasefreq)*phaseamp;//try changing here
    var sine= SinOsc.ar(0, phasemod); //dont touch this!
    sine*Ndef.kr(\sensor).lag(0.1);
});
)
Ndef(\sine).play
//try change the delaytime
//try change lag times
//try change phasemod SinOsc to LFDNoise1, LFTri, LFSaw, Blip etc.


//--
s.reboot
Ndef.all.clear

//this demonstrates that any sensor input can be used - not only 0-1
//here we use 400 to 1000 as input and then calculate the difference (rate or degree of change)
Ndef(\my, {MouseY.kr(400, 1000)})//change to y axis
Ndef(\tri, {LFTri.ar(Ndef.kr(\my).abs+1*[1, 1.001])})
Ndef(\tri).play

Ndef(\my, {MouseY.kr(400, 1000) - DelayN.kr(MouseY.kr(400, 1000), 0.5, 0.5)})

(
Ndef(\my, {MouseY.kr(400, 1000) - CombN.kr(MouseY.kr(400, 1000).lag(2), 0.1, 0.1, 1)});
Ndef(\mx, {MouseX.kr(0, 1) - DelayN.kr(MouseX.kr(0, 1), 0.1, 0.1)});
Ndef(\tri, {LeakDC.ar(LFTri.ar(Ndef.kr(\my).abs.lag(0.1)+1*[1, 1.001])*Ndef.kr(\mx).lag(0.01))});
)

Ndef(\tri).play


//bonus: replace mouse x and y with a pair or slow SinOsc
(
Ndef(\my, {SinOsc.kr(5.5)*300+400 - DelayN.kr(SinOsc.kr(4.2)*300+400, 0.5, 0.5)});
Ndef(\mx, {SinOsc.kr(5.6) - DelayN.kr(SinOsc.kr(4.1), 0.5, 0.5)});
)

//and start to play around with different numbers and oscillators (LFTri, LFPar, Blip, LFDNoise0, LFDNoise1 etc)
(
Ndef(\my, {LFTri.kr(0.5)*300+400 - DelayN.kr(LFTri.kr(1.4)*300+400, 0.5, 0.5)});
Ndef(\mx, {Blip.kr(10.01) - DelayN.kr(Blip.kr(5), 0.5, 0.5)});
)
```


links
-----

lots of examples: <https://sccode.org>

tutorials: <https://supercollider.github.io/tutorials/index.html>

there is a book: <https://mitpress.mit.edu/books/supercollider-book>
