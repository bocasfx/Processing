class Mover {

	PVector location;
	PVector velocity;
	PVector acceleration;
	float mass;
	float g = 0.1;
	color cl;
	float angle = 0;
	ArrayList<PVector> trajectory = new ArrayList<PVector>();

	Mover(float m, float x, float y, float z, color c) {
		mass = m;
		location = new PVector(x, y, z);
		trajectory.add(location.get());
		velocity = new PVector(0, 0, 0);
		acceleration = new PVector(0, 0, 0);
		cl = c;
	}

	void applyForce(PVector force) {
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}

	void update() {
		velocity.add(acceleration);
		location.add(velocity);
		trajectory.add(location.get());
		acceleration.mult(0);
		// g = 0.7 * sin(angle);
		// angle += 0.075;
		if (trajectory.size() > 120) {
			trajectory.remove(0);
		}
	}

	void display() {
		smooth();
		float angle = velocity.heading();
		rectMode(CENTER);
		pushMatrix();
		strokeWeight(1);
		for (int i = 0; i < trajectory.size()-1; ++i) {
			stroke(cl, i);
			PVector j = trajectory.get(i);
			PVector k = trajectory.get(i+1);
			line(j.x, j.y, j.z, k.x, k.y, k.z);
		}
		
		translate(location.x, location.y, location.z);
		sphereDetail(3);
		sphere(1);
		
		popMatrix();
	}

	PVector attract(Mover m) {
		// Calculate direction of force
		PVector force = PVector.sub(location, m.location); 

		// Distance between objects
		float distance = force.mag(); 

		// Limiting the distance to eliminate "extreme" results for very close or very far objects
		distance = constrain(distance, 0.01, 25.0);

		// Normalize vector (distance doesn't matter here, we just want this vector for direction
		force.normalize(); 

		// Calculate gravitional force magnitude
		float strength = (g * mass * m.mass) / (distance * distance);

		// Get force vector --> magnitude * direction
		force.mult(strength);

		return force;
	}
}