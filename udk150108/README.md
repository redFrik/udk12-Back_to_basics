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


amplitude tracking
--
```
Ndef(\amptrk, {SinOsc.ar([400, 404])*(Amplitude.ar(SoundIn.ar)>MouseX.kr(0, 1).poll).poll}).play

Ndef(\amptrk, {SinOsc.ar([400, 404])*(Amplitude.ar(SoundIn.ar).lag(0.5)>MouseX.kr(0, 1).poll).poll}).play

//(root mean square RMS)

//schmidt trigger
Ndef(\amptrk, {SinOsc.ar([400, 404])*(Schmidt.ar(Amplitude.ar(SoundIn.ar).lag(0.75), 0.005, 0.2)).poll}).play

Ndef(\amptrk, {SinOsc.ar([400, 404])*(Schmidt.ar(Amplitude.ar(DelayN.ar(SoundIn.ar, 1, 1)).lag(0.75), 0.08, 0.1)).poll}).play

Ndef(\amptrk, {SinOsc.ar([400, 404])*(Schmidt.ar(Amplitude.ar(CombN.ar(SoundIn.ar, 0.5, 0.5, 5)).lag(0.3), 0.02, 0.1)).poll}).play
```

three ways (out of many) to extract/track data from microphone input (or any sound)

* amplitude
* pitch (frequency)
* centroid (kind of timbre (if the sound is noisy or pure))

```
Ndef(\pchtrk, {SinOsc.ar(Pitch.kr(SoundIn.ar)[0].poll, 0, 0.5)}).play

Ndef(\pchtrk, {SinOsc.ar(Pitch.kr(SoundIn.ar)[0].lag(2).poll, 0, 0.5)}).play
//try with lag(0.001) for birdy chatter

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

