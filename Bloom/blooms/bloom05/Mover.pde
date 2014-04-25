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
	float disturbanceFactor;
	int trajectorySize;
	float distanceConstraintMin;
	float distanceConstraintMax;

	Mover(float m, PVector accel, float x, float y, float z, color c) {
		
		g = -0.01;
		angle = 0;
		disturbance = 0.0;
		angleIncr = 0.001;
		disturbanceFactor = 0.03;
		trajectorySize = 120;
		distanceConstraintMin = 5.0;
		distanceConstraintMax = 25.0;

		mass = m;
		location = new PVector(x, y, z);
		velocity = new PVector(0, 0, 0);
		trajectory = new ArrayList<PVector>();
		trajectory.add(location.get());
		acceleration = accel;
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
		if (sinAngle < 0.0) {
			velocity.mult(0);
			g = 0;
			disturbanceFactor = 0.0;
		}
		disturbance = disturbanceFactor * sinAngle;
		angle += angleIncr;
		if (trajectory.size() > trajectorySize) {
			trajectory.remove(0);
		}
	}

	void display() {
		for (int i = 0; i < trajectory.size()-1; ++i) {
			stroke(cl, i);
			PVector j = trajectory.get(i);
			PVector k = trajectory.get(i+1);
			line(j.x, j.y, j.z, k.x, k.y, k.z);
		}
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