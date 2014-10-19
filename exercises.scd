

// a) Make a function with argument n which returns an array of n random numbers between 1.0 and 10.0. The numbers must have been sorted into decreasing order (hint: try [1,4,3].sort)

(
{arg randn = 10;
z = Array.new(randn);
	(1..randn).do({ arg item; z.add(rand(1.0, 10.0));});
z.sort;
z.postln;
}.value(3)
)


// some notes on looping below


(
Routine(
	{ var i=10;
		while { i > 0 }
		{
			i.yield; i = i - 5.0.rand
		}
	}
).do(
	{ arg item; item.postln }
);
)


[ 1, 2, "abc", (3@4) ].do({ arg item, i; [i, item].postln; });

5.do({ arg item; item.postln }); // iterates from zero to four

"you".do({ arg item; item.postln }); // a String is a collection of characters

'they'.do({ arg item; item.postln }); // a Symbol is a singular item

(8..20).do({ arg item; item.postln }); // iterates from eight to twenty

(8,10..20).do({ arg item; item.postln }); // iterates from eight to twenty, with stepsize two

(8,11..20).do({ arg item; item.postln }); // iterates from eight to twenty, with stepsize three

Routine({ var i=10; while { i > 0 } { i.yield; i = i - 5.0.rand } }).do({ arg item; item.postln });
;

/*
b) Imagine you have to generate a rhythm for one 4/4 bar (i.e. 4 beats). Write a short program which selects random successive numbers from [1.0, 0.5, 0.25] to fill up one bar's worth of beats. How do you deal with going past the end of the bar? (hint: what does .choose do on an array?)
*/

(
var barFunc;
barFunc =
{
	arg limit = 4;
	var i = 0.0;
	while { i < limit}
	{
		var beat = choose([1.0, 0.5, 0.25]);
		//	i.yield;
		"total".postln;
		i.postln;
		"next beat".postln;
		beat.postln;

		i = i + beat;
	}
};
barFunc.value(4);
)


(
var barFunc;
barFunc =
{
	arg limit = 4;
	var i = 0.0;
	var beatCount = 0;
	var final = "";
	while { i < limit}
	{
		var beat = 0.0;
		var beats = [0.25];
		if ((limit - i) >= 1.0, { beats.add(1.0)}, {
			if ((limit - i) >= 0.5, { beats = beats.add(0.5)
			});
		});
/*		switch (limit - i >= 1.0,
			true, {beats.add(1.0)}
		);
		switch (limit - i >= 0.5,
			true, {beats.add(0.5)}
		);*/

		beat = choose(beats);
		//	i.yield;
		"total".postln;
		i.postln;
		"next beat".postln;
		beat.postln;

		i = i + beat;
		beatCount = beatCount + 1;
	};

	"Final beat count".scatArgs(i).postln;
	"Note count".scatArgs(beatCount);

};
barFunc.value(4);
)

barFunc;

"These are some args: ".scatArgs(\fish, SinOsc.ar, {4 + 3}).postln;

/*
c) Rewrite the following code as a series of nested ifs


i.e. if(condition1, {}, {if (condition2, etc.)})
*/

(
var z;
z = 4.rand;
switch (z,
	0, { \outcome1 },
	1, { \outcome2 },
	2, { \outcome3 },
	3, { \outcome4 }
).postln;
)

// rewritten
(
var z;
var out;
z = 4.rand;
if (z == 0,{ out = \outcome1},{
	if (z == 1,{ out = \outcome2},{
		if (z == 2,{ out = \outcome3},{
			if (z == 3,{ out = \outcome4
			});
		});
	});
});
)


// Now also rewrite it as a choice amongst elements of an array.

\outcome ++ choose([0,1,2,3]);


/*
d) Compare each of these lines by running them one at a time:


2.rand


2.0.rand


2.rand2


2.0.rand2


rrand(2,4)


rrand(2.0,4.0)


exprand(1.0,10.0)



Write a program which plots ten outputs from any one of these lines in a row. Advanced: actually allow user selection (via a variable for instance) of which line gets used to generate the ten random numbers.


*/

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
		i.postln;
	};
	outputs;
};
plotArray = barFunc.value(2,10);
plotArray;
)
