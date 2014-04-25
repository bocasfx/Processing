// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Additive Wave
// Create a more complex wave by adding two waves together. 
 

Wave wave;

void setup() {
  size(1280, 720);
  
  wave = new Wave();
}

void draw() {
  background(0);
  wave.calcWave();
  wave.renderWave();
}

