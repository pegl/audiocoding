console.log("Dom dom dom or Dom do dam or Don't do that");

let audioContext = new AudioContext();

function startLoop(audioBuffer, pan=0, rate=1) {
  let sourceNode = audioContext.createBufferSource();
  let pannerNode = audioContext.createStereoPanner();
  sourceNode.buffer = audioBuffer;
  sourceNode.loop = true;
  sourceNode.loopStart = 1.5;
  sourceNode.loopEnd = 3.1;
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
    startLoop(audioBuffer, -1);
    startLoop(audioBuffer, 1, 1.002);
  })
  .catch(e => console.error(e));
