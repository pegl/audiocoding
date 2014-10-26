a = {SinOsc.ar(OnePole.ar(Mix( LFSaw.ar([1,0.99],[0,0.6],2000,2000).trunc([400,600])*[1,-1] ),0.98)).dup*0.1}
a.play
a.plot(1, bounds: GUI.window.screenBounds)

{SinOsc.ar(OnePole.ar(Mix( LFSaw.ar([1,0.99],[0,0.6],2000,2000).trunc([400,600])*[1,-1] ),0.98)).dup*0.1}.play

{SinOsc.ar(OnePole.ar(Mix( LFSaw.ar([0,0.99],[0,0.6],2000,2000).trunc([550,552])*[1,-1] ),0.98)).dup*0.1}.play

{SinOsc.ar(OnePole.ar(Mix( LFSaw.ar([0,0.99],[0,0.6],2000,2000).trunc([550,600])*[1,-1] ),0.98)).dup*0.1}.play
{SinOsc.ar(OnePole.ar(Mix( LFSaw.ar([0,0.99],[0,0.6],2000,2000).trunc([550,600])*[1,-1] ),0.98)).dup*0.1}.plot(1)



play{SinOsc.ar(Mix( LFSaw.ar([1,0.99],[0,0.6],2000,2000).trunc([400,600])*[1,-1] ),0.98).dup*0.1}

b = {SinOsc.ar(OnePole.ar(LFSaw.ar([1,0.99],[0,0.6],2000,2000).trunc([400,600])*[1,-1] ),0.98).dup*0.1}
b.play
b.plot(1, bounds: GUI.window.screenBounds)

b = {SinOsc.ar(OnePole.ar(LFSaw.ar([1,0.99],[0,0.6],2000,2000).trunc([400,600])*[1,-1] ),0.98).dup*0.1}


play{SinOsc.ar(OnePole.ar(Mix( LFPar.ar([1,0.99],[0,0.6],2000,2000).trunc([400,600])*[1,-1] ),0.98)).dup*0.1}
c = {SinOsc.ar(OnePole.ar(Mix( LFTri.ar([1,0.99],[0,0.6],2000,2000).trunc([400,600])*[1,-1] ),0.98)).dup*0.1}
c.plot(1)
c.play
d = {SinOsc.ar(OnePole.ar(Mix( LFCub.ar([1,0.99],[0,0.6],2000,2000).trunc([400,600])*[1,-1] ),0.98)).dup*0.1}
d.plot(1)
d.play

{SinOsc.ar( LFCub.ar([1,0.99],[0,0.6],2000,2000).trunc([400,600])*[1,-1],0.98).dup*0.1}.plot


a = {SinOsc.ar( LFCub.ar([1,0.99],[0,0.6],2000,2000).trunc([400,600])*[1,-1],0.98).dup*0.1}
a.play
a.plot(1, bounds: GUI.window.screenBounds)


{ SinOsc.ar(440) }.plot(1, bounds: GUI.window.screenBounds);

	{ {|i| SinOsc.ar(1 + i)}.dup(7) }.plot(1);