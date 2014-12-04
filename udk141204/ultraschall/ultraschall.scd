//use together with ultraschall.pde

s.boot;
SerialPort.listDevices;//check postwindow and note the name of the arduino - edit to match below

(
Ndef(\snd, {|cutoff= 500| BLowPass.ar(Saw.ar([99, 99]), cutoff.lag(0.5))}).play;//try different lag times
p= SerialPort("/dev/tty.usbserial-A101NAZY", 115200, crtscts: true);//edit to match your serial port name
CmdPeriod.doOnce({p.close});
Routine.run({
	inf.do{
		var distance= p.read.postln;
		Ndef(\snd).set(\cutoff, distance.linexp(0, 255, 5000, 50));//try different ranges
	};
});
)
