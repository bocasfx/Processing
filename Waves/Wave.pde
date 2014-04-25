class Wave {

	void calcWave() {
		// Increment theta (try different values for 'angular velocity' here
		theta += 0.08;

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
				x+=dx[j];
			}
		}
	}

	void renderWave() {
		// A simple way to draw the wave with an ellipse at each location
		stroke(255);
		// fill(127,50);
		// ellipseMode(CENTER);
		for (int x = 0; x < yvalues.length; x++) {
			// ellipse(x*xspacing,height/2+yvalues[x],48,48);
			point(x*xspacing, height/2+yvalues[x]);
		}
	}
}