class Wave {

	int xspacing = 25;
	int w;
	int maxwaves = 1;

	float theta = 0.0;
	float[] amplitude = new float[maxwaves];
	float[] dx = new float[maxwaves];
	float[] yvalues;
	float yPos;
	float thetaIncrement;
	boolean left;
	color wColor;

	Wave(float yPos_, float theta_, boolean left_, color color_) {
		w = width + 16;

	  for (int i = 0; i < maxwaves; i++) {
	    amplitude[i] = random(1,5);
	    float period = random(100,300); 
	    dx[i] = (TWO_PI / period) * xspacing;
	  }

	  yvalues = new float[w/xspacing];
	  yPos = yPos_;
	  thetaIncrement = theta_;
	  left = left_;
	  wColor = color_;
	}

	void calcWave() {
		theta += thetaIncrement;
		for (int i = 0; i < yvalues.length; i++) {
			yvalues[i] = 0;
		}

		for (int j = 0; j < maxwaves; j++) {
			float x = theta;
			for (int i = 0; i < yvalues.length; i++) {
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
		noStroke();
		fill(wColor, 50);
		ellipseMode(CENTER);
		for (int x = 0; x < yvalues.length; x++) {
			ellipse(x*xspacing, yPos+yvalues[x], 10, 10);
			// point(x*xspacing, yPos+yvalues[x]);
			// line(x*xspacing, yPos+yvalues[x], (x+1)*xspacing, yPos+yvalues[x+1]);
		}
	}
}