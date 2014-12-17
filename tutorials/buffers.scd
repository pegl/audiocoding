
Server.default=s=Server.local;

s.boot;

Platform.resourceDir +/+ "sounds/a11wlk01.wav" //3.5 or later


//allocate a one channel buffer of 441000 sample frames (10 sec at standard sampling rate)

b=Buffer.alloc(s, 10*44100, 1);  // s= server, 10*44100 num frames, 1 = 1 channel, i.e. mono
b.bufnum
b.free


// playbuf
(
    //this loads into a buffer the default sound that comes with SuperCollider
    //.read brings in the whole sound at once
    b = Buffer.read(s,Platform.resourceDir +/+ "sounds/a11wlk01.wav"); //store handle to Buffer in global variable b
    SynthDef("playbuf",{ arg out=0,bufnum=0, rate=1, trigger=1, startPos=0, loop=1;
        Out.ar(out,
            Pan2.ar(PlayBuf.ar(1,bufnum, BufRateScale.kr(bufnum)*rate, trigger, BufFrames.ir(bufnum)*startPos, loop),0.0)
            )
        }).add; 
    )


//note how even though the soundfile doesn't loop, the Synth is not deallocated when done
//(it has no envelope function). you'll need to cmd+period to kill it  
Synth(\playbuf, [\out, 0, \bufnum, b.bufnum]);

 //play at half rate
Synth(\playbuf, [\out, 0, \bufnum, b.bufnum, \rate, 0.5]);



//Example with GUI controlling Synth 

(
    var w, rateslid, trigslid, startposslid, loopslid, a; 
    a=Synth(\playbuf, [\out, 0, \bufnum, b.bufnum]);
    w=Window("PlayBuf Example",Rect(10,200,300,150));
    w.front;

    //control positioning of new GUI elements so I don't have to think too hard about it
    w.view.decorator= FlowLayout(w.view.bounds);
    //James' shortcut slider class

    //250@24 means a Point of size 250 by 24

    //|ez| is the same as arg ez;  - the EZSlider object is being passed into the callback action function

    rateslid= EZSlider(w, 250@24, "Rate", ControlSpec(0.5, 10, 'exponential', 0.1), {|ez| a.set(\rate,ez.value)}, 1);
    trigslid= EZSlider(w, 250@24, "Trigger", ControlSpec(0, 1, 'lin', 1), {|ez| a.set(\trigger,ez.value)}, 1);
    startposslid= EZSlider(w, 250@24, "StartPos", ControlSpec(0.0, 1.0, 'lin', 0.01), {|ez| a.set(\startPos,ez.value)}, 0);
    loopslid= EZSlider(w, 250@24, "Loop", ControlSpec(0, 1, 'lin', 0.1), {|ez| a.set(\loop,ez.value)}, 1);
    w.onClose_({a.free;});

)



(

    //this loads into a buffer the default sound that comes with SuperCollider

    //.read brings in the whole sound at once

    b = Buffer.read(s,Platform.resourceDir +/+ "sounds/a11wlk01.wav");


    //using Mouse to scrub through- X position is normalised position 0 to 1 phase through the source file 

    SynthDef("bufrd",{ arg out=0,bufnum=0;

        Out.ar(out,

            Pan2.ar(BufRd.ar(1, bufnum, K2A.ar(BufFrames.ir(b.bufnum)*MouseX.kr(0.0,1.0)).lag(MouseY.kr(0.0,1.0))),0.0)

            )

        }).play(s); 

    )
[BufRd]




(
// use this to strem a large file off disk
//Prepare to stream. You can use a big file for streaming: replace the filename here with one valid for your machine. Note that dragging and dropping a file into the SC text editor posts the full path of that file as text for you to use in your code. 
b=Buffer.cueSoundFile(s,Platform.resourceDir +/+ "sounds/a11wlk01.wav",0, 1);
)

SynthDef(\diskin,{Out.ar(0,DiskIn.ar(1, b.bufnum))}).play(s);


// Wavetables and oscillators
{SinOsc.ar(100)}.plot(0.05) //plot 5 cycles of a SinOsc sine oscillator: reads through the sine wavetable 5 times
b = Buffer.alloc(s, 512, 1); //make a Buffer storage area
b.sine1(1.0/[1,2,3,4,5,6], true, false, true);  //fill the Buffer with wavetable data
b.plot; //stored shape (not in special SuperCollider Wavetable format, for clarity)
{OscN.ar(b,MouseX.kr(10,1000),0,0.1)}.play  //OscN; N means non-interpolating
{Osc.ar(b,MouseX.kr(10,1000),0,0.1)}.play  //OscN; N means non-interpolating


[Osc]
[OscN]

// More ugens leveraging buffers 
[Index] //buffer as array of data for UGen
[Shaper] //buffer for wave shaping distortion/complex sound generation
[FFT]   //buffer as complex Fourier data, gets passed through the phase vocoder processing chain