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
