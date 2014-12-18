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

extra
--
how to connect a 12V dc motor or 12V lamp(s).

```cpp
//arduino code for testing mosfet_dcmotor
void setup() {
    pinMode(9, OUTPUT);
}
void loop() {
    digitalWrite(9, 1);
    delay(2000);
    digitalWrite(9, 0);
    delay(3000);
}
```

![mosfet_dcmotor](mosfet_dcmotor.png?raw=true "mosfet_dcmotor")

![mosfet_dcmotor_schem](mosfet_dcmotor_schem.png?raw=true "mosfet_dcmotor_schem")

note that the mosfet might need a heat sink.

the 'flyback' diode can be an 1N4001, 1N4007 or anything in between.

use thick wires and short for the 12V. don't connect it on a breadboard if you need to draw more than maybe 1A - solder the components on a protoboard instead.
