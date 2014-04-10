class Mover {

	PVector location;
	PVector oldLocation;
	PVector velocity;
	PVector acceleration;
	float mass;
	float g = 0.01;
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
		acceleration.mult(0);
	}

	void display() {
		float angle = velocity.heading();
		rectMode(CENTER);
		pushMatrix();
		strokeWeight(2);
		stroke(cl, int(random(20)));
		line(location.x, location.y, oldLocation.x, oldLocation.y);
		translate(location.x, location.y);
		popMatrix();
	}

	PVector attract(Mover m) {
		// Calculate direction of force
		PVector force = PVector.sub(location, m.location); 

		// Distance between objects
		float distance = force.mag(); 

		// Limiting the distance to eliminate "extreme" results for very close or very far objects
		distance = constrain(distance, 5.0, 25.0);

		// Normalize vector (distance doesn't matter here, we just want this vector for direction
		force.normalize(); 

		// Calculate gravitional force magnitude
		float strength = (g * mass * m.mass) / (distance * distance);

		// Get force vector --> magnitude * direction
		force.mult(strength);

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