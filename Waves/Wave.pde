class Wave {

	int xspacing;
	int w;
	int maxwaves;
	float theta;
	float[] amplitude;
	float[] dx;
	float[] yvalues;
	float position;
	float thetaIncrement;
	float opacity;
	float opacityIncr;
	boolean direction;
	color wColor;

	Wave(color color_) {
		theta = 0.0;
		thetaIncrement = random(0.05, 0.3);
		xspacing = 10;
		maxwaves = 5;
		amplitude = new float[maxwaves];
		dx = new float[maxwaves];
		w = width + 16;
		position = 0.0;
		opacity = 0.0;
		direction = boolean(int(random(0,1)));
	  wColor = color_;

	  for (int i = 0; i < maxwaves; i++) {
	    amplitude[i] = random(1,5);
	    float period = random(700,1000); 
	    dx[i] = (TWO_PI / period) * xspacing;
	  }

	  yvalues = new float[w/xspacing + 2];
	}

	void setPosition(float pos) {
		position = pos;
	}

	float getPosition() {
		return position;
	}

	void calcWave() {
		theta += thetaIncrement;
		for (int i = 0; i < yvalues.length; i++) {
			yvalues[i] = position;
		}

		for (int j = 0; j < maxwaves; j++) {
			float x = theta;
			for (int i = 0; i < yvalues.length; i++) {
				if (j % 2 == 0)  yvalues[i] += sin(x)*amplitude[j];
				else yvalues[i] += cos(x)*amplitude[j];
				if (direction) {
					x+=dx[j];	
				} else {
					x-=dx[j];
				}
				
			}
		}
		opacity = (position / height) * 255;
	}

	void renderWave() {
		stroke(wColor, opacity);
		strokeWeight(2);
		for (int x = 0; x < yvalues.length-1; x++) {
			// point(x*xspacing, position+yvalues[x]);
			line(x*xspacing, position+yvalues[x], (x+1)*xspacing-2, position+yvalues[x+1]);
		}
	}
}