
  import controlP5.*;
  
   // Controls
  ControlP5 controlObj;
  ControlWindow controlPanel; 
  
  controlP5.Slider noteDurationSlider;
  controlP5.Slider gravitySlider;
  controlP5.Slider springSlider;
  controlP5.Slider frictionSlider;
  controlP5.ScrollList midiOutputDevicesList;
  controlP5.ScrollList midiInputDevicesList;
  controlP5.ScrollList midiChannelScrollList;
  controlP5.Button midiChannelButton;
  controlP5.Button midiOutputDeviceButton;
  controlP5.Button midiInputDeviceButton;
  controlP5.Button clearButton;
  
  MidiOutputDeviceListener outputDeviceListener;
  MidiInputDeviceListener inputDeviceListener;
  MidiChannelListener channelListener;
  NoteDurationListener durationListener;
  ClearListener clearListener;
  GravityListener gravityListener;
  SpringListener springListener;
  FrictionListener frictionListener;
  
  //-------------------------------------------------------------------
  
  void initializeControls() {
    
    controlObj = new ControlP5(this);
    controlObj.setAutoDraw(false);
    
    // Control Panel
    controlPanel = controlObj.addControlWindow("controlPanel", 600, 200);
    controlPanel.setBackground(color(0));
    controlObj.tab(controlPanel,"default").setLabel("General");
    
    // Note Duration
    noteDurationSlider = controlObj.addSlider ("noteDuration", 0, 5000, 500, 10, 30, 200, 10);
    noteDurationSlider.setLabel( "Note Duration");
    noteDurationSlider.setWindow(controlPanel);
    durationListener = new NoteDurationListener();
    noteDurationSlider.addListener(durationListener);
    _noteDuration = 500;
    
    // Gravity
    gravitySlider = controlObj.addSlider ("gravitySlider", -1, 1, 0.001, 10, 45, 200, 10);
    gravitySlider.setLabel( "Gravity");
    gravitySlider.setWindow(controlPanel);
    gravityListener = new GravityListener();
    gravitySlider.addListener(gravityListener);
    
    // Spring
    springSlider = controlObj.addSlider ("springSlider", -1, 1, 1, 10, 60, 200, 10);
    springSlider.setLabel( "Spring");
    springSlider.setWindow(controlPanel);
    springListener = new SpringListener();
    springSlider.addListener(springListener);
    
    // friction
    frictionSlider = controlObj.addSlider ("frictionSlider", -1, 0, -1, 10, 75, 200, 10);
    frictionSlider.setLabel( "Friction");
    frictionSlider.setWindow(controlPanel);
    frictionListener = new FrictionListener();
    frictionSlider.addListener(frictionListener);
    
    // Clear
    clearButton = controlObj.addButton ("clearButton", 0, 10, 150, 100, 15);
    clearButton.setLabel("Clear");
    clearButton.setWindow(controlPanel);
    clearListener = new ClearListener();
    clearButton.addListener(clearListener);
    
    // MIDI Output Devices List
    controlPanel.addTab("Midi");
    midiOutputDevicesList = controlObj.addScrollList("midiOutputDevicesList", 10, 40, 200, 150);
    midiOutputDevicesList.setLabel("MIDI Out");
    outputDeviceListener = new MidiOutputDeviceListener();
    for(int i=0 ; i<_numberOfOutputDevices; i++) {
      midiOutputDeviceButton = midiOutputDevicesList.addItem(midiIO.getOutputDeviceName(i), i);
      midiOutputDeviceButton.setId(100 + i);
      midiOutputDeviceButton.addListener(outputDeviceListener);
    }
    midiOutputDevicesList.setTab(controlPanel,"Midi");
    
    // MIDI Input Devices List
    controlPanel.addTab("Midi");
    midiInputDevicesList = controlObj.addScrollList("midiInputDevicesList", 220, 40, 200, 150);
    midiInputDevicesList.setLabel("MIDI In");
    inputDeviceListener = new MidiInputDeviceListener();
    for(int i=0 ; i<_numberOfInputDevices; i++) {
      midiInputDeviceButton = midiInputDevicesList.addItem(midiIO.getInputDeviceName(i)+"in", i);
      midiInputDeviceButton.setId(100 + i);
      midiInputDeviceButton.addListener(inputDeviceListener);
    }
    midiInputDevicesList.setTab(controlPanel,"Midi");

    // MIDI Channel
    midiChannelScrollList = controlObj.addScrollList("midiChannelScrollList", 430, 40, 100, 150);
    midiChannelScrollList.setLabel( "Channel" );
    midiChannelScrollList.setTab(controlPanel, "Midi");
    channelListener = new MidiChannelListener();
    for(int i=0; i<16; i++) {
      controlP5.Button midiChannelButton = midiChannelScrollList.addItem("Channel "+(i+1),i);
      midiChannelButton.addListener(channelListener);
    }
  }
  
  
  
  
  
  
  
  
  
  
  
