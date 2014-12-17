

//make a SynthDef for a short slice of sound extracted from a buffer starting at chosen position

(

SynthDef(\shortsample,{arg buffer, dur=0.05, pos = 0.0, amp= 0.5, pan= 0.0;

var env, source;

source = PlayBuf.ar(1,buffer,startPos:pos*BufFrames.ir(buffer));

env = EnvGen.ar(Env([0,1,1,0],[0.01,dur,0.01]),doneAction:2);

Out.ar(0,Pan2.ar(env*source*amp,pan))

}).add

)


//need a sound file to grab bits of sound from

b = Buffer.read(s,Platform.resourceDir +/+"sounds/a11wlk01.wav");  


//test the SynthDef:

Synth(\shortsample, [\buffer,b,\pos,0.5,\dur,0.05])


//schedule Synths over time, increase duration with count

(

{

10.do{arg count; 

Synth(\shortsample, [\buffer,b,\pos,0.5,\dur,0.1*count]);

0.05.wait;

}

}.fork

)


//another example, with random selection of durations, and envelope control of starting pos

(

var grainspacing = 0.05; 

var env = Env([0,1,0.3,1.0],[2.0,2.5,0.5]); //use a language side envelope to vary position


{

100.do{arg count; 

var time = count*grainspacing;

Synth(\shortsample, [\buffer,b,\pos,env.at(time),\dur,rrand(0.01,0.05)]);

grainspacing.wait;

}

}.fork

)


//load another buffer

c = Buffer.read(s,Platform.resourceDir +/+"sounds/SinedPink.aiff"); 

Synth(\shortsample, [\buffer,c,\pos,0.5,\dur,0.05])

//granular cross fade; as increase density of grains from one, reduce from another (done in a basic probabilistic way here). Doesn't sound great with these two sounds, but could certainly be improved by exploring other sources and mixing strategies

(

var grainspacing = 0.05; 

var mixprobability = Env([0.0,1.0,0.0],[3.0,2.0]); //use a language side envelope to vary position


{

100.do{arg count; 

var time = count*grainspacing;

Synth(\shortsample, [\buffer,if(mixprobability.at(time).coin,c,b),\pos,time*0.1,\dur,grainspacing*4.0,\amp, 0.25]);

grainspacing.wait;

}

}.fork

)





