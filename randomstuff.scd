"Hello world".postln;


{ [SinOsc.ar(440, 0, 0.2), SinOsc.ar(442, 0, 0.2)] }.play;


x = {SinOsc.ar};
y = x.play;
y.free;


{ SinOsc.ar(XLine.kr(2000, 200), 0, 0.5) }.play;

{ SinOsc.ar(SinOsc.ar(XLine.kr(1, 1000, 9), 0, 200, 800), 0, 0.25) }.play;

{ SinOsc.ar(800, SinOsc.ar(XLine.kr(1, 1000, 9), 0, 2pi), 0.25) }.play;

{ SinOsc.ar(800, SinOsc.ar(XLine.kr(1, 1000, 9), 0, 8pi), 0.25, 1) }.play;

(
z = {
	arg freq=440, amp = 1;
	var sig;
	sig = SinOsc.ar(freq) * amp;
}.play;
)

z.set(\freq, 330*2);
z.set(\freq, 330*1);
z.set(\freq, 115);
z.set(\amp, 1.0);

(
z = {
	arg noiseHz=8;
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(200,1000);
	amp = LFNoise1.kr(12).exprange(0.02, 1);
	sig = SinOsc.ar(freq) * amp;
}.play;
)

(
z = {
	arg noiseHz=8;
	var freq, amp, sig;
	freq = LFNoise0.kr(MouseX.kr(1,64)).exprange(200,1000);
	amp = LFNoise1.kr(12).exprange(0.02, 1);
	sig = SinOsc.ar(freq) * amp;
}.play;
)

z.set(\noiseHz, 4);
z.set(\noiseHz, exprand(4,64));
z.set(\noiseHz, MouseX.kr(4,64));

z.free;

2+ 2;
"ya gojunker".speak
{Pan2.ar(SinOsc.ar(440,0,0.1),0.0)}.play

{Pan2.ar(SinOsc.ar(MouseX.kr(440,880),0,0.1),0.0)}.play


// traffic sound
(
y = {
	var n = 11; //try changing me to 34, or 3, and then re-running...
	Resonz.ar(
		Mix.fill(n,{
			var freq=rrand(50,560.3);
			var numcps= rrand(2,20);
			Pan2.ar(Gendy1.ar(6.rand,6.rand,1.0.rand,1.0.rand,freq ,freq, 1.0.rand, 1.0.rand, numcps, SinOsc.kr(exprand(0.02,0.2), 0, numcps/2, numcps/2), 0.5/(n.sqrt)), 1.0.rand2)
		}),
		MouseX.kr(100,2000),
		MouseY.kr(0.01,1.0)

	);

}.play;

)

y.free;



{Pan2.ar(SinOsc.ar(440,0,0.1),0.0)}.play


(


if(4==4, {

if(3==3, {

"correct!".postln

});

});


)


2.postln;
Post << [2,3,4,5] <<nl;

(

var freq;


freq=rrand(300,600);


{SinOsc.ar(freq,0,0.1)}.play;

)


{SinOsc.ar(nil)}.play


(
{
	//var p, l,
	d = "";
	p = Pipe.new("ls -l", "r");
	l = p.getLine;
	while({l.notNil}, {d = d ++ l ++ "\n"; l = p.getLine; });
	p.close;
}
)


