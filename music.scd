(
var syn, sound;
syn = SynthDef.new("example3",
{
	arg out = 0, freq = 440, amp = 0.2, dur = 2;
		var sin, env_gen, env;
	env = Env.triangle(dur, amp);
	env_gen = EnvGen.kr(env);
	sin = SinOsc.ar(freq, mul: env_gen);
	Out.ar(out, sin);
});
syn.load(s);
)

Synth.new("example3");

(
var syn, sound;
syn = SynthDef.new("example3",
{
	arg out = 0, freq = 440, amp = 0.2, dur = 2;
		var sin, env_gen, env;
	env = Env.perc(dur, amp);
	env_gen = EnvGen.kr(env);
	sin = SyncSaw.ar(freq, mul: env_gen);
	Out.ar(out, sin);
});
syn.load(s);
)

Synth.new("example3");

(
var syn, sound;
syn = SynthDef.new("example3",
{
	arg out = 0, freq = 440, amp = 0.2, dur = 2, ratio = 1, detune = 10;
	var sin, env_gen, env, pitch;
	env = Env.perc(dur, amp);
	env_gen = EnvGen.kr(env);
	pitch = (freq * ratio) + detune;
	sin = SinOsc.ar(pitch, mul: env_gen);
	Out.ar(out, sin);
});
syn.load(s);
)

// y=LFNoise0;a=y.ar(8)
// MoogFF.ar(Saw.ar(y.ar(4,333,666)),a*XLine.ar(1,39,99,99,0,2))

// experimental
(
var syn, sound;
syn = SynthDef.new("example3",
{
	arg out = 0, freq = 440, amp = 0.2, dur = 2, ratio = 1, detune = 10;
	var sin, env_gen, env, pitch;
	env = Env.perc(dur, amp);
	env_gen = EnvGen.kr(env);
	pitch = (freq * ratio) + detune;
	sin = SinOsc.ar(pitch, mul: env_gen);
	//sin = MoogFF.ar(Saw.ar(y.ar(4,333,666)),a*XLine.ar(1,39,99,99,0,2));
	Out.ar(out, sin);
});
syn.load(s);
)

Synth.new("example3");

play{y=LFNoise0; a=y.ar(8); MoogFF.ar(Saw.ar(y.ar(4,333,666)),a*XLine.ar(1,39,99,99,0,2))};

LFNoise0.plot;

// now do this again, but select pitch multipliers that are in harmony
(
var func, arr;
func = { arg ratio_arr, baseFreq = 440, detune = 10, note_count = 1;
	var pitch_multiplier;
	var note_length;
	var arr_size;
	arr_size = ratio_arr.size;
	note_length = choose([1,2,3,4]);
	Routine.new({
		note_count.do({
			arg note_count, ratio, index;
			note_count = note_count % arr_size;
			pitch_multiplier = ratio_arr.at(note_count);
			//pitch = (pitch * baseFreq) + detune;
			//("Ratio: " ++ ratio ++ " Pitch: " ++ pitch).postln;
			Synth.new("example3", [\ratio, pitch_multiplier, \detune, detune, \dur, note_length]);
			pitch_multiplier.postln;
			note_length.postln;
			note_length.wait;
			note_length = choose([1,2,3,4]);
		});
	});
};

arr = [ 1/1, 3/2, 4/3, 9/8, 16/9, 5/4, 8/5];
func.value(arr.scramble, 440, 10, 100).play;

)

// again with a pulse
// varying pitch, pause and note duration
(
var func, arr, waitArr, durArr;
func = { arg ratio_arr, waitArr, durArr, baseFreq = 440, detune = 10, note_count = 1;
	var pitch_multiplier;
	var note_length;
	var arr_size;
	arr_size = ratio_arr.size;
	note_length = choose([1,2,3,4]);

	play{x=SinOsc;y=LFNoise0;a=y.ar(8);x.ar(Pulse.ar(2)*24)};
	Routine.new({
		var timeNow = TempoClock.default.beats;
		"Time is now: ".post; timeNow.postln;
		note_count.do({
			arg note_count, ratio, index;
			note_count = note_count % arr_size;
			pitch_multiplier = ratio_arr.at(note_count);
			//pitch = (pitch * baseFreq) + detune;
			//("Ratio: " ++ ratio ++ " Pitch: " ++ pitch).postln;
			Synth.new("example3", [\ratio, pitch_multiplier, \detune, detune, \dur, note_length]);
			pitch_multiplier.postln;
			note_length.postln;
			waitArr.at(note_count).wait;
			note_length = choose([1,2,3,4]);
			note_length = durArr.at(note_count)
		});
		"Time is later: ".post; thisThread.clock.beats.postln;
	});
};

arr = [ 1/1, 3/2, 4/3, 9/8, 16/9, 5/4, 8/5 ];
waitArr = [ 1/1, 3/2, 4/3, 9/8, 16/9, 5/4, 8/5 ];
durArr = [ 1/1, 3/2, 4/3, 9/8, 16/9, 5/4, 8/5 ];

func.value(arr.scramble, waitArr.scramble, durArr.scramble, 440, 10, 10).play;

)

354742.16522694 - 354717.16522694

(
var timeNow = TempoClock.default.beats;
"Time is now: ".post; timeNow.postln;
"Scheduling for: ".post; (timeNow + 5).postln;
TempoClock.default.schedAbs(timeNow + 5,
	{ "Time is later: ".post; (thisThread.clock.beats - timeNow) ++ "sec".postln; nil });
)

"1" ++ "@"

1+"@"

(
var timeNow;
TempoClock.default.tempo = 2;    // 2 beats/sec, or 120 BPM
timeNow = TempoClock.default.beats;
"Time is now: ".post; timeNow.postln;
"Scheduling for: ".post; (timeNow + 5).postln;
TempoClock.default.schedAbs(timeNow + 5,
    { "Time is later: ".post; thisThread.clock.beats.postln; nil });
TempoClock.default.tempo = 1;
)


(
var plotArray;
var barFunc;
barFunc =
{
	arg type = 0, limit = 10;
	var outputs = Array.new(limit);
	var i = 0, val = 0;
	while { i < limit}
	{
		switch (type,
			0, { val = 2.rand },
			1, { val = 2.0.rand },
			2, { val = 2.rand2 },
			3, { val = 2.0.rand2 },
			4, { val = rrand(2,4) },
			5, { val = rrand(2.0,4.0) },
			6, { val = exprand(1.0,10.0) }
		);
		outputs.add(val);
		i = i + 1;
		//i.postln;
	};
	outputs;
};
plotArray = barFunc.value(2,10);
//plotArray;
)


play{x=SinOsc;y=LFNoise0;a=y.ar(8);(x.ar(Pulse.ar(1)*24)+x.ar(90+(a*90))+MoogFF.ar(Saw.ar(y.ar(4,333,666)),a*XLine.ar(1,39,99,99,0,2)))!2/3}



(
var arr, arr2, arr2_index;
arr = [1, 2, 3];arr2 = [3, 4, 5, 6];
arr2_index = 0;
2.do({
arr.do({ arg item;
("arr " ++ item).postln;
("\t arr2 " ++ arr2.wrapAt(arr2_index)).postln;
arr2_index = arr2_index + 1;
});
});
)


f={|t|Pbind(\note,Pseq([-1,1,6,8,9,1,-1,8,6,1,9,8]+5,319),\dur,t)};Ptpar([0,f.(1/6),12,f.(0.1672)],1).play//#supercollider

f={|t|Pbind(\note,Pseq([-1,1,6,8,9,1,-1,8,6,1,9,8]+5,319),\dur,t);};

{|t|Pbind(\note,Pseq([-1,1,6,8,9,1,-1,8,6,1,9,8]+5,319),\dur,t);}