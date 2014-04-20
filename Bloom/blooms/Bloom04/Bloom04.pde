// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

Mover[] movers;
float rotation;
float targetAngle;
float dAngle;
float easing;
float orbitRadius;
Attractor sun;
boolean saveFrames;

void setup() {

	size(1280,720,P3D);
	frameRate(30);
	background(0);
	movers = new Mover[500];
	rotation = 0;
	targetAngle = 90.0;
	dAngle = 0.0;
	easing = 0.005;
	orbitRadius = width;
	Palette palette = new Palette("../../palettes/palette2.act");
	Table moverDefs = loadTable("../../moverDefs.csv");
	saveFrames = false;
	PVector location;

	strokeWeight(2);

	PVector acceleration;
	float x;
	float y;
	float z;
	float m;
	int idx;
	float depth = (height + width) / 2;
		
	for (int i = 0; i < movers.length; i++) {
		m = moverDefs.getFloat(i, 0);
		x = random(-width, width);
		y = random(-height, height);
		z = random(-depth, depth);
		idx = moverDefs.getInt(i, 4);
		acceleration =  new PVector(0, 0, 0);
		location = new PVector(x, y, z);
		movers[i] = new Mover(m, acceleration, location, palette.colors[idx]);
	}

	sun = new Attractor(new PVector(0,0,0), 25);
}

void draw() {
	
	smooth();
	background(0);
	lights();

	// if (frameCount == 300) {
	// 	sun.setMass(0); 
	// 	for (int i = 0; i < movers.length; i++) {
	// 		movers[i].stopMotion();
	// 	}
	// } else if (frameCount == 450) {
	// 	for (int i = 0; i < movers.length; i++) {
	// 		movers[i].resetMotion();
	// 	}
	// 	sun.setMass(50); 
	// }
	
	float ypos = 0.0;
	float xpos = cos(radians(rotation)) * orbitRadius;
	float zpos = sin(radians(rotation)) * orbitRadius;

	// orbitRadius += 3.0;

	camera(xpos, ypos, zpos, 0, 0, 0, 0, -1, 0);

	for (int i = 0; i < movers.length; i++) {
		// for (int j = 0; j < movers.length; j++) {
		// 	if (i != j) {
		// 		PVector force = movers[j].attract(movers[i]);
		// 		movers[i].applyForce(force);
		// 	}
		// }

		PVector sunForce = sun.attract(movers[i]);
		movers[i].applyForce(sunForce);

		movers[i].update();
		movers[i].disturb();
		movers[i].display();
	}

	// if (rotation < targetAngle) {
	// 	dAngle = targetAngle - rotation;
	// 	if(abs(dAngle) > 1) {
	// 		rotation += dAngle * easing;
	// 	}
	// }
	rotation += 0.3;
	saveFrame("./frames/frame-######.tif");
}

void keyPressed() {
	switch (key) {
		case 'a':
			sun.setMass(0); 
			for (int i = 0; i < movers.length; i++) {
				movers[i].stopMotion();
			}
			break;
		case 'b':
			for (int i = 0; i < movers.length; i++) {
				movers[i].resetMotion();
			}
			sun.setMass(25); 
			break;
		case 's':
			saveFrames = !saveFrames;
	}
}
