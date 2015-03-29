//use with sctomax2.maxpat
s.latency= 0.05;
s.boot;
n= NetAddr("127.0.0.1", 9876);

(  //reevaluate a few times
Pdef(\tomax, Pbind(
	\dur, 0.2,
	\degree, Pseq([0, 1, 5, 4, 2, 3, 2, 1], inf),
	\stepsPerOctave, 11,
	\amp, Pseq({1.0.linrand*2.rand}!16, inf),
	\mod, Pseq({100.rand*2.rand}!12, inf),
	\do, Pfunc({|e| e.use{n.sendMsg(\data, ~freq.value, ~amp.value, ~mod.value)}}) //just less to type
)).play
)