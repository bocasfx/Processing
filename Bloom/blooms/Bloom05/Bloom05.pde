// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover[] movers;
float rotation;
float targetAngle;
float dAngle;
float easing;

void setup() {

	size(1280,720,P3D);
	background(0);
	movers = new Mover[500];
	rotation = 0;
	targetAngle = 90.0;
	dAngle = 0.0;
	easing = 0.01;
	Palette palette = new Palette("../../palettes/palette2.act");
	Table moverDefs = loadTable("../../moverDefs.csv");

	strokeWeight(2);

	PVector acceleration;
	float x;
	float y;
	float z;
	float m;
	int idx;
		
	for (int i = 0; i < movers.length; i++) {
		m = moverDefs.getFloat(i, 0);
		x = moverDefs.getFloat(i, 1);
		y = moverDefs.getFloat(i, 2);
		z = moverDefs.getFloat(i, 3);
		idx = moverDefs.getInt(i, 4);
		acceleration =  new PVector(x, y, z);
		movers[i] = new Mover(m, acceleration, 0, 0, 0, palette.colors[idx]);
	}
}

void draw() {
	
	smooth();
	background(0);
	lights();

	float orbitRadius = width;
	float ypos = 0;
	float xpos = cos(radians(rotation)) * orbitRadius;
	float zpos = sin(radians(rotation)) * orbitRadius;

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