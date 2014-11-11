/*
 * Let's create musical scales! woohoo, yeah woohoo.
 *
 */

(

// This is the reference tone, recorded at our operating level
~refTone = 440;

// speed
~bpm = 60;

var func;
func = {
	arg v, k;
	var res = ~refTone * (2 ** ((v+k) / 12));
};

// define the synth
SynthDef(\sine,{arg freq=~refTone, amp=0.1, dur=0.5; Out.ar(0,SinOsc.ar(freq,0,amp,dur))}).add; //added frequency and amp arguments to recipe; make sure they

Synth("sine",[\freq,~refTone, \amp, 0.5]);
//c=Synth(\sine,[\freq,880, \amp, 0.5]);


// SynthDef for the first and second voice
SynthDef(\mario, { |out, amp=0.3, freq=440|
	var snd;
	snd = LFPulse.ar(freq)!2;
	snd = snd * EnvGen.ar(Env.linen(0.001, 0.1, 0.03), doneAction:2);
	OffsetOut.ar(out, snd*amp);
}).add;


);






// this calculates the equal tempered scale for octave v and interval k
(

var temperedScale;
var delta;

SynthDef(\sine,{arg freq=~refTone, amp=0.1, dur=0.5; Out.ar(0,SinOsc.ar(freq,0,amp,dur))}).add;
temperedScale = {
	arg v, k;

	var res = 440 * (2 ** ((v+k) / 12));
	res.postln;

	Synth("sine",[\freq,res, \amp, 0.5, \sustain, 1 * 0.8]);

};

// A, A#, B  ... A^
for(0,12, {
	arg i;

	delta = rrand(1, 3) * 0.5;
	temperedScale.value(0,i);
	delta.postln;
	delta.yield;
});

)


// random tones
(
SynthDef(\singrain, { |freq = 440, amp = 0.2, sustain = 1|
    var sig;
    sig = SinOsc.ar(freq, 0, amp) * EnvGen.kr(Env.perc(0.01, sustain), doneAction: 2);
    Out.ar(0, sig ! 2);    // sig ! 2 is the same as [sig, sig]
}).add;

r = Routine({
    var delta;
    loop {
        delta = rrand(1, 3) * 0.5;
        Synth(\singrain, [freq: exprand(200, 800), amp: rrand(0.1, 0.5), sustain: delta * 0.8]);
        delta.yield;
    }
});
)

r.play;
r.stop;


Scale.major.ratios

// c major scale
(
t = Task({
    loop {
        [60, 62, 64, 65, 67, 69, 71, 72].do({ |midi|
            Synth(\singrain, [freq: midi.midicps, amp: 0.2, sustain: 0.1]);
			midi.midicps.postln;
            0.125.wait;
        });
    }
}).play;
)
// probably stops in the middle of the scale
t.stop;
t.play;    // should pick up with the next note
t.stop;



a = Scale.major;
a.degrees;        // [ 0, 2, 4, 5, 7, 9, 11 ]
a.semitones;        // [ 0, 2, 4, 5, 7, 9, 11 ]
a.cents;        // [ 0, 200, 300, 500, 700, 900, 1100 ]
a.ratios;        // [ 1, 1.1224620483089, 1.2599210498937, 1.3348398541685, etc. ]


// woohoo let's play the major scale and pretend it's on the piano
(
Pbind(\scale, a, \degree, Pseq((0..14) ++ (13..0) ++ [\rest], 1), \dur, 0.25).play;
Pbind(\scale, a, \degree, Pseq((0..-14) ++ (-13..0) ++ [\rest], 1), \dur, 0.25).play;
)

// can also set tuning at creation time
b = Scale.ionian(\pythagorean);
b.cents;
b.ratios;
// change tuning
// Tuning.directory
b.tuning_(\just);
b.tuning_(\et12);
a.tuning
Pbind(\scale, b, \degree, Pseq((0..7) ++ (6..0) ++ [\rest], 1), \dur, 0.25).play;
(
Pbind(\scale, b, \degree, Pseq((0..7) ++ (6..0) ++ [\rest], 1), \dur, 0.25).play;
Pbind(\scale, b, \degree, Pseq((7..14) ++ (13..7) ++ [\rest], 1), \dur, 0.25).play;
Pbind(\scale, b, \degree, Pseq((14..21) ++ (20..14) ++ [\rest], 1), \dur, 0.25).play;
Pbind(\scale, b, \degree, Pseq((0..-7) ++ (-6..0) ++ [\rest], 1), \dur, 0.25).play;
)

c = Scale.major;
c.tuning_(\partch);
c.ratios;
Pbind(\scale, c, \degree, Pseq((0..7) ++ (6..0) ++ [\rest], 1), \dur, 0.25).play;


// random scale
(
a = Scale.choose(7, 12);
[a.name, a.tuning.name].postln;
Pbind(\scale, a, \degree, Pseq((0..7) ++ (6..0) ++ [\rest], 1), \dur, 0.25).play;
)


// tuning has its own class
t = Tuning.werckmeister;

a = Scale.lydian(t);

q.stop;

// getting info
a.name;
a.degrees;
a.semitones;
a.ratios;

a.tuning.name;
a.tuning.semitones;
a.tuning.ratios;

// for ascending/descending scales, use Pavaroh
(
Pbind(\note, Pavaroh(
    Pseq([0, 1, 2, 3, 4, 5, 6, 7, 6, 5, 4, 3, 2, 1, 0, \rest], 2),
        Scale.melodicMinor,
        Scale.melodicMinorDesc
    ),
    \dur, 0.25
).play;
)

// note that the root pitch is not stored in the Scale (which should arguably be called a Mode for that reason)
// instead you supply it at play time:

// key of A
(
Pbind(
    \degree, Pseq((0..7), inf), // your melody goes here
    \scale, Scale.major, // your scale goes here
    \root, -3 // semitones relative to 60.midicps, so this is A
).play;

Pbind(
    \degree, Pseq((0..-7), inf), // your melody goes here
    \scale, Scale.major, // your scale goes here
    \root, -3 // semitones relative to 60.midicps, so this is A
).play;
)

(
var a,b;
a = Pseq((0..7), inf);
b = a.asStream;
7.do({b.asStream.next.postln;})
)



// play any standard 7 note scale
// @param reference_note (note)
// @param octave_count (1+)
// @param direction (up,down,both)

// extend human readable music note e.g A,B,C..G with # sharp b flat
(
var func, task;
func = {
	arg ref_note, octave_cnt, dir;
	var upper = 7 * octave_cnt;
	var lower = -7 * octave_cnt;
	Task({
		a = Scale.major;
		switch (dir,
			"both", {
		Ppar([
			Pbind(\scale, a, \degree, Pseq((0..upper) ++ (upper-1..0) ++ [\rest], 1), \dur, 0.25, \root, ref_note), //.play
			Pbind(\scale, a, \degree, Pseq((0..lower) ++ (lower+1..0) ++ [\rest], 1), \dur, 0.25, \root, ref_note)
		]).play},
			"up", {
			Pbind(\scale, a, \degree, Pseq((0..upper) ++ (upper-1..0) ++ [\rest], 1), \dur, 0.25, \root, ref_note).play
			},
			"down", {
			Pbind(\scale, a, \degree, Pseq((0..lower) ++ (lower+1..0) ++ [\rest], 1), \dur, 0.25, \root, ref_note).play
			}
		)
	});

};
task = func.value(1,2,"both");
task.play;
)


