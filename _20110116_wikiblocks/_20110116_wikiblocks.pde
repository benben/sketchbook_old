import processing.opengl.*;

int boxWidth = 10;

void setup() {
  size(1280,720,OPENGL);
  hint(ENABLE_OPENGL_4X_SMOOTH);
  strokeWeight(2);
  smooth();
}

void draw() {
  background(255);
  translate(width/2,height,-500);
  //rotateY(PI/4);
  rotateX(PI/4);
  rotateZ(PI/4);
  for(int x = 0; x < 150; x++) {
    pushMatrix();
    translate(-x*boxWidth,0,0);
    for(int y = 0; y < 150; y++) {
      pushMatrix();
      translate(0,-y*boxWidth,0);
      for(int z = 0; z < 150; z++) {
        pushMatrix();
        translate(0,0,-z*boxWidth);
        fill(0,255,0);
        box(boxWidth);
        popMatrix();
      }
      popMatrix();
    }
    popMatrix();
  }
}
