{Saw.ar((Stepper.ar(Impulse.ar(10),0,1,10,1)*200).lag(MouseX.kr(0.0,0.2)))}.play

//One fork appears inside the other:

(

{


4.do{arg j;

//nested sequence, create another fork

{

8.do{arg i;

Synth(\event, [\freq,(48+(i*3.3)+j).midicps,\amp, (1.0-(i/8))]);

0.5.wait;

}

}.fork;

4.0.wait; //outer fork must wait for inner fork to do its work

}

}.fork;

)





(

//two quickly created sounds; they click because of the line generators being quite crude

SynthDef(\sound1,{arg freq=440,amp=0.1;

var sound;


sound= LPF.ar(Saw.ar(freq),2000)*Line.kr(1,0,0.1, doneAction:2)*amp;

Out.ar(0,Pan2.ar(sound,0.0))

}).add;


SynthDef(\sound2,{arg freq=440,amp=0.1;

var sound;


sound= HPF.ar(LFPar.ar(freq),1000)*Line.kr(0,1,0.5, doneAction:2)*amp;

Out.ar(0,Pan2.ar(sound,0.0))

}).add;

)


//test SynthDefs

Synth(\sound1)


Synth(\sound2)


//nested scheduling; each bar has a different length, and uses one of two sounds

(

var barlengths= [4.0,3.5,5.0];
var t= TempoClock(2.5);

{
	inf.do{|i|
		var barnow= barlengths.wrapAt(i);
		"new bar".postln;
		{

			var whichsound;
			whichsound= [\sound1,\sound2].choose;
			((barnow/0.25)-2).floor.do{|j|
				Synth(whichsound,[\freq, 300+(100*j),\amp,0.3]);
				0.25.wait;
			};
		}.fork(t);
		barnow.wait;
	}
}.fork(t)
)

//another example

(
var t= TempoClock(2);
{
	4.do{
		"bar".postln;
		{
			[1.0,1.0,0.5,0.5,0.5,0.25,0.25].do{|val| Synth(\event, [\freq,rrand(48,84).midicps,\amp, rrand(0.0,0.3)]); "event".postln; val.wait;};
		}.fork(t);
		4.0.wait;
	}
}.fork(t)
)








//demonstration of a simple structure for a piece where different sections appear in a desired order

//note if you were extending this to some large-scale form with sectional repeats, that repeated materials could be put into functions, to avoid repetition through encapsulation.



(



{



SynthDef(\bleep,{ arg out=0, note=60, amp=0.5, pan=0.0;

var freq, env;

freq = note.midicps;

env = EnvGen.ar(

Env([0,1,1,0],[0.01, 0.1, 0.2]),

levelScale:amp,

doneAction:2

);

Out.ar(out,

Pan2.ar(Blip.ar(freq) * env, pan)

)

}).add;





SynthDef(\bleep2,{ arg out=0, note=60, amp=0.5, pan=0.0;

var freq, env;

freq = note.midicps;

env = EnvGen.ar(

Env([0,1,1,0],[0.1, 0.1, 0.02]),

levelScale:amp,

doneAction:2

);

Out.ar(out,

Pan2.ar(Blip.ar(freq, Line.kr(10,1,1)) * env, pan)

)

}).add;



SynthDef(\mlpitch,{

var soundin, amp, freq, hasFreq;



soundin= SoundIn.ar;



amp= Amplitude.kr(soundin);

#freq, hasFreq= Pitch.kr(soundin);



Out.ar(0,amp*SinOsc.ar(freq))

}).add;



s.sync;  //won't proceed until server confirms it has the SynthDefs ready



//make buffers;

//s.sync;



//three sections





//1.



10.do{|i|



Synth([\bleep, \bleep2].choose);



0.15.wait;

};



1.0.wait;

//2.



a= Synth(\mlpitch);



1.0.wait;



a.free;



1.0.wait;

//3. two sequences of actions happen simultaneously (note no gap between the two)



{

100.do{|i|



Synth([\bleep, \bleep2].choose,[\note, ([60,62,64,66,67,69,71]-12).choose]);



rrand(0.05,0.15).wait;

};



}.fork;

//though process has just been forked off, straight to do further things in this thread too!



100.do{|i|



Synth([\bleep, \bleep2].choose,[\note, [60,62,64,66,67,69,71].choose]);



0.1.wait;

};





}.fork;

)



































