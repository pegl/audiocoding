// from berlin supercollider users group
(

{
var dseq, trig;

dseq = Drand([1, 5, 4, 7, -2, 7, 12, 17], inf);
trig = Impulse.kr(5);
SinOsc.ar(
    (48 + Demand.kr(trig, 0, dseq)).midicps,
    0,
    0.5
) ! 2


}.play


)

(

{
var dseq, trig;

dseq = Dseq([MouseY.kr(1, 18), MouseX.kr(1, 18), 4], inf);
trig = Impulse.kr(5);
SinOsc.ar(
    (48 + Demand.kr(trig, 0, dseq)).midicps,
    0,
    0.5
) ! 2


}.play


)



(

{
var dseq, trig;

dseq = Dseq([SinOsc.kr(0.2).range(-5, 12), 4], inf);
trig = Impulse.ar(400);
SinOsc.ar(
    (65 + Demand.ar(trig, 0, dseq)).midicps,
    0,
    0.5
) ! 2


}.play


)



(

{
var dseq, trig;

dseq = Dseq([SinOsc.ar(0.02).range(-5, 12), SinOsc.ar(0.4).range(-9, 19), 9], inf);
trig = Impulse.ar(400);
SinOsc.ar(
    (65 + Demand.ar(trig, 0, dseq)).midicps,
    0,
    0.5
) ! 2


}.play


)



(

{
var dseq, trig;

dseq = Dseq([SinOsc.ar(45).range(-5, 12), SinOsc.ar(77).range(-9, 19), 9, 0, -12], inf);
trig = Impulse.ar(254);
SinOsc.ar(
    (88 + Demand.ar(trig, 0, dseq)).midicps,
    0,
    0.5
) ! 2


}.play


)


(

{
var dseq, trig;

dseq = Dseq([SinOsc.ar(45).range(-5, 12), SinOsc.ar(SinOsc.ar(0.285).range(42, 48)).range(-9, 19), 9, 0, -12], inf);
trig = Impulse.ar(SinOsc.ar(0.2).range(44, 46));
SinOsc.ar(
    (77 + Demand.ar(trig, 0, dseq)).midicps,
    0,
    0.5
) ! 2


}.play


)





(

{
var dseq, trig;

dseq = Dseq([SinOsc.ar(45).range(-5, 12), SinOsc.ar(SinOsc.ar(0.285).range(42, 48)).range(-9, 19), 9, 0, -12], inf);
trig = Impulse.ar(SinOsc.ar(0.02).range(4, 100));
SinOsc.ar(
    (SinOsc.ar(0.0793).range(77, 99) + Demand.ar(trig, 0, dseq)).midicps,
    0,
    0.5
) ! 2


}.play


)




(

{
var dseq, trig;

dseq = Drand([SinOsc.ar(45).range(-5, 12), SinOsc.ar(SinOsc.ar(0.285).range(42, 48)).range(-9, 19), 9, 0, -12], inf);
trig = Impulse.ar(SinOsc.ar(0.02).range(400, 1000));
SinOsc.ar(
    (SinOsc.ar(SinOsc.ar(0.92563).range(0.00153, 0.2793)).range(44, 99) + Demand.ar(trig, 0, dseq)).midicps,
    0,
    0.5
) ! 2


}.play


)



(

{
var dseq, trig;

dseq = Drand([SinOsc.ar(415).range(-5, 12), SinOsc.ar(SinOsc.ar(0.285).range(42, 48)).range(-9, 19), 9, 0, -12], inf);
trig = Impulse.ar(SinOsc.ar(10.02).range(SinOsc.ar(9).range(200, 400), 1000));
SinOsc.ar(
    (SinOsc.ar(SinOsc.ar(30.92563).range(0.00153, 0.2793)).range(44, 99) + Demand.ar(trig, 0, dseq)).midicps,
    0,
    0.5
) ! 2


}.play


)



(

{
var dseq, trig;

dseq = Drand([SinOsc.ar(415).range(-5, 12), SinOsc.ar(SinOsc.ar(60.285).range(42, 48)).range(-9, 19), 9, 0, -12], inf);
trig = Impulse.ar(SinOsc.ar(100.02).range(SinOsc.ar(90).range(200, 400), 1000));
SinOsc.ar(
    (SinOsc.ar(SinOsc.ar(30.92563).range(650.00153, 120.2793)).range(44, 99) + Demand.ar(trig, 0, dseq)).midicps,
    0,
    0.5
) ! 2


}.play


)


(
{
    var a, freq, trig;
    a = Dseq([1, 3, 2, 7, 8], 3);
    trig = Impulse.kr(MouseX.kr(1, 40, 1));
    freq = Demand.kr(trig, 0, a) * 30 + 340;
    SinOsc.ar(freq) * 0.1

}.play;
)

// audio rate
(
{
    var a, freq, trig;
    a = Dseq({ 10.rand } ! 32, inf);
    trig = Impulse.ar(MouseX.kr(1, 10000, 1));
    freq = Demand.ar(trig, 0, a) * 30 + 340;
    SinOsc.ar(freq) * 0.1

}.play;
)