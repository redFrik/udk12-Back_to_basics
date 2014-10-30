//start afresh
Ndef.all.clear
s.reboot


//low frequency oscillators (LFO)
Ndef(\aaa, {SinOsc.ar([0.2, 0.3])})
Ndef(\bbb, {SinOsc.ar([2, 3])})
Ndef(\ccc, {MouseX.kr(0, 8)})

Ndef(\sine2, {SinOsc.ar([400, 404]*Ndef.kr(\ccc))})
Ndef(\sine2).play //now move the mouse (ccc)
Ndef(\sine2, {SinOsc.ar([400, 404]*Ndef.kr(\aaa))})
Ndef(\sine2, {SinOsc.ar([400, 404]*Ndef.kr(\bbb))})

//combining automatic lfo and mouse
Ndef(\sine2, {SinOsc.ar([400, 404]*Ndef.kr(\bbb)*Ndef.kr(\ccc)*Ndef.kr(\aaa))})

//start messing with the lfos
Ndef(\aaa, {LFPulse.ar([1, 1.1])})
Ndef(\aaa, {LFPulse.ar([10, 10.1])})
Ndef(\bbb, {LFPulse.ar([2, 3])})
Ndef(\bbb, {LFPulse.ar([Ndef.ar(\aaa), Ndef.ar(\ccc)])})

//replace mouse with microphone
Ndef(\ccc, {Amplitude.kr(SoundIn.ar)})

s.meter

//now try to replace LFPulse and SinOsc above with these...
//LFSaw, Blip, LFNoise0, LFNoise1, LFTri
//and change numbers here and there

