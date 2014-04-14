// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover[] movers = new Mover[500];
float rotation = 0;

float targetAngle = 90.0;
float dAngle = 0.0;
float easing = 0.01;
boolean changeIncr = true;

void setup() {
	size(640,360,P3D);
	// size(1280,720,P3D);
	background(0);
	Palette palette = new Palette("palette2.act");
	color mColor; 
	int depth = (width+height)/2;
	for (int i = 0; i < movers.length; i++) {
		int idx = int(random(0, 5));
		mColor = palette.colors[idx];
		// movers[i] = new Mover(random(0.1, 1.0), random(-width, width), random(-height, height), random(-depth, depth), mColor);
		movers[i] = new Mover(random(0.1, 1.0), 0, 0, 0, mColor);
	}
	background(0);
}

void draw() {
	smooth();
	background(0);
	lights();

	float orbitRadius= width;
	float ypos= 0;
	float xpos= cos(radians(rotation))*orbitRadius;
	float zpos= sin(radians(rotation))*orbitRadius;

	camera(xpos, ypos, zpos, 0, 0, 0, 0, -1, 0);

	for (int i = 0; i < movers.length; i++) {
		for (int j = 0; j < movers.length; j++) {
			if (i != j) {
				PVector force = movers[j].attract(movers[i]);
				movers[i].applyForce(force);
				
			}
		}

		movers[i].update();
		movers[i].disturb();
		movers[i].display();
	}
	if (rotation < 90) {

		dAngle = targetAngle - rotation;

		if(abs(dAngle) > 1) {
			rotation += dAngle * easing;
		}
	}
	// saveFrame("./frames/frame-######.tif");
}

