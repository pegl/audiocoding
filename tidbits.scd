
// command+shift+p to clear the post window
100.do({"Print this line over and over...".scramble.postln});


// recording
s.record;
// Make some cool sound
{Saw.ar(LFNoise0.kr([2, 3]).range(100, 2000), LFPulse.kr([4, 5]) * 0.1)}.play;
// Stop recording:
s.stopRecording;
// Optional: GUI with record button, volume control, mute button:
s.makeWindow;


Pbind(\degree, Pseries(0, 1, 30), \dur, 0.05).play;



s.boot;
SynthDescLib.global.read;

[0, 0b, 0, 2, 2b, 2, 4, 4b, 4] *4

Pbind(\degree, Pseq([0, 0b, 0, 2, 2b, 2, 4, 4b, 4],inf), \dur, 1/10).play
Pbind(\degree, Pseq([0, 0b, 1, 1b, 2, 2b, 3, 3b, 4, 4b, 5, 5b, 6, 6b, 7, 7],inf), \dur, 1/10).play
Pbind(\degree, Pseq([-1, -1b50, -1b, -1b150, 1, 1s50, 1s, 1s150], inf), \dur, 1/8).play


// zappa
Pbind(\degree, Pseq([\, 8, 4, 2, 5, 6, 3, 2, -1, 2, 3, 4, 8, 7, 5, 6, 2, 5, 8, 9, \, 8, 7, 6, 5, 4, 5, 2, 6, 7]-1)+[0,7], \dur, Pseq([1,1,1,1,3/4,1/4,1,1,1,1,3/4,1/4,3/4,1/4,3/4,1/4,2/3,2/3,2/ 3,2,1,1/4,1/4,1/4,1/4,1/4,1/4,1/4,1/4,1] * 0.5)).play;


// little big adventure intro, minus harmony
Pbind(\degree, Pseq([0,1,3,1,3,4,12,10]),\dur,Pseq([1/4,1/4,6/4,1/4,1/4,6/4,1,1])).play;

Pbind(\degree, 12).play
Pbind(\degree, 10).play

Pbind(\degree, Pseq([\, 8, 4, 2, 5, 6, 3, 2, -1, 2, 3, 4, 8, 7, 5, 6, 2, 5, 8, 9, \, 8, 7, 6, 5, 4, 5, 2, 6, 7]-1)+[0,7], \dur, Pseq([1,1,1,1,3/4,1/4,1,1,1,1,3/4,1/4,3/4,1/4,3/4,1/4,2/3,2/3,2/ 3,2,1,1/4,1/4,1/4,1/4,1/4,1/4,1/4,1/4,1] * 0.5)).play;