import processing.opengl.*;

import toxi.geom.*;
import toxi.math.waves.*;
import toxi.geom.mesh.*;

TriangleMesh mesh=new TriangleMesh("doodle");

Vec3D prev=new Vec3D();
Vec3D p=new Vec3D();
Vec3D q=new Vec3D();

Vec2D rotation=new Vec2D();

float weight=0;
AbstractWave rX, rY, tY, tZ;

PointCloud points = new PointCloud();

void setup() {
  size(1280,720,OPENGL);
  float step = (180/PI)*0.0001;
  rX = new SineWave(0, step, height*0.4, 0);
  rY = new SineWave(HALF_PI, step, height*0.4, 0);
  tY = new SineWave(0, step*36, 20, 0);
  tZ = new SineWave(0, step*36, 20, 0);
}

void draw() {
  background(0);
  lights();
  translate(width/2,height/2,0);
  noStroke();
  rotateX(mouseY * 0.01f);
  rotateY(mouseX * 0.01f);
  drawAxes(400);
  beginShape(TRIANGLES);
  // iterate over all faces/triangles of the mesh
  for(Iterator i=mesh.faces.iterator(); i.hasNext();) {
    TriangleMesh.Face f=(TriangleMesh.Face)i.next();
    // create vertices for each corner point
    //vertex(f.a);
    //vertex(f.b);
    //vertex(f.c);
  }
  endShape();
  
  Vec3D test = new Vec3D(rX.update(),rY.update(),0);
  Vec3D t1 = new Vec3D(0,tY.update(),tZ.update());
  test.addSelf(t1);
  
  points.addPoint(test);
  

  
  for(Iterator i=points.iterator(); i.hasNext();) {
    Vec3D v =(Vec3D)i.next();
    //line(v.x,v.y,v.z,n.x,n.y,n.z);
    stroke(255);
    point(v.x,v.y,v.z);
  }
  //rotation.addSelf(0.014,0.0237);
  //UPDATE
  // get 3D rotated mouse position
  Vec3D pos=new Vec3D(-317/2,-307/2,0);
  pos.rotateX(rotation.x);
  pos.rotateY(rotation.y);
  // use distance to previous point as target stroke weight
  weight+=(sqrt(pos.distanceTo(prev))*2-weight)*0.1;
  // define offset points for the triangle strip
  Vec3D a=pos.add(0,0,weight);
  Vec3D b=pos.add(0,0,-weight);
  // add 2 faces to the mesh
  mesh.addFace(p,b,q);
  mesh.addFace(p,a,b);
  // store current points for next iteration
  prev=pos;
  p=a;
  q=b;
}

void vertex(Vec3D v) {
  vertex(v.x,v.y,v.z);
}

void drawAxes(float l) {
  stroke(255, 0, 0);
  line(0, 0, 0, l, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, l, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, l);
  noStroke();
}

void keyPressed() {
  if (key=='s') {
    mesh.saveAsOBJ(sketchPath("doodle.obj"));
    mesh.saveAsSTL(sketchPath("doodle.stl"));
  } 
  else {
    mesh.clear();
  }
}
