  
 
  class MidiChannelListener implements ControlListener {
  
    public void controlEvent( ControlEvent theEvent ) {
  
      _currentMidiChannel = (int)theEvent.controller().value();
      midiOut = midiIO.getMidiOut( _currentMidiChannel, _currentMidiOutDevice );
    }
  }
  
  // ----------------------------------------------------------------------------------
  
   class ClearListener implements ControlListener {
  
    public void controlEvent( ControlEvent theEvent ) {
  
      int count = balls.size();
      for( int i=0 ; i<count ; i++ ) {
        balls.remove(0);
        numBalls--;
      }
      
      for( int i=0 ; i<numberOfPixels ; i++ ) {
        bufferLayer[i] = 0;
        bufferAlpha[i] = 100;
      }   
    }
  }
  
  // ----------------------------------------------------------------------------------
  
  class MidiOutputDeviceListener implements ControlListener {
  
    public void controlEvent( ControlEvent theEvent ) {
      
      try {
      
        if( _currentMidiOutDevice != (int)theEvent.controller().value() ) {
        
          if (_numberOfInputDevices > 0 ) {
            
            String str1 = midiIO.getInputDeviceName( _currentMidiInDevice );
            String str2 = midiIO.getOutputDeviceName( (int)theEvent.controller().value() );
            
            println(_currentMidiOutDevice);
            println(_currentMidiChannel);
          
            if ( str1.equals(str2) == false ) {
            
              _currentMidiOutDevice = (int)theEvent.controller().value();
              midiOut = midiIO.getMidiOut( _currentMidiChannel , _currentMidiOutDevice );
              
            } else {
              println("Unable to change Midi Output Device. Possible Midi Loop.");
            }
          } else {
            
            _currentMidiOutDevice = (int)theEvent.controller().value();              
            midiOut = midiIO.getMidiOut( _currentMidiChannel , _currentMidiOutDevice );
          }
        }
      } catch (Exception e) {
         println("Unable to change Midi Output Device.");
        println(e);
      }
    }
  }
  
  // ----------------------------------------------------------------------------------
  
  class MidiInputDeviceListener implements ControlListener {
  
    public void controlEvent( ControlEvent theEvent ) {
      
      if( _currentMidiInDevice != (int)theEvent.controller().value() ) {
      
        String str1 = midiIO.getInputDeviceName( (int)theEvent.controller().value());
        String str2 = midiIO.getOutputDeviceName(_currentMidiOutDevice);
      
        if ( str1.equals(str2) == false ) {
        
          _currentMidiInDevice = (int)theEvent.controller().value();
          midiIO.plug( bubblesObj, "noteOn", _currentMidiInDevice, 0 );
        } else {
          println("Unable to change Midi Input Device. Possible Midi Loop.");
        }
      }
    }
  }
  
  // ----------------------------------------------------------------------------------
  
  class NoteDurationListener implements ControlListener {
  
    public void controlEvent( ControlEvent theEvent ) {
      
      _noteDuration = (int)theEvent.controller().value();
    }
  }
  
  // ----------------------------------------------------------------------------------
  
  class GravityListener implements ControlListener {
  
    public void controlEvent( ControlEvent theEvent ) {
      
      gravity = (float)theEvent.controller().value();
    }
  }
    
  // ----------------------------------------------------------------------------------
  
  class SpringListener implements ControlListener {
  
    public void controlEvent( ControlEvent theEvent ) {
      
      spring = (float)theEvent.controller().value();
    }
  }
  
  // ----------------------------------------------------------------------------------
  
  class FrictionListener implements ControlListener {
  
    public void controlEvent( ControlEvent theEvent ) {
      
      friction = (float)theEvent.controller().value();
    }
  }

