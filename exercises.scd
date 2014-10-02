

// a) Make a function with argument n which returns an array of n random numbers between 1.0 and 10.0. The numbers must have been sorted into decreasing order (hint: try [1,4,3].sort)

(
	var randn;
    randn = { arg n = 2;

	Array.fill(n, rand(1.0, 10.0));
   };

    randn.value(4);
);


({

});

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
barFunc.value(8);
)

barFunc;


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