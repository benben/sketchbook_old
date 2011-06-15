import processing.opengl.*;

void setup() {
  size(1280,720,OPENGL);
hint(ENABLE_OPENGL_2X_SMOOTH);
}

void draw() {
 background(128);
 translate(width/2, height/2, 0); 
 strokeWeight(5);
rotateX(mouseY*-0.01);
rotateY(mouseX*-0.01);
box(200);
}
