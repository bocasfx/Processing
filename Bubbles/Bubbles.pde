  /**
   * Bubbles
   * Based on Bouncy Bubbles. 
   * Based on code from Keith Peters (www.bit-101.com). 
   * 
   * Multiple-object collision.
   */
   
  import promidi.*;
  
  MidiIO midiIO;
  MidiOut midiOut;
   
  int numBalls;
  float spring;
  float gravity;
  float friction;
  ArrayList balls;
  int windowSizeX;
  int windowSizeY;
  
  int[] bufferLayer;
  int[] bufferAlpha;
  int numberOfPixels;
  int ballSize;
  int maxAlpha;
  
  int _noteDuration;
  int _currentMidiInDevice;
  int _currentMidiOutDevice;
  int _currentMidiChannel;
  int _numberOfOutputDevices;
  int _numberOfInputDevices;
  
  Object bubblesObj;
  
  // ------------------------------------------------------------------
  
  void setup() 
  {
    
    initializeVariables();
    initializeControls();
    size(windowSizeX, windowSizeY);
    smooth();
  }
  
  // ------------------------------------------------------------------
  
  void draw() 
  {
    background(0);
    
    if ( numBalls > 0 ) {
      
      if (numBalls > 1) {
        ballsCollide();
      }
      
      for (int i = 0; i < numBalls; i++) {
        ((Ball) balls.get(i)).move();
        ((Ball) balls.get(i)).display();  
      }
      
      drawCollisions();
    }
  }
  
  // ------------------------------------------------------------------
  
  void mousePressed() {
    balls.add( new Ball(mouseX, mouseY, ballSize, numBalls, balls, (int)random(40,60), 127));
    numBalls++;
  }
  
  // ------------------------------------------------------------------
  
  void ballsCollide() {
    
    Ball other;
    Ball one;
    
    for( int i = 0 ; i < numBalls; i++) {  
      for( int j = i+1 ; j < numBalls; j++) {  
      
        other = ((Ball) balls.get(i));
        one = ((Ball) balls.get(j));
        
        float dx = other.x - one.x;
        float dy = other.y - one.y;
        float distance = sqrt(dx*dx + dy*dy);
        float minDist = other.diameter;
        
        if (distance < minDist) { 
          float angle = atan2(dy, dx);
          float targetX = one.x + cos(angle) * minDist;
          float targetY = one.y + sin(angle) * minDist;
          float ax = (targetX - other.x) * spring;
          float ay = (targetY - other.y) * spring;
          one.vx -= ax;
          one.vy -= ay;
          other.vx += ax;
          other.vy += ay;
          other.playNote();
          one.playNote();
        }
      } 
    }
  }
  
  // ------------------------------------------------------------------
  
  void initializeVariables() {
    
    bubblesObj = this;
    
    numBalls = 0;
    spring = 1;
    gravity = 0.001;
    friction = -1;
    balls = new ArrayList();
    windowSizeX = 600;
    windowSizeY = 600;
    
    //_currentMidiOutDevice = 1;
    _currentMidiInDevice = _currentMidiOutDevice + 1;
    _currentMidiChannel = 0;
    midiIO = MidiIO.getInstance( this );
    midiOut = midiIO.getMidiOut( _currentMidiOutDevice, _currentMidiChannel );
    _numberOfOutputDevices = midiIO.numberOfOutputDevices();
    _numberOfInputDevices = midiIO.numberOfInputDevices();
    
    //midiIO.openInput(_currentMidiInDevice, 0);
    //midiIO.plug( this, "noteOn", _currentMidiInDevice, 0 );
    
    numberOfPixels = windowSizeX * windowSizeY;
    
    bufferLayer = new int[numberOfPixels];
    bufferAlpha = new int[numberOfPixels];
    maxAlpha = 100;
    
    for( int i=0 ; i<numberOfPixels ; i++ ) {
      bufferLayer[i] = 0;
      bufferAlpha[i] = 100;
    }
    ballSize = 40;
  }
  
  // ------------------------------------------------------------------
  
  void drawCollisions() {
  
    int idx;
      
    for( int y=0 ; y<windowSizeY ; y++ ) {
      for( int x=0 ; x<windowSizeX ; x++ ) {
       
        idx = x + (y * windowSizeY);
        
        if ( bufferLayer[idx] > 0 ) {
          stroke(255, bufferAlpha[idx]);
          ellipse(x,y,bufferLayer[idx], bufferLayer[idx]);
          bufferLayer[idx]++;
          bufferAlpha[idx] -= 5;
          
          if ( bufferLayer[idx] > 80 ) {
            bufferLayer[idx] = 0;
            bufferAlpha[idx] = maxAlpha;
          }
        }
      }
    }
  }
  
  
  // ------------------------------------------------------------------
  
  void noteOn(Note note){
    
    int vel = note.getVelocity();
    int pit = note.getPitch();
    
    String str1 = midiIO.getInputDeviceName(_currentMidiInDevice);
    String str2 = midiIO.getOutputDeviceName(_currentMidiOutDevice);
    
    if ( str1.equals(str2) == false ) {
    
      if ( vel > 0 ) {
    
        balls.add( new Ball((int)random(windowSizeX), (int)random(windowSizeY), ballSize, numBalls, balls, pit, vel) );
        numBalls++;
      }
    }
  }
  
  

