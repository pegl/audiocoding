{SinOsc.ar(mul:0.1)}.scope

{SinOsc.ar(mul:2.0)}.scope

{SinOsc.ar(mul:MouseY.kr(1.0,0.1))}.scope

{SinOsc.ar(mul:0.1, add:MouseY.kr(0.9,-0.9))}.scope


{SinOsc.ar(mul:MouseX.kr(0.1,1.0), add:MouseY.kr(0.9,-0.9))}.scope


(

{

//cutoff values need to be sensible frequencies in Hz; here sine output turned from -1 to 1 into 2000+-1700

var cutoff = SinOsc.ar(1,mul:MouseX.kr(0.0,1700.0), add:2000.0);

//var cutoff = SinOsc.ar(1)*1700.0 + 2000.0;  //same thing

LPF.ar(WhiteNoise.ar,freq:cutoff);

}.scope

)

(

{

//cutoff values need to be sensible frequencies in Hz; here sine output turned from -1 to 1 into 2000+-1700

//var cutoff = SinOsc.ar(1,mul:MouseX.kr(0.0,1700.0), add:2000.0);

var cutoff = SinOsc.ar(1)*1700.0 + 2000.0;  //same thing

LPF.ar(WhiteNoise.ar,freq:cutoff);

}.scope

)



{SinOsc.ar(SinOsc.ar(3,mul:MouseX.kr(0.0,1700.0),add:440),0,0.1)}.scope


a = {arg freq=440, amp=1; SinOsc.ar(MouseX.kr(0,880))*amp}.play
a.set(\freq,rrand(220,440), \amp, rrand(0.05,0.2))
a.set(\freq,MouseX.kr(220,440), \amp, rrand(0.05,0.2))