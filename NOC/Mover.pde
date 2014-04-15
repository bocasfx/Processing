class Mover {

	PVector location;
	PVector velocity;
	PVector acceleration;
	float mass;
	float g;
	color cl;
	float angle;
	ArrayList<PVector> trajectory;
	float disturbance;
	float angleIncr;
	float accel;
	float disturbanceFactor;
	int trajectorySize;
	float distanceConstraintMin;
	float distanceConstraintMax;

	Mover(float m, float x, float y, float z, color c) {
		g = -0.02;
		angle = 0;
		trajectory = new ArrayList<PVector>();
		disturbance = 0.0;
		angleIncr = 0.0055;
		accel = 1.0;
		disturbanceFactor = 0.01;
		trajectorySize = 120;
		distanceConstraintMin = 10.0;
		distanceConstraintMax = 25.0;
		mass = m;
		location = new PVector(x, y, z);
		trajectory.add(location.get());
		velocity = new PVector(0, 0, 0);
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
			velocity.mult(0);
			g = 0;
			disturbanceFactor = 0.0;
		}
		if (trajectory.size() > trajectorySize) {
			trajectory.remove(0);
		}
	}

	void display() {
		rectMode(CENTER);
		pushMatrix();
		strokeWeight(2);
		for (int i = 0; i < trajectory.size()-1; ++i) {
			stroke(cl, i);
			PVector j = trajectory.get(i);
			PVector k = trajectory.get(i+1);
			line(j.x, j.y, j.z, k.x, k.y, k.z);
		}

		// for (int i = 0; i < trajectory.size(); i+=2) {
		// 	stroke(cl, i*3);
		// 	PVector j = trajectory.get(i);
		// 	point(j.x, j.y, j.z);
		// 	// sphere(1);
		// }
		
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
		distance = constrain(distance, distanceConstraintMin, distanceConstraintMax);

		// Normalize vector (distance doesn't matter here, we just want this vector for direction
		force.normalize(); 

		// Calculate gravitional force magnitude
		float strength = (g * mass * m.mass) / (distance * distance);

		// Get force vector --> magnitude * direction
		force.mult(strength);

		return force;
	}
}