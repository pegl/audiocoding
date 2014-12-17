SynthDef(\sine, {Out.ar(0,SinOsc.ar(Rand(440,880),0,0.1))}).add;

Synth(\sine);

a=Synth(\sine);
b=Synth(\sine);
c=Synth(\sine);

a.free;

b.free;

c.free;


SynthDef("aaa",{Out.ar(0,SinOsc.ar(440,0,0.1))}).add
Synth("aaa"); //now this
Synth(\aaa);

Server.defaults
s.serverRunning


SynthDef(\saw, {Out.ar(0,Saw.ar(Rand(440,880),0.1))}).play(s);

//.add - just sends the SynthDef to the synthesis server at this moment, doesn't place any file on disk
//.writeDefFile - just writes the SynthDef into a file on disk, doesn't load it to the synthesis server.
// .store - writes the file on disk, so it's loaded every time you start the synthesis server from now on, and also sends it immediately so it's available right away.



SynthDef(\sine,{arg freq=440, amp=0.1; Out.ar(0,SinOsc.ar(freq,0,amp))}).add; //added frequency and amp arguments to recipe; make sure they have default values (e.g. freq=440)
Synth("sine"); //now this accepts the defaults
Synth("sine",[\freq,880]); //this makes another Synth from the recipe an octave up, by being explicit about the frequency argument to the SynthDef
Synth("sine",[\freq,440]); //this makes another Synth from the recipe an octave up, by being explicit about the frequency argument to the SynthDef

a=Synth(\sine);
b=Synth(\sine,[\freq,550]);
c=Synth(\sine,[\freq,660, \amp, 0.5]);
c=Synth(\sine,[\freq,880, \amp, 0.5]);

a.free

c.set(\freq, 440);
b.set(\amp, 0.3, \freq, 100)

(
SynthDef(\bombsaway,{arg input1= 1500; //any arguments go here, make sure they have default values
	//some code for UGens - the sort of thing that went inside {}.play before
	// var finaloutput=Saw.ar(EnvGen.ar(Env([input1,0],[3.0])),0.1);
	Out.ar(0, Saw.ar(EnvGen.ar(Env([1500,0],[3.0])),0.1)) //finaloutput is the final result UGen you want to hear
}).add
)

({arg input1 = 1500; Saw.ar(EnvGen.ar(Env([1500,0],[3.0])),0.1)}.play)

(
SynthDef(\bombsaway2,{arg input1= 1500; //any arguments go here, make sure they have default values
	//some code for UGens - the sort of thing that went inside {}.play before
	// var finaloutput=Saw.ar(EnvGen.ar(Env([input1,0],[3.0])),0.1);
	Out.ar(0, Saw.ar(EnvGen.ar(Env([1500,0],[3.0])),0.1)) //finaloutput is the final result UGen you want to hear
}).add;
)

a = Synth(\bombsaway2, [\input1, 440]);


// recovering SynthDefs and SynthDesc

SynthDescLib.global.synthDescs[\sine].def.func.postcs //post code used to make SynthDef for \sine (assumes you added the \sine SynthDef above)



SynthDescLib.global.browse; // browse the properties of available SynthDescs in the system



//iterate through all available, posting any known function code

(

SynthDescLib.global.synthDescs.do { |desc|

if(desc.def.notNil) {

"\nSynthDef %\n".postf(desc.name.asCompileString);

desc.def.func.postcs;

};

};

)