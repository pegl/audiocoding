// server side sequencing and triggers


//from rhythmic to audio rate
{Impulse.ar(MouseX.kr(1,100))}.play


//from rhythmic to audio rate; the Mouse is controlling the average number of clicks per second, they are not evenly spaced!

// dust
{Dust.ar(MouseX.kr(1,100))}.play


(
{
	[
		LFNoise0.ar(100),	//step
		LFNoise1.ar(100),	//linear interpolation
		LFNoise2.ar(100)	//quadratic interpolation
	]
}.plot(0.1)
)



// stepper
// Stepper.ar(trig,reset,min,max,step,resetval)

//plot it out
{ Stepper.ar(Impulse.ar(100), 0,1,10,1) }.plot(0.3,minval:0,maxval:10);

{ SinOsc.ar(Stepper.ar(Impulse.ar(10), 0,1,5,1)*100,0,0.1) }.play
{ SinOsc.ar(Stepper.ar(Impulse.ar(10), 0,1,10,1)*100,0,0.1) }.play
{ SinOsc.ar(Stepper.ar(Impulse.ar(10), 0,1,20,1)*100,0,0.1) }.play




//impulse frequency of 4 is 4 events per second
//kr used since slow rates and Select works with array data second input if kr but not ar
{ Saw.ar(Select.kr(Stepper.kr(Impulse.kr(4,0.1),0,0,7,1),[72,63,67,72,55,62,63,60].midicps),0.1) }.play
//speed control
{ Saw.ar(Select.kr(Stepper.kr(Impulse.kr(MouseX.kr(1,40),0.1),0,0,7,1),[75,63,67,72,55,62,63,60].midicps),0.1) }.play




//trigger at start of every sinusoidal cycle (where sine goes from negative to positive)

(

{

var source = SinOsc.ar(100);

//plot both original signal, and the trigger pattern

[source, Trig1.ar(source,0.001)]

}.plot(0.1)

)



// triggers

//trigger whenever crossing from negative to positive

(

{var source, trigger;


source= LFNoise0.ar(100);

trigger= Trig1.ar(source, 0.001); //0.001 is duration of trigger signal output


[source, trigger]

}.plot(0.2)

)

//trigger on all ups

(

{var source, trigger;


source= LFNoise0.ar(100);

trigger= Trig1.ar(source- Delay1.ar(source), 0.001); //0.001 is duration of trigger signal output


[source, trigger]

}.plot(0.2)

)

//trigger on any change

(

{var source, trigger;


source= LFNoise0.ar(100);

trigger= Trig1.ar(abs(source- Delay1.ar(source)), 0.001); //0.001 is duration of trigger signal output


[source, trigger]

}.plot(0.2)

)


// latch


//grab the sine's current value 100 times a second

{Latch.ar(SinOsc.ar(133), Impulse.ar(100))}.plot(0.5)

{Latch.ar(LFNoise2.ar(100), Impulse.ar(100))}.plot(0.1) //removes smoothing!

//could be used to create sequencing patterns!

{SinOsc.ar(300+(200*Latch.ar(SinOsc.ar(13.3), Impulse.ar(10))))*0.2}.play



{EnvGen.ar(Env([0,1,0],[0.01,0.01]),Impulse.kr(50))}.plot(0.1)


//If you set the envelope up carefully, this could be used like a more flexible Stepper
{EnvGen.ar(Env([0,1,0,0.5,-0.4],0.01!4),Impulse.kr(25))}.plot(0.1)

//slowed down by factor of 10 to be heard as held pitches
{SinOsc.ar(400*(1+EnvGen.ar(Env([0,1,0,0.5,-0.4],0.1!4,curve:\step),Impulse.kr(2.5))))}.play

//use midicps on output to get scales
{SinOsc.ar(EnvGen.ar(Env([63,63,60,55,60],0.125!4,curve:\step),Impulse.kr(2)).midicps)}.play

//the Impulse's rate acts like a beats per second here, and the envelope timings are in beats (0.125 per transition)








//percussive sound retriggered 3 times a second

(

{

var sound,env, trig;


trig= Impulse.ar(3); //trigger source


sound= Mix(LFPulse.ar(110*[1,5/2],0.0,0.5,0.2));


env= EnvGen.ar(Env.perc(0.02,0.2),trig); //with retriggering controlled by impulse


Pan2.ar(sound*env,0.0)

}.play

)


(

SynthDef(\mytriggersynth,{arg trig=0;

var env;


//must have additional starting level in envelope, else no nodes to go back to

env= EnvGen.ar(Env([2,2,1],[0.0,0.5],'exponential'),trig);


Out.ar(0,Pan2.ar(Resonz.ar(Saw.ar(env*440),1000,0.1),0.0))

},[\tr]).add

)


a= Synth(\mytriggersynth);


a.set(\trig, 1)	//if this wasn't an explicit trigger input, this wouldn't reset the envelope
a.set(\trig, 4)	//if this wasn't an explicit trigger input, this wouldn't reset the envelope


// Another triggering example: you could collect triggers from one signal and use them to spawn changes in another part of the UGen graph

//value of third frequency component is a new random number with each trigger

(

{

var sound,env, trig;


//> is itself a UGen when used in this context; it is outputting the result of comparing the LFNoise0 with the value 0 every sample!

trig= LFNoise0.ar(13)>0; //trigger source (might also use Dust, for example)


//TRand chooses a random number in its range when triggered

sound= Mix(LFPulse.ar(110*[1,5/2,TRand.ar(3.9,4.1,trig)],0.0,0.5,0.2));


env= EnvGen.ar(Env.perc(0.02,0.1),trig); //with retriggering controlled by impulse


Pan2.ar(sound*env,0.0)

}.play

)


// retrigger oscillators

//SyncSaw is hard sync
{ SyncSaw.ar(MouseX.kr(1,400), MouseY.kr(400,800), 0.1) }.play;

// custom hard sync oscillator using an EnvGen and a trigger source
{EnvGen.ar(Env([0,0,1,-1,0],MouseY.kr(0,1)*[0,128,256,128]/SampleRate.ir),Impulse.ar(MouseX.kr(10,300,'exponential')))}.play

(

{

var source;


source= LFNoise0.ar(10);


[

source,	//step

source.lag(0.1)	//step with lag of period; so only gets to target value at end of step

]

}.plot(1.0)

)

//portamento/glide

{Saw.ar((Stepper.ar(Impulse.ar(10),0,1,10,1)*200).lag(MouseX.kr(0.0,0.2)))}.play




//another example: Ringz is a resonant filter, exprange puts values from -1 to 1 to the desired range (100 to 2000) with an exponential mapping more fitting to human perception of frequency values

{Ringz.ar(Saw.ar(LFNoise0.kr(5).lag(0.1).exprange(100,2000),0.2), 1000, 0.01)}.play



//.round used to make frequency values round off to nearest 20 Hz (re-quantising the signal)

//perceived speed-ups due to interaction of slower lag and rounding of frequency

{Ringz.ar(Saw.ar(LFNoise0.kr(5).lag(MouseX.kr(0.01,0.3)).exprange(100,2000).round(20),0.2), 1000, 0.01)}.play




// The Decay UGen can also be used to put a smoothed tail on an impulse (or any signal)
(

{

Decay.ar(Impulse.ar(100),0.01)

}.plot(0.1)

)


// See also Decay2 for smoothing at attack and release.


(

{

Decay2.ar(Impulse.ar(100),0.005,0.01)

}.plot(0.1)

)



