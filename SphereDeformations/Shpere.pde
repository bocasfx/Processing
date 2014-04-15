/*
 * deformed sphere class
 *
 */
 
////////////////////////////////////////////////
class Sphere{
  PVector pos;
  float radius;
  float density;
  color c;
 
  Sphere(PVector _pos, float _rad,color _c){
    pos = new PVector(_pos.x,_pos.y,_pos.z);
    radius = _rad;
    density = 20.0;
    c = _c;
  }
 
  void draw(){
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
     
    float d = noise(frameCount/300.0)*3000.0;
    density = noise(frameCount/313.0)*5.0+3.0;
 
    rotateX(frameCount/30.0);
    rotateY(frameCount/900.0);
    for(float f = -180 ; f < d; f += density){
      for(float ff = -90 ; ff < 90; ff += density){
         
        c = color(map(f,0,d,0,60),200,180);
        stroke(c,120);
        float x = cos(radians(f))*radius*cos(radians(ff));
        float y = sin(radians(f))*radius*cos(radians(ff));
        float z = sin(radians(ff))*radius;
        float deform = noise((frameCount+lerp(f,ff,noise((frameCount+ff)/222.0)))/300.0)*1.33;
 
        // strokeWeight(map(abs(modelZ(x,y,z)),100,0,1,4));
 
 
        point(x*deform,y*deform,z*deform);
         
      }
    }
 
    axis();
    popMatrix();
  }
 
  void axis(){
    stroke(255,20);
    strokeWeight(3);
    line(-200,0,0,200,0,0);
    line(0,-200,0,0,200,0);
    line(0,0,-200,0,0,200);
 
  }
 
}