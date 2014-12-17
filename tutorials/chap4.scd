MouseX.kr(leftscreenval, rightscreenval, warp, lag)
MouseY.kr(topscreenval, bottomscreenval, warp, lag)


{SinOsc.ar(MouseX.kr(20,20000, 'linear'),0,0.1)}.play


{SinOsc.ar(MouseY.kr(20,20000, 'exponential'),0,0.1)}.play


(0..99).linlin(0,100,10,1000).plot
(0..99).linexp(0,100,10,1000).plot


// mathematics
y  = ((x-a)/(b-a))*(d-c) + c //linear
y = c*((d/c)**((x-a)/(b-a))) //exponential (power operator is **) note that c can't be zero

// index ugen

//there are three distinct states
// no there's now 7!!

(

var vals;


vals= [100,150,200,250,300,350,400]; //change me and the code should adapt


{SinOsc.ar(Index.ar(LocalBuf.newFrom(vals), MouseX.kr(0, vals.size-0.001)))*0.2}.play

)


// smartarses went and created more steps by using a series with the number of harmonics
// [ 66, 132, 198, 264, 330, 396, 462, 528, 594, 660, 726 ]
(
var vals;
var numharm,basefreq;
numharm=11; //number of harmonics
basefreq=66;	//base frequency of series
s=Server.local;
vals= basefreq*(Array.series(numharm,1,1));
{SinOsc.ar(Index.kr(LocalBuf.newFrom(vals),MouseX.kr(0,numharm-0.001)),0,0.1)}.play
)



// mouse trigger
(
{
	var trig,mx;
	mx=MouseX.kr(0.0,1.0);
	trig= mx>0.5;	//this is a UGen which compares mx to the constant signal 0.5 at krate
	SinOsc.ar(440,0,0.1*trig)
}.play;
)

(	//trigger in a given region
{
var trig,mx,my;
mx=MouseX.kr(0.0,1.0);
my=MouseY.kr(0.0,1.0);
trig= if((mx>0.3) * (mx<0.5) * (my>0.3) * (my<0.7),1,0);
//if is a UGen here, * is equivalent to logical AND
SinOsc.ar(440,0,0.1*trig)
}.play;
)



// strummable guitar
// use mouse to strum strings
(
{
	var pitch, mousex, out;
	//pitch = [ 52, 57, 62, 67, 71, 76 ]; // e a d g b e
	pitch = [ 48, 55, 60, 67, 72, 76 ]; // c g c g c e
	mousex = MouseX.kr;
	out = Mix.fill(pitch.size, { arg i;
		var trigger, pluck, period, string;
		// place trigger points from 0.25 to 0.75
		trigger = HPZ1.kr(mousex > (0.25 + (i * 0.1))).abs;
		pluck = PinkNoise.ar(Decay.kr(trigger, 0.05));
		period = pitch.at(i).midicps.reciprocal;
		string = CombL.ar(pluck, period, period, 4);
		Pan2.ar(string, i * 0.2 - 0.5);
	});
	LPF.ar(out, 12000);
	LeakDC.ar(out);
}.play;
)


//first argument to MouseButton is the off value, second on on, when pressed button
{ SinOsc.ar(MouseButton.kr(400, 440), 0, 0.1) }.play;


//key code 0 = 'a' key
{ SinOsc.ar(800, 0, KeyState.kr(0, 0, 0.1)) }.play; //Server-side


//turn this off

(
Document.current.keyDownAction_(nil);
)

[Document]


GUI.current


[GUI] //main GUI help file

//The Rect(angle) takes the initial screen position and the window size
//as screenx, screeny, windowwidth, windowheight, where screeny is 0 at the bottom
(
var w;

w=Window("My Window", Rect(100,500,200,200));
//A 200 by 200 window appears at screen co-ordinates (100, 500)

w.front; //this line is needed to make the window actually appear
)

// window with controls
(
var w, slid;

w=Window("My Window", Rect(100,500,200,100));
//A 200 by 100 window appears at screen co-ordinates (100, 500)

slid=Slider(w,Rect(10,10,180,40)); //a basic slider object of size 180 by 40 appears 10 pixels in from the left, and 10 pixels down from the top

slid.action_({slid.value.postln;}); //this is the callback: the function is called whenever you move the slider. action_ means to set up the slider object to use the function passed in as its argument.

w.front;
)



// number ranges
1.0.rand	//create a random number from 0.0 to 1.0

1.0.rand*50	//create a random number from 0.0 to 1.0, and multiply it by 50 to get a new range from 0.0 to 50.0

1.0.rand*50+14.7	//create a random number from 0.0 to 1.0, multiply it by 50, then add 14.7, to get a new range from 14.7 to 64.7

1.0.rand.linlin(0.0,1.0,14.7,64.71)	//create a random number from 0.0 to 1.0, and use a built in function to remap it to the output range 14.7 to 64.71

1.0.rand.linexp(0.0,1.0,14.7,64.71) //create a random number from 0.0 to 1.0, and use a built in function to remap it to the output range 14.7 to 64.71 with an exponential function, which tends to spend longer over lower values


(
var w, slid, cs;

w=Window("My Window", Rect(100,500,200,100));
//A 200 by 200 window appears at screen co-ordinates (100, 500)

slid=Slider(w,Rect(10,10,180,40));

//arguments minimum value, maximum value, warp (mapping function), stepsize, starting value
cs= ControlSpec(20, 20000, \exponential, 10, 1000);

slid.action_({cs.map(slid.value).postln;}); //map to the desired range

w.front;
)



//Demo of using 2D-Slider for synthesis

(
SynthDef(\filterme,{arg freq=1000, rq=0.5;    //make sure there are control arguments to affect!
	Out.ar(0,Pan2.ar(
		BPF.ar(Impulse.ar(LFNoise0.kr(15,500,1000),0.1, WhiteNoise.ar(2)),freq,rq)
	))
}).add;
)

(
var w, slid2d, syn;

w=Window("My Window", Rect(100,300,200,200));
slid2d= Slider2D(w,Rect(5,5,175,175));

syn=Synth(\filterme);	//create synth

slid2d.action_({
	[slid2d.x, slid2d.y].postln;
	syn.set(\freq,100+(10000*slid2d.y),\rq,0.01+(0.09*slid2d.x));  //I'm doing my own linear mapping here rather than use a ControlSpec
});

w.front;

w.onClose={syn.free;};	//action which stops running synth when the window close button is pressed
)





10@10  //is the Point (10,10), an (x,y) co-ordinate position


(
w= Window("decoration",Rect(200,200,400,500));
//set up decorator. FlowLayout needs to know the size of the parent window, the outer borders (10 pixels in on horizontal and vertical here) and the standard gap to space GUI views (20 in x, 20 in y)
w.view.decorator= FlowLayout(w.view.bounds, 10@10, 20@20);

//now, when GUI views are added to the main view, they are automatically arranged, and you only need to say how big each view is
k= Array.fill(10,{Knob(w.view,100@100).background_(Color.rand)});

w.front; //make GUI appear
)

//they were stored in an array, held in global variable k, so we can access them all easily via one variable
k[3].background_(Color.rand)



(
w= Window("programming it directly ourselves",Rect(200,200,400,400));

//now, when GUI views are added to the main view, they are automatically arranged, and you only need to say how big each view is
k= Array.fill(16,{|i| Knob(w,Rect((i%4)*100+10,i.div(4)*100+10,80,80)).background_(Color.rand)});

//if worried by the use of % for modulo and .div for integer division, try the code in isolation:
//i.e., try out 5%4, and 5.div(4) as opposed to 5/4. How does this give the different grid positions as
//argument i goes from 0 to 15?

w.front; //make GUI appear
)



// dynamically add and remove things
w=Window();

w.front;	//window appears

Slider(w,Rect(10,10,100,100));	//slider appears straight away

w.view.children //slider should be in the list, even though we didn't store any reference to the slider object in a global variable (like w) ourselves

w.view.children[0].remove //nothing happens visually immediately

w.refresh; //refresh updates the appearance of the window and the slider disappears



// drag and drop
(
// create a GUI window with some NumberBoxes.
// You can command click on a control to drag its value to another control for cocoa, or control click for swing
var w, n, f, s;
w = Window("number box test", Rect(128, 64, 260, 80));
w.view.decorator = f = FlowLayout(w.view.bounds);

n = NumberBox(w, Rect(0,0,80,24));
n.value = 123;

n = NumberBox(w, Rect(0,0,80,24));
n.value = 456;

n = DragBoth(w, Rect(0,0,80,24));
n.object = 789;

f.nextLine;

s = Slider(w, Rect(0,0,240,24));

w.front;
)


(
w = Window.new("soundfile test", Rect(200, 200, 800, 400));
a = SoundFileView(w, Rect(20,20, 700, 60));

f = SoundFile.new;

if(Main.versionAtLeast(3,5),{
f.openRead(Platform.resourceDir +/+ "sounds/a11wlk01.wav");
},{
f.openRead("sounds/a11wlk01.wav");
});

a.soundfile_(f);
a.read(0, f.numFrames);

a.gridOn_(false);

w.front;
)




(
var w, h = 400, v = 400, seed = Date.seed, run = true;
w = Window("subdiv", Rect(40, 40, h, v));
w.view.background = Color.rand;
w.onClose = { run = false };
w.front;
//for SC3.4 or earlier, use drawHook
w.drawFunc = { var done, nextx, nexty, yellowness, penwidth;

nextx=0;
nexty=0;
yellowness=rrand(0.0,1.0);

penwidth=rrand(0.5,1.5);

//done=0;
	Pen.use {

		200.do({arg i;
		var lastx,lasty;
		lastx=nextx;
		lasty=nexty;

		nextx=nextx+rrand(1,20);
		nexty=nexty+rrand(1,40);

		if(nextx>=h, {nextx=nextx%h});
		if(nexty>=v, {nexty=nexty%v});

		penwidth=(penwidth+(0.2.rand2))%8.0;

		Pen.width= penwidth;

		yellowness= (yellowness+(0.1.rand2))%2.0;

		Color.yellow(yellowness).set;

		Pen.beginPath;
		Pen.line(Point(lastx,lasty),Point(nextx,nexty));
		Pen.rotate(rand(i%40));
		Pen.line(Point(lastx,lasty),Point(nextx,nexty));
		Pen.rotate(rand(i%40));
		Pen.line(Point(lastx,lasty),Point(nextx,nexty));
		Pen.rotate(rand(i%40));
		Pen.line(Point(lastx,lasty),Point(nextx,nexty));
			Pen.stroke;

		//Pen.fillRect(Rect(h.rand,v.rand,rrand(1,50),rrand(1,50)))

		});
	};

};

//{ while { run } { w.refresh; 3.wait; } }.fork(AppClock)

)







//This example was originally created in a seminar. It illustrates creating a new SynthDef, then a GUI which controls an active Synth based on that def.


//As an exercise, you might want to expand this by adding labels to the GUI window to show a user what each control does!


(

SynthDef(\mysound,{arg density=100, centrefreq=1000, rq=0.1, amp=0.1;

var dust, filter;

//Dust is a stochastic source of impulse clicks, density per second

dust= Dust.ar(density);

//the filtering is twofold; shaping the clicks via attack and decay smoothing in Decay2, and then a Band Pass Filter

filter= BPF.ar(50*Decay2.ar(dust,0.01,0.05),centrefreq, rq);

Out.ar(0,(filter*amp).dup(2))

}).add

)



//GUI code. The MIDI Controller option is commented out; it was added spontaneously to answer an inquiry about how to hook up an external control to a graphical user interface control. You may want to look back at this after later material in the course on MIDI.

(

var w, slid2d, knob, numberbox,amptext;

var sound;


//use that SynthDef!

sound= Synth(\mysound);


w= Window("mysound's window",Rect(100,300,300,200));


slid2d= Slider2D(w,Rect(10,10,180,180));


knob= Knob(w,Rect(210,10,80,80));

amptext = StaticText(w,Rect(210,110,80,80));
amptext.string = 'Ampltitude';

numberbox= NumberBox(w,Rect(210,110,80,80));


//slid2d.action = {stuff...} is the same as slid2d.action_({stuff...})

slid2d.action = {

sound.set(\density,slid2d.x*100.0+1,\rq,slid2d.y*0.5+0.01);

};


knob.action={sound.set(\centrefreq,knob.value*2000+500)};


//to let any MIDI control message set the knob position, and trigger the corresponding action

/*

MIDIIn.control={arg src,chan,num,val;

//defer avoids complaints from the system that the GUI is being updated outside of a safe thread; it pushes the code through to the AppClock (see week 6 of course)

{knob.value= (val/127.0); knob.action.value;}.defer;

};

*/


numberbox.action={var temp;


temp= numberbox.value.max(0.0).min(1.0);

sound.set(\amp,temp);


numberbox.value = temp;

};


w.front;


w.onClose= {sound.free;};

)








