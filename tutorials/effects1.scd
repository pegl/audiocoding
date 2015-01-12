//Some effects examples
//use the internal server with the scope
(
Server.default= s=Server.internal;
s.boot;
)

//make some source sound recipe
(
SynthDef(\impulse, {
Out.ar(0,Pan2.ar(Saw.ar(440,Decay2.ar(Impulse.ar(1),0.001,0.1,0.5)),0.0));
}).add;
SynthDef(\continuous, {
Out.ar(0,Pan2.ar(WhiteNoise.ar(0.1),0.0));
}).add;
)

//we'll need to be careful with execution order here, since the effects unit SynthDefs will be separate to the sound sources. See the previous Nodes file.
a = Group.basicNew(s,1); //get Group 1
x = Synth.head(a, \impulse);
s.scope
//Delay

(
SynthDef(\fxexampledelay, {arg delaytime=0.1;
var input, effect;
input=In.ar(0,2); //get two channels of input starting (and ending) on bus 0
effect= DelayN.ar(input, 1,delaytime); //max delay of one second
Out.ar(0,effect); //adds to bus 0
}).add;
)

x.free;
x = Synth.head(a, \impulse);
y= Synth.tail(a, \fxexampledelay);
y.free;
y= Synth.tail(a, \fxexampledelay, [\delaytime, 0.4]);
y.free;
//other UGens to explore:
DelayN, DelayL, DelayC, Delay1, Tap, MultiTap

//vibrato
// saw, DelayC
(
{
var source;
var fx;
source= Saw.ar(440,0.1);
fx= DelayC.ar(source, 0.01, SinOsc.ar(Rand(5,10),0,0.0025,0.0075));
fx
}.play
)

(
{
var source;
var fx;
source= Saw.ar(440,0.1);
fx= DelayN.ar(source, 0.01, SinOsc.ar(Rand(5,10),0,0.0025,0.0075));
fx
}.play
)

(
{
var source;
var fx;
source= Saw.ar(440,0.1);
fx= DelayL.ar(source, 0.01, SinOsc.ar(Rand(5,10),0,0.0025,0.0075));
fx
}.play
)

//chorusing
(
{
var source;
var fx;
var n=10;
source= EnvGen.ar(Env([0,1,0],[0.1,0.5]),Impulse.kr(2))*Saw.ar(440,0.5);
fx= Mix.fill(n, {
var maxdelaytime= rrand(0.01,0.03);
var half= maxdelaytime*0.5;
var quarter= maxdelaytime*0.25;
//%half+(quarter*LPF.ar(WhiteNoise.ar,rrand(1.0,10)))
DelayC.ar(source, maxdelaytime, LFNoise1.kr(Rand(5,10),0.01,0.02) )
});
fx
}.play
)


//Reverb
(
SynthDef(\fxexamplereverb, {arg delaytime=0.01, decaytime=1;
var input;
var numc,numa,temp;
input=In.ar(0,2); //get two channels of input starting (and ending) on bus 0
numc = 4; // number of comb delays
numa = 6; // number of allpass delays
// reverb predelay time :
temp = DelayN.ar(input, 0.048,0.048);
temp=Mix.fill(numc,{CombL.ar(temp,0.1,rrand(0.01, 0.1),5)});
// chain of 4 allpass delays on each of two channels (8 total) :
numa.do({ temp = AllpassN.ar(temp, 0.051, [rrand(0.01, 0.05),rrand(0.01, 0.05)], 1) });
// add original sound to reverb and play it :
Out.ar(0,(0.2*temp));
}).add;
)

y= Synth.tail(a, \fxexamplereverb);
y.free;


//readymade Reverbs in SC3.2 and later
FreeVerb
FreeVerb2
GVerb
//If you build your own reverbs, useful UGens are:
CombN, CombL, CombC
AllpassN, AllpassL, AllpassC
//and the delay reverbs above for early reflections

//simple feedback example, using the LocalIn and LocalOut UGens
(
{
var source = Impulse.ar(MouseX.kr(1,10));
var sound, feedback;
feedback = LocalIn.ar(1);	//one channel of feedback
sound = source + feedback;
LocalOut.ar(sound* MouseY.kr(0,0.9));  //feedback sound with some gain (<1 to stop feedback building up and overloading!).
sound;
}.play
)

//can take on pitch at reciprocal of control period, which is the default delay time for feedback. You can add further delay via Delay UGens for the feedback signal.
{SinOsc.ar(ControlDur.ir.reciprocal)*0.1}.play
//Phasing and Flanging
//phasing = play a signal back in combination with a phase shifted copy of itself (using an allpass filter); vary the delaytime under 20 msec
(
SynthDef(\fxexamplephasing, {arg freq=0.2;
var input, effect;
input=In.ar(0,2); //get two channels of input starting (and ending) on bus 0
effect= AllpassN.ar(input,0.02,SinOsc.kr(freq,0,0.01,0.01)); //max delay of 20msec
Out.ar(0,effect); //adds to bus 0 where original signal is already playing
}).add;
)
x.free
x= Synth.head(a, \continuous);
y= Synth.tail(a, \fxexamplephasing);
y.set(\freq, 0.1)
y.set(\freq, 1)
y.free
//flanging= play a signal back in combination with a delayed copy of itself; vary the delaytime around 10 msec
//flanging usually also involves some feedback, achieved here using LocalIn and LocalOut
(
SynthDef(\fxexampleflanging, {arg flangefreq=0.1, fdback=0.1;
var input, effect;
input=In.ar(0,2); //get two channels of input starting (and ending) on bus 0
input= input+ LocalIn.ar(2); //add some feedback
effect= DelayN.ar(input,0.02,SinOsc.kr(flangefreq,0,0.005,0.005)); //max delay of 20msec
LocalOut.ar(fdback*effect);
//LocalOut.ar(fdback*BPF.ar(effect,MouseX.kr(1000,10000),0.1)); //alternative with filter in the feedback loop
Out.ar(0,effect); //adds to bus 0 where original signal is already playing
}).add;
)
x.free
x= Synth.head(a, \continuous);
y= Synth.tail(a, \fxexampleflanging);
y.set(\flangefreq,0.1);
y.set(\fdback, 0.95);
y.free;

// bizarro!
z= Synth.tail(a, \fxexamplereverb);
z.free;

//Dynamics Processing
s.scope


//compress or expand the dynamic range (amplitude variation) of a signal
(
SynthDef(\fxexamplecompression, {arg gain=1.5, threshold=0.5;
var input, effect;
input=In.ar(0,2); //get two channels of input starting (and ending) on bus 0
effect= CompanderD.ar(gain*input,threshold,1,0.5);
ReplaceOut.ar(0,effect); //replaces bus 0 where original signal is already playing
}).add;
)
x.free
x= Synth.head(a, \impulse);
y= Synth.tail(a, \fxexamplecompression);
y.free;
y= Synth.tail(a, \fxexamplecompression,[\gain,2, \threshold,0.1]);
y.free;


//a limiter forces an absolute limit, and is very useful as a final stage in a patch to avoid overloading
(
SynthDef(\fxexamplelimiter, {arg gain=1;
var input, effect;
input=In.ar(0,2); //get two channels of input starting (and ending) on bus 0
effect= Limiter.ar(gain*input,0.99, 0.01);
ReplaceOut.ar(0,effect); //replaces bus 0 where original signal is already playing
}).add;
)
x.free
x= Synth.head(a, \impulse);
y= Synth.tail(a, \fxexamplelimiter);
y.set(\gain, 10) //careful with your ears!
y.free;


Compander, Normalizer, Limiter

//Distortion
Adding new components into a signal to make it richer; modulation side effects are examples of these.

//use a unary or binary operation (see the top of the AbstractFunctions or bottom of the Signal help files for some more)
{SinOsc.ar(440,0,0.5)}.play
{SinOsc.ar(440,0,0.5).distort}.play
{SinOsc.ar(440,0,0.5).cubed}.play //squared would put it an octave up; recall ring modulation and C+M, C-M
{SinOsc.ar(440,0,0.5).squared}.play //squared would put it an octave up; recall ring modulation and C+M, C-M
{SinOsc.ar(440,0,0.1).pow(MouseX.kr(0.1,1.0))}.scope
{SinOsc.ar(440,0,0.5).clip(-0.2,0.3)}.scope
{SinOsc.ar(440,0,0.1).round(2**(-7))}.scope //bit reduction to 7 bit signal
{Latch.ar(SinOsc.ar(440,0,0.1),Impulse.ar(MouseX.kr(100,20000)))}.scope //sr change; Latch allows crude resampling with aliasing (sample and hold signal values at assigned rate)

//pass through Shaper for waveshaping; each input value has an assigned output value in a lookup table
b = Buffer.alloc(s, 1024, 1);
// arbitrary transfer function, create the data at 1/2 buffer size + 1
t = Signal.fill(513, { |i| i.linlin(0.0, 512.0, -1.0, 1.0) });
// linear function
t.plot
// t.asWavetable will convert it to the official Wavetable format at twice the size
b.sendCollection(t.asWavetableNoWrap);  // may also use loadCollection here
// shaper has no effect because of the linear transfer function
(
{ var	sig = Shaper.ar(b, SinOsc.ar(440, 0, 0.4));
sig ! 2
}.scope;
)


// now for a twist
(
a = Signal.fill(256, { |i|
var t = i/255.0;
t + (0.1 * (max(t, 0.1) - 0.1) * sin(2pi * t * 80 + sin(2pi * 25.6 * t)))
})
);
a.plot
d = (a.copy.reverse.neg) ++(Signal[0])++ a;
d.plot
d.size	//must be buffer size/2 + 1, so 513 is fine
b.sendCollection(d.asWavetableNoWrap);  // may also use loadCollection here
b.plot // wavetable format!
// test shaper
(
{
Shaper.ar(
b,
SinOsc.ar(440, 0.5, Line.kr(0,0.9,6))
)
}.scope
)

Shaper can also be used to deliberately distort a sine in a controlled manner, as a synthesis method.
[Shaper]
Further examples of various effects, from distortion to delay effects, are in
[Tour_of_UGens]
