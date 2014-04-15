int shakeNum = 1000;
ArrayList ms;
Sphere one;
//PImage grid;
////////////////////////////////////////////////
 
void setup(){
  size(500,400,P3D);
 
//  grid = loadImage("grid.png");
  one = new Sphere(new PVector(width/2,height/2,0),200,color(255));
 
  ms = new ArrayList();
 
 
  for(int i = 0 ; i < shakeNum ; i ++){
    ms.add(new MicroShake(i,random(1,2),random(4,200)));
  }
  // as always
  noiseSeed(19);
 
  colorMode(HSB);
}
 
 
////////////////////////////////////////////////
 
void draw(){
  background(0);
  int x = (int)random(3);
  int y = (int)random(3);
 
  // blend(grid,0,0,width,height,-x,-y,width+x,height+y,ADD);
 
  for(int i = 0 ; i < ms.size();i++){
    MicroShake tmp = (MicroShake)ms.get(i);
    tmp.shake();
  }
  one.draw();
}