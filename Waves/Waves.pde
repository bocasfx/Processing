// Based on:
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
// Additive Wave

Wave[] waves;
int waveCount;

void setup() {
  size(1280, 720);

  waveCount = 200;
  waves = new Wave[waveCount];
  Palette palette = new Palette("palette.act");
  int idx;

  for (int i = 0; i < waveCount; ++i) {
    idx = int(random(0, 5));
    waves[i] = new Wave(random(height), random(0.05, 0.1), boolean(i%2), palette.colors[idx]);
  }
}

void draw() {
  background(0);
    for (int i = 0; i < waveCount; ++i) {
    waves[i].calcWave();
    waves[i].renderWave();  
  }
}

