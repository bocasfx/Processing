  
  class Ball {
    
    float x, y;
    float diameter;
    float vx = 0;
    float vy = 0;
    int id;
    ArrayList others;
    int pitch;
    int velocity;
    color colour;
    
    // ----------------------------------------------------------------------------
   
    Ball(float xin, float yin, float din, int idin, ArrayList oin, int pit, int vel) {
      
      x = xin;
      y = yin;
      diameter = din;
      id = idin;
      others = oin;
      pitch = pit;
      velocity = vel;
      vx = random(-1, 1);
      vy = random(-1, 1);
      colour = color( random( 100, 255 ), random( 100, 255 ), random( 100, 255 ), 127 );
    } 
    
    // ----------------------------------------------------------------------------
    
    void move() {
      vy += gravity;
      x += vx;
      y += vy;
      if (x + diameter/2 > width) {
        x = width - diameter/2;
        vx *= friction; 
        playNote();
      }
      else if (x - diameter/2 < 0) {
        x = diameter/2;
        vx *= friction;
        playNote();
      }
      if (y + diameter/2 > height) {
        y = height - diameter/2;
        vy *= friction; 
        playNote();
      } 
      else if (y - diameter/2 < 0) {
        y = diameter/2;
        vy *= friction;
        playNote();
      }
    }
    
    // ----------------------------------------------------------------------------
    
    void display() {
      stroke(colour, 204);
      strokeWeight(3);
      noFill();
      ellipse(x, y, diameter, diameter);
    }
    
    // ----------------------------------------------------------------------------
    
    void playNote() {
      
      int idx = (int)((int)x + (int)y * windowSizeY);
      
      if ( idx > numberOfPixels-1 ) {
        idx = numberOfPixels - 1;
      }
      
      if ( idx < 0 ) {
        idx = 0;
      }
      
      bufferLayer[idx] = ballSize;
      
      Note note = new Note( pitch, velocity, _noteDuration);
      midiOut.sendNote(note);
    }
    
    //------------------------------------------------------------------------------
    
    private int normalizeValue( int value ){
      
      return (int)(( (float)value * 127.0 ) / (float)windowSizeY );
    }
  }
  
  
  
  
  
  
  
  
  
  
