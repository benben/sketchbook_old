import processing.opengl.*;


PVector[] p = new PVector[10000];
float x,y,z;
float s = 0.01;


void setup() {
  size(1280,720,OPENGL);
  smooth();
  lights();
  
  p[0] = new PVector(0.1,0,0);
  for(int i = 1; i < p.length; i++) {
    x = 9 * (p[i-1].y - p[i-1].x);
    y = p[i-1].x * (58 - p[i-1].z) - p[i-1].y;
    z = p[i-1].x * p[i-1].y - (8/3) * p[i-1].z;
    
    p[i] = new PVector(x * s,y* s,z* s);
    p[i].add(p[i-1]);
    
  }
}

void draw() {
  background(0);
  text(frameRate + " fps",10,10);  

  pushMatrix();
  translate(width/2,height/2,500);
  rotateX(map(mouseY,0,height,TWO_PI,0));
  rotateY(map(mouseX,0,width,TWO_PI,0));
  //x
  stroke(255,0,0);
  line(-200,0,0,200,0,0);
  //y
  stroke(0,255,0);
  line(0,-200,0,0,200,0);
  //z
  stroke(0,0,255);
  line(0,0,-200,0,0,200);
  
  
  
  for(int i = 1; i < p.length; i++) {  
   stroke(255,255,255); 
    point(p[i].x,p[i].y,p[i].z);
    stroke(100,100,100);
    //line(p[i-1].x,p[i-1].y,p[i-1].z,p[i].x,p[i].y,p[i].z);
  }
  
  popMatrix();
}

