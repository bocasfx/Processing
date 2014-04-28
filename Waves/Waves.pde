// Based on:
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
// Additive Wave

ArrayList<Wave> waves;
float waveYPos;
float dPos;
float easing;
GplPalette palette;
int col;

void setup() {
  size(1280, 720);
  dPos = 0.0;
  easing = 0.001;
  palette = new GplPalette("palette.gpl");
  waves = new ArrayList<Wave>();
}

void draw() {
  background(0);
  strokeCap(ROUND);
  smooth();

  if (frameCount % 25 == 0) {
    waves.add(new Wave(palette.colors[int(col % 15)]));
    col++;
  }

  for (int i = 0; i < waves.size(); ++i) {
    waveYPos = waves.get(i).getPosition();
    if (waveYPos < height) {
      dPos = height - waveYPos;
      waveYPos += dPos * easing;
    }
    waves.get(i).setPosition(waveYPos);
    waves.get(i).calcWave();
    waves.get(i).renderWave();

    if (waveYPos > height) {
      waves.remove(i);
    }
  }
}
