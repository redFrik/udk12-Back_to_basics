141218
======

arduino and supercollider

simple
--
upload this sketch to your arduino. it will read A0, scale down from 0-1023 to 0-255 and send this as a raw byte value over serial.
```cpp
void setup() {
    Serial.begin(57600);
}
void loop() {
    int val= analogRead(A0);  //0-1023 (10bit)
    Serial.write(val/4);  //scaled down to 0-255 (8bit)
    delay(20);  //try to lower or remove for quicker update rate
}
```

(the above is the same example as last week)

then run this code in supercollider. it will try to connect to your arduino serial port (edit the port name to match your arduino port). 
```
s.boot;

(
var port;
SerialPort.listDevices.postln; //post available ports
port= SerialPort("/dev/tty.usbserial-A101NAZV", 57600, crtscts: true); //edit to match your arduino portname
Ndef(\snd, {|freq= 400| SinOsc.ar(freq*[1, 1.01], 0, 0.4)}).play;
Routine.run({
    inf.do{
        var val;
        val= port.read;
        val.postln; //debug
        Ndef(\snd).set(\freq, val.linexp(0, 255, 300, 3000));
    };
});
CmdPeriod.doOnce({port.close});
)
```

it should sound and post values. stop it with cmd+period.
