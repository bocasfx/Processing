class Wave {

	int xspacing = 25;   // How far apart should each horizontal location be spaced
	int w;              // Width of entire wave
	int maxwaves = 1;   // total # of waves to add together

	float theta = 0.0;
	float[] amplitude = new float[maxwaves];   // Height of wave
	float[] dx = new float[maxwaves];          // Value for incrementing X, to be calculated as a function of period and xspacing
	float[] yvalues;                           // Using an array to store height values for the wave (not entirely necessary)
	float yPos;
	float thetaIncrement;
	boolean left;

	Wave(float yPos_, float theta_, boolean left_) {
		w = width + 16;

	  for (int i = 0; i < maxwaves; i++) {
	    amplitude[i] = random(1,5);
	    float period = random(100,300); // How many pixels before the wave repeats
	    dx[i] = (TWO_PI / period) * xspacing;
	  }

	  yvalues = new float[w/xspacing];
	  yPos = yPos_;
	  thetaIncrement = theta_;
	  left = left_;
	}

	void calcWave() {
		// Increment theta (try different values for 'angular velocity' here
		theta += thetaIncrement;

		// Set all height values to zero
		for (int i = 0; i < yvalues.length; i++) {
			yvalues[i] = 0;
		}

		// Accumulate wave height values
		for (int j = 0; j < maxwaves; j++) {
			float x = theta;
			for (int i = 0; i < yvalues.length; i++) {
				// Every other wave is cosine instead of sine
				if (j % 2 == 0)  yvalues[i] += sin(x)*amplitude[j];
				else yvalues[i] += cos(x)*amplitude[j];
				if (left) {
					x+=dx[j];	
				} else {
					x-=dx[j];
				}
				
			}
		}
	}

	void renderWave() {
		// A simple way to draw the wave with an ellipse at each location
		stroke(125);
		// fill(127,50);
		// ellipseMode(CENTER);
		for (int x = 0; x < yvalues.length-1; x++) {
			// ellipse(x*xspacing,height/2+yvalues[x],48,48);
			point(x*xspacing, yPos+yvalues[x]);
			// line(x*xspacing, yPos+yvalues[x], (x+1)*xspacing, yPos+yvalues[x+1]);
		}
	}
}