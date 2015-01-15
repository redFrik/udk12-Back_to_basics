//use together with osc_sc_to_processing_example.pde
(
n= NetAddr("127.0.0.1", 9876);//localhost ip and port number
OSCFunc({|msg|
	msg.postln;
	n.sendMsg(\abc, msg[3]);//send only pitch to processing
}, "/fre");
Ndef(\fretrk, {
    var pitch= Pitch.kr(SoundIn.ar)[0].lag(0.3);    //0.3 is smooth factor
    SendReply.kr(Impulse.kr(60), "/fre", pitch);    //60 is updaterate
    SinOsc.ar(pitch, 0, 0.5);
}).play;
)
