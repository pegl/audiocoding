console.log("Dom dom dom or Dom do dam or Don't do that");

let audioContext = new AudioContext();

function startLoop(audioBuffer, start, end, pan=0, rate=1) {
  let sourceNode = audioContext.createBufferSource();
  let pannerNode = audioContext.createStereoPanner();
  sourceNode.buffer = audioBuffer;
  sourceNode.loop = true;
  sourceNode.loopStart = start;
  sourceNode.loopEnd = end;
  sourceNode.playbackRate.value = rate;
  pannerNode.pan.value = pan;
  sourceNode.connect(pannerNode);
  pannerNode.connect(audioContext.destination);
  sourceNode.start(0, 1.5);
}

fetch('dom_dom_dom.mp3')
  .then(response => response.arrayBuffer())
  .then(arrayBuffer => audioContext.decodeAudioData(arrayBuffer))
  .then(audioBuffer => {
    startLoop(audioBuffer, 1.5, 4.35, -1);
    startLoop(audioBuffer, 1.5, 5.35, 1, 1.002);
    startLoop(audioBuffer, 1.5, 6.35, 0, 1);
  })
  .catch(e => console.error(e));
