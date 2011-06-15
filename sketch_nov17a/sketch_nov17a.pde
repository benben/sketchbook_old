int parts = 10;
int partLength;

Liner[] l = new Liner[parts];

void setup() {
  size(1600,300,P2D);
  frameRate(25);
  textMode(SCREEN);
  smooth();
  partLength = width / parts;
  for(int i = 0; i < parts; i++) {
    l[i] = new Liner();
  }
}

void draw() {
  background(0);
  stroke(255);
  //fill(#ff0000);
  text((int)frameRate + " fps",10,20);
  noFill();
  for(int i = 0; i < parts; i++) {
      l[i].update();
      l[i].draw();
  }
  
  println("capturing frame " + frameCount);
  saveFrame("screen-" + parts + ".png");
  //saveFrame("screen-" + nf(frameCount,6) + ".tif");
}

class Liner {
  Point[] p = new Point[parts];
 
  Liner() {
    
   for(int i = 0; i < parts; i++) {
     p[i] = new Point();
     println(i + " * " + width);
     p[i].x = i*partLength + partLength/2 + random(-parts,parts); // + partLength/2; 
   }
  } 
  
  void update() {
   for(int i = 0; i < parts; i++) {
     p[i].update(); 
   }
  }
  
  void draw() {
   for(int i = 0; i < parts; i++) {
     p[i].draw(); 
   }
   
   for(int i = 0; i < parts-1; i++) {
     line(p[i].x,p[i].y,p[i+1].x,p[i+1].y);
   }
   
  }
 
}

class Point {
    float x;
    float y;
    float dy;
 
  Point() {
    y = random(1,height);
    dy = random(-1,1) * random(parts,parts*2);
  }
  
  void update() {
    if(y >= height) {
      dy *= -1;
    }
    if(y <= 0) {
      dy *= -1;
    }
    y += dy;
  }
  
  void draw() {
    //ellipse(x,y,20.0,20.0);
  }
}
