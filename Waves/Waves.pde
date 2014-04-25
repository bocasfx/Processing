// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Additive Wave
// Create a more complex wave by adding two waves together. 
 

Wave[] waves;
int waveCount;

void setup() {
  size(1280, 720);
  
  waveCount = 200;
  waves = new Wave[waveCount];

  for (int i = 0; i < waveCount; ++i) {
    waves[i] = new Wave(random(height), random(0.05, 0.1), boolean(i%2));
  }
}

void draw() {
  background(0);
  for (int i = 0; i < waveCount; ++i) {
    waves[i].calcWave();
    waves[i].renderWave();  
  }
  
}

