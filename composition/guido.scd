//         G3, A3, B3, C4, D4, E4, F4, G4, A4, B4, C5, D5, E5, F5, G5

// This is the reference tone, recorded at our operating level
~refTone = 440;

// speed
~bpm = 60;

~guido_pitches = [55, 57, 59, 60, 62, 64, 65, 67, 69, 71, 72, 74, 76, 77, 79];


(
/*
var generate_pitches;
generate_pitches = {
	arg offset;
	var pitch_list = [];
	var r = [0,2].choose;
	var n = (5 * r) + offset;
	pitch_list = pitch_list.add(~guido_pitches[n]);
	pitch_list;
};
*/


var guido;
guido = {
	arg text;
	var pitch_list = [],
	    offset = -1;
	i = 0;
	{i < text.size()}.while ({
		c = text.at(i);
		offset = -1;
		offset = case
		{c.asString() == "a"} {0}
		{c.asString() == "e"} {1}
		{c.asString() == "i"} {2}
		{c.asString() == "o"} {3}
		{c.asString() == "u"} {4}
		{true} {-1};

		if (offset != -1, {
			var r = [0,2].choose;
			var n = (5 * r) + offset;
			pitch_list = pitch_list.add(~guido_pitches[n]);
		});
		i = i + 1;

	});
	pitch_list.postln;

	Pbind(\dur, 0.4, \midinote, Pseq(pitch_list ++ [\rest], 1)).play;

};

a = guido.value("The beginning of the good news of Jesus Christ, the Son of God.");
a.postln;

);


if ("ABCDEF".at(3) == 'D', {true.postln});

"'" ++ "ABCDEF".at(3) ++ "'"

(
var c = "ABCDEF".at(3);
c.postln;
"D".postln;
c.asString() == "D" ;

)

// checking stuff
/*
(
var x = "a";
var offset;
//if (x.isNil == false, {offset = 99} );
if (x == "a", {offset = 33} );
offset.postln;
)


(
var a = 5;
if (a!=5, {a = 3});
a.postln;
)

*/