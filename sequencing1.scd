{SinOsc.ar(440,0,0.1)}.scope	//Sine Oscillator goes on forever


{SinOsc.ar(440,0,Line.kr(0.0,0.1,0.25))}.scope	//One second for the sine to disappear entirely



{SinOsc.ar(440,0,Line.kr(0.1,0,1,doneAction:2))}.scope	//doneAction:2 causes the Synth to be terminated once the line generator gets to the end of its line



Env([1,0,1],[1,1]).plot

Env([0,1,0],[1.0,0.5]).plot


Env.linen(0.03,0.5,0.1).plot


Env.adsr(0.01, 0.5, 0.5, 0.1, 1.0, 0).plot  //attackTime, decayTime, sustainLevel, releaseTime, peakLevel, curve


Env.perc(0.05,0.5,1.0,0).plot //arguments attackTime, releaseTime, level, curve: good for percussive hit envelopes


Env([1,0],[1.0]).plot


{EnvGen.ar(Env([1,0],[1.0]))}.scope


{SinOsc.ar(440,0,0.1)*EnvGen.kr(Env([1,0],[1.0]))}.scope


Env([1500,20],[1.0]).plot
// bombs away
{Saw.ar(EnvGen.ar(Env([1500,0],[3.0])),0.1)}.scope
{Saw.ar(EnvGen.ar(Env([1500,0],[3.0])),0.1)}.play

{Saw.ar(EnvGen.ar(Env([1500,0],[2.0])),0.1)}.scope

//chirp
{Saw.ar(EnvGen.ar(Env([10000,0],[0.5])),EnvGen.ar(Env([0.1,0],[2.0])))}.scope

({
Saw.ar(
EnvGen.kr(Env([10000,20],[0.5])),  //frequency input
EnvGen.kr(Env([0.1,0],[2.0]))      //amplitude input
)
}.play
)


// FM
({

SinOsc.ar(

SinOsc.ar(10,0,10,440),

0.0,

EnvGen.kr(Env([0.5,0.0],[1.0]), doneAction:2)   //doneAction:2 appears again, the deallocation operation

)

}.scope

)


({Saw.ar(
	EnvGen.kr(
		Env([500,100],[1.0]),doneAction:2
	),0.1
)
}.scope)