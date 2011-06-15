import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.math.*;
import toxi.volume.*;
import toxi.processing.*;

ToxiclibsSupport gfx;

int SIZE = 100;
int RES = 10;

float surface[][] = new float[SIZE][SIZE];

void setup() {
  size(680, 382, P3D);
  gfx=new ToxiclibsSupport(this);

}

void draw() {
  background(0);
  translate(width / 2, height / 2, 0);
  rotateX(mouseY * 0.01f);
  rotateY(mouseX * 0.01f);
  stroke(255);
  for(int i = 0; i < SIZE; i++) {
    for(int j = 0; j < SIZE; j++) {
      point(i*10,j*10,surface[i][j]);
    }
  }
  
  gfx.origin(new Vec3D(),100);
}
