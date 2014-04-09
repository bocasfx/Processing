class Mover {

	PVector location;
	PVector oldLocation;
	PVector velocity;
	PVector acceleration;
	float mass;
	float g = 0.01;

	// float angle = 0;
	// float aVelocity = 0;
	// float aAcceleration = 0.01;

	color cl;

	Mover(float m, float x, float y, color c) {
		mass = m;
		location = new PVector(x, y);
		oldLocation = new PVector(x, y);
		velocity = new PVector(0, 0);
		acceleration = new PVector(0, 0);
		cl = c;
	}

	void applyForce(PVector force) {
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}

	void update() {
		oldLocation = location.get();
		velocity.add(acceleration);
		location.add(velocity);

		// aAcceleration = acceleration.x / 10.0;
		// aVelocity += aAcceleration;
		// aVelocity = constrain(aVelocity, -0.1, 0.1);
		// angle += aVelocity;

		acceleration.mult(0);
	}

	void display() {
		float angle = velocity.heading();
		
		// fill(cl,200);
		rectMode(CENTER);
		pushMatrix();
		stroke(cl, int(random(20)));
		line(location.x, location.y, oldLocation.x, oldLocation.y);
		translate(location.x, location.y);
		// rotate(angle);
		// rect(0, 0, mass*16, mass*16);
		
		popMatrix();
	}

	PVector attract(Mover m) {
		PVector force = PVector.sub(location, m.location); // Calculate direction of force
		float distance = force.mag(); // Distance between objects
		distance = constrain(distance, 5.0, 25.0); // Limiting the distance to eliminate "extreme" results for very close or very far objects
		force.normalize(); // Normalize vector (distance doesn't matter here, we just want this vector for direction

		float strength = (g * mass * m.mass) / (distance * distance); // Calculate gravitional force magnitude
		force.mult(strength); // Get force vector --> magnitude * direction
		return force;
	}

	void checkEdges() {
		if (location.x < 0 || location.x > width) {
			velocity.x *= -1;
		}
		if (location.y < 0 || location.y > height) {
			velocity.y *= -1;
		}
	}
}