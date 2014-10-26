// SynthDef for the first and second voice
(
SynthDef(\populous, { |out, amp=0.3, freq=440|
	var snd;
	snd = LFPulse.ar(freq)!2;
	snd = snd * EnvGen.ar(Env.linen(0.001, 0.1, 0.03), doneAction:2);
	OffsetOut.ar(WhiteNoise.ar, snd*amp);
//	LPF.ar(out, snd*amp);
}).add;
)

Synth.new(\populous);
