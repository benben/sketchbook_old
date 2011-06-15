import processing.opengl.*;

float x,y;

void setup() {
  size(1280,720,OPENGL);
  smooth();
}

void draw() {
  background(0);
  text(frameRate + " fps",10,10);  
  
  
  pushMatrix();
  translate(width/2,height/2);
  y = map(mouseX,0,width,TWO_PI,0);
  x = map(mouseY,0,height,TWO_PI,0);
  rotateY(y);
  rotateX(x);
  //x
  stroke(255,0,0);
  line(-200,0,0,200,0,0);
  //y
  stroke(0,255,0);
  line(0,-200,0,0,200,0);
  //z
  stroke(0,0,255);
  line(0,0,-200,0,0,200);
  
  popMatrix();

}
