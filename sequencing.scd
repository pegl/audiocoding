
(

SynthDef(\event,{ arg freq=440, amp=0.5, pan=0.0;

var env;



env = EnvGen.ar(  Env([0,1,1,0],[0.01, 0.1, 0.2]),  doneAction:2);

Out.ar(0,  Pan2.ar(Blip.ar(freq) * env * amp, pan))

}).add;

)

//test event sound

Synth(\event)	//accepts defaults. Event shouldn't hang around once envelope finished due to doneAction:2



//specifying values

Synth(\event,[\freq,880,\amp,0.2,\pan,1.0]) //pan 1.0 should send to right ear

(

{

Synth(\event);

1.0.wait;	//wait for 1 time unit of default tempo, will probably work out to 1 second

Synth(\event);

}.fork; //.fork is a computer science term for setting a new process (sequence) in action

)

//now 4 events, all evenly spaced

(

{

Synth(\event);

1.0.wait;

Synth(\event);

1.0.wait;

Synth(\event);

1.0.wait;

Synth(\event);

}.fork;

)


(

{

4.do {

Synth(\event);

1.0.wait;

};

}.fork;

)



//now 8 events, unevenly spaced

(

{

8.do {

Synth(\event,[\freq, rrand(440,880)]);

rrand(0.2,0.6).wait;

};

}.fork;

)


//now 8 events, unevenly spaced, followed by 4 quick evenly spaced events

(

{

8.do {

Synth(\event,[\freq, rrand(110,220)]);

rrand(0.2,0.6).wait;

};

4.do {

Synth(\event);

0.25.wait;

};

}.fork;

)

TempoClock.default.tempo

TempoClock.default.tempo = 2


(

var tempoclock = TempoClock(3);  //3 beats per second
var tempoclock1 = TempoClock(1);  //3 beats per second

{



8.do {
//rrand(low, hi) gets a uniform random number in that range
Synth(\event,[\freq, rrand(440,880)]);
1.0.wait;
};
}.fork(tempoclock); //make sure the fork knows to use this clock rather than the default

{
8.do {
//rrand(low, hi) gets a uniform random number in that range
Synth(\event,[\freq, rrand(440,880)]);
2.0.wait;
};
}.fork(tempoclock1); //make sure the fork knows to use this clock rather than the default
)


(

var tempoclock = TempoClock(1);  //1 beat per second

{

//inf.do does something forever. Make very sure that there is a .wait of some duration inside the loop!

inf.do {

Synth(\event,[\freq, rrand(440,880)]);

1.0.wait;

};

}.fork(tempoclock);

)


(

SystemClock.sched(1.0,//start at 1.0 second from now

{//a function which states what you wish to schedule

Synth(\event);

nil //return nil to do just once

//1	//return 1 to repeat every second

}

)

)


