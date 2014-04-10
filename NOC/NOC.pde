// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover[] movers = new Mover[100];

void setup() {
	size(640,360);
	// size(1280,720);
	background(0);
	Palette palette = new Palette("palette.act");
	color mColor; 
	for (int i = 0; i < movers.length; i++) {
		int idx = int(random(0, 5));
		mColor = palette.colors[idx];
		movers[i] = new Mover(0.5, random(width), random(height), mColor);
	}
}

void draw() {
	for (int i = 0; i < movers.length; i++) {
		for (int j = 0; j < movers.length; j++) {
			if (i != j) {
				PVector force = movers[j].attract(movers[i]);
				movers[i].applyForce(force);
				
			}
		}

		movers[i].update();
		movers[i].display();
	}
}

