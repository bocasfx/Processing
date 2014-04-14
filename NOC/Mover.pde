class Mover {

	PVector location;
	PVector velocity;
	PVector acceleration;
	float mass;
	float g = -0.001;
	color cl;
	float angle = 0;
	ArrayList<PVector> trajectory = new ArrayList<PVector>();
	float disturbance = 0.0;
	float angleIncr = 0.0025;
	float accel = 1.0;
	float disturbanceFactor = 0.05;

	Mover(float m, float x, float y, float z, color c) {
		mass = m;
		location = new PVector(x, y, z);
		trajectory.add(location.get());
		velocity = new PVector(0, 0, 0);
		// acceleration = new PVector(0, 0, 0);
		acceleration = new PVector(random(-accel, accel), random(-accel, accel), random(-accel, accel));
		cl = c;
	}

	void applyForce(PVector force) {
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}

	void disturb() {
		location.rotate(disturbance);
	}

	void update() {
		velocity.add(acceleration);
		location.add(velocity);
		trajectory.add(location.get());
		acceleration.mult(0);
		float sinAngle = sin(angle);
		disturbance = disturbanceFactor * sinAngle;
		angle += angleIncr;
		if (sinAngle < 0.0) {
			// g = -25;
			velocity.mult(0);
			g = 0;
			disturbanceFactor = 0.0;
		}
		if (trajectory.size() > 45) {
			trajectory.remove(0);
		}
	}

	void display() {
		rectMode(CENTER);
		pushMatrix();
		strokeWeight(2);
		for (int i = 0; i < trajectory.size()-1; ++i) {
			stroke(cl, i*2);
			PVector j = trajectory.get(i);
			PVector k = trajectory.get(i+1);
			line(j.x, j.y, j.z, k.x, k.y, k.z);
		}
		
		// translate(location.x, location.y, location.z);
		// sphereDetail(3);
		// sphere(1);
		
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