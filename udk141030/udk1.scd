
//supercollider is really two programs...
//sclang - programming language
//scsynth - noise machine (hidden)
//(or three if you count the ide (integrated development environment))

//to make sound we first need to start scsynth...

s.boot

//then create a sound/synth

Ndef(\sound, {SinOsc.ar([400, 404])})
Ndef(\sound).play
Ndef(\sound).stop

//change the sound
Ndef(\sound, {SinOsc.ar([180, 104])})
Ndef(\sound).play
Ndef(\sound).stop

//change it again
Ndef(\sound, {SinOsc.ar([1800, 1040])})
Ndef(\sound).play
Ndef(\sound).stop

//or better - change it while it is playing
Ndef(\sound).play
Ndef(\sound, {SinOsc.ar([500, 505])})
Ndef(\sound, {SinOsc.ar([600, 604])})
Ndef(\sound, {SinOsc.ar([700, 703])})
Ndef(\sound, {SinOsc.ar([800, 802])})
Ndef(\sound).stop

//create another type of sound
Ndef(\noise, {PinkNoise.ar(SinOsc.ar([10, 0.2]))})
Ndef(\noise).play
Ndef(\noise).stop

//notice left and right channels
Ndef(\noise).play
Ndef(\noise, {PinkNoise.ar(SinOsc.ar([1, 0.2]))})
Ndef(\noise, {PinkNoise.ar(SinOsc.ar([1, 2.2]))})

//cross fade
Ndef(\noise).fadeTime= 10

//now every change you make will take 10 seconds
Ndef(\noise, {PinkNoise.ar(SinOsc.ar([10, 11]))})
Ndef(\noise, {PinkNoise.ar(SinOsc.ar([40, 24]))})
Ndef(\noise, {PinkNoise.ar(SinOsc.ar([0.4, 0.5]))})
Ndef(\noise, {PinkNoise.ar(SinOsc.ar([400, 220]))})
Ndef(\noise, {PinkNoise.ar(SinOsc.ar([700, 800]))})
Ndef(\noise).stop(8) //fade out and stop 8 seconds

//yet another sound
Ndef(\klick, {BPF.ar(Impulse.ar([1, 1.1])*4)})
Ndef(\klick).play
Ndef(\klick).fadeTime= 4
Ndef(\klick, {BPF.ar(Impulse.ar([10, 11])*4)})
Ndef(\klick, {BPF.ar(Impulse.ar([20, 21])*4)})
Ndef(\klick, {BPF.ar(Impulse.ar([200, 201])*4)})
Ndef(\klick, {BPF.ar(Impulse.ar([100, 101])*4)})
Ndef(\klick, {BPF.ar(Impulse.ar([0.6, 0.5])*4)})
Ndef(\klick).stop

s.meter //level meters
s.scope //signal scope
NdefMixer(s) //automatic gui for Ndefs
s.makeWindow //for recording and main volume
