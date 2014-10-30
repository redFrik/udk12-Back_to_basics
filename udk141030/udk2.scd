//start afresh
Ndef.all.clear
s.reboot

Ndef(\sine, {SinOsc.ar(SinOsc.ar([2, 3])*500+500)})
//freq range= 0-1000

Ndef(\sine).play
Ndef(\sine).fadeTime= 8
Ndef(\sine, {SinOsc.ar(SinOsc.ar([20, 30])*500+500)}) //still 0-100 but much faster
Ndef(\sine, {SinOsc.ar(SinOsc.ar([200, 300])*500+500)}) //faster still
Ndef(\sine, {SinOsc.ar(SinOsc.ar([200, 300.1])*1700+2500)}) //freq range 800 to 4200

//how to calculate the range...
[-1, 1]*1700+2500
[-1, 1]*500+500

//adding distortion with mouse control
Ndef(\sine, {SinOsc.ar(SinOsc.ar([1200, 300.1])*500+500, 0, MouseX.kr(1, 8)).tanh})
Ndef(\sine, {SinOsc.ar(SinOsc.ar([2200, 400.1])*600+500, 0, MouseX.kr(1, 8)).tanh})
Ndef(\sine, {SinOsc.ar(SinOsc.ar([3200, 500.1])*700+500, 0, MouseX.kr(1, 8)).tanh})
Ndef(\sine, {SinOsc.ar(SinOsc.ar([4200, 600.1])*800+500, 0, MouseX.kr(1, 8)).tanh})
Ndef(\sine, {SinOsc.ar(SinOsc.ar([5200, 700.1])*900+500, 0, MouseX.kr(1, 8)).tanh})
s.scope
Ndef(\sine).stop(3) //fade out and stop 3 seconds


//to print out the frequencies...
Ndef(\sine).fadeTime= 0
Ndef(\sine, {SinOsc.ar((SinOsc.ar([2, 3])*500+500).poll(20))})
Ndef(\sine).play
Ndef(\sine).stop
Ndef(\sine).clear //really stop and remove the sound
