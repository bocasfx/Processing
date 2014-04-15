////////////////////////////////////////////////
 
/*
 * camera shaker class
 */
 
class MicroShake{
 
  float amp;
  float speed;
  int id;
 
  MicroShake(int id,float _amp,float _speed){
    amp = _amp;
    speed = _speed;
  }
 
  void shake(){
    translate(
        (0.5-noise((id*1.0+frameCount)/speed,0,0))*amp,
        (0.5-noise(0,(id*1.0+frameCount)/speed,0))*amp,
        (0.5-noise(0,0,(id*1.0+frameCount)/speed))*amp
        );
  }
 
}