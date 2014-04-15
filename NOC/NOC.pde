// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover[] movers;
float rotation;
float targetAngle;
float dAngle;
float easing;


void setup() {

	Palette palette;
	color mColor;
	int depth;

	// size(640,360,P3D);
	size(1280,720,P3D);
	background(0);

	movers = new Mover[500];
	rotation = 0;
	targetAngle = 90.0;
	dAngle = 0.0;
	easing = 0.01;

	palette = new Palette("palette2.act");
	
	depth = (width+height)/2;
	for (int i = 0; i < movers.length; i++) {
		int idx = int(random(0, 5));
		mColor = palette.colors[idx];
		movers[i] = new Mover(random(0.1, 1.0), 0, 0, 0, mColor);
	}
}

void draw() {

	float orbitRadius;
	float ypos;
	float xpos;
	float zpos;

	smooth();
	background(0);
	lights();

	orbitRadius = width;
	ypos = 0;
	xpos = cos(radians(rotation)) * orbitRadius;
	zpos = sin(radians(rotation)) * orbitRadius;

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

