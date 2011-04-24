import processing.core.*; 
import processing.xml.*; 

import mpe.client.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class n0 extends PApplet {



int parts = 100;
int partLength;
int count = 0;
int interval = 500;
int dc = 1;
boolean flip = false;

Liner[] l = new Liner[parts];

TCPClient client;

public void setup() {
  //size(2400,600,P2D);
  client = new TCPClient(sketchPath("mpe.ini"), this);
  size(client.getLWidth(), client.getLHeight(), P2D);
  //frameRate(25);
  //textMode(SCREEN);
  //smooth();
  colorMode(HSB,255,255,255);
  //strokeWeight(1);
  //partLength = width / (parts);
  count = 3;
  randomSeed(1);
  client.start();
}

//void draw() {
public void frameEvent(TCPClient c) {  
  if (frameCount % interval == 0)
  {
    l[(count-3)%parts] = new Liner(count);
    if(count == parts) {
      dc *= -1;
      flip = !flip;
    }
    if(dc < 0) {
      if(count-3 == 0) {
        dc *= -1;
      }
    }
    count = count + dc;
    println(count);
  }
  //println(count);
  background(0);
  stroke(255);
  //fill(#ff0000);
  text((int)frameRate + " fps",10,20);
  noFill();
  int t = count-3;
  if(count-3 > parts) {
    t = parts;
  }
  if(!flip) {
  for(int i = 0; i < t; i++) {
      l[i].update();
      l[i].draw();
  }
  } else {
      for(int i = 0; i < count-3; i++) {
      l[i].update();
      l[i].draw();
  }
  }
  //println("capturing frame " + frameCount);
  //saveFrame("screen-" + parts + ".png");
  //saveFrame("screen-" + nf(frameCount,6) + ".tif");
}

class Liner {
  Point[] p; // = new Point[count];
  int c = (int)random(0,255);
  int s = 0;
  int liner_count = 0;
  int liner_partLength = 0;
  PVector p0 = new PVector();
  PVector p1 = new PVector();
 PVector p2 = new PVector();

  Liner(int _liner_count) {
   liner_count = _liner_count;
   s = (int)map(liner_count,0,parts,0,255);
   liner_partLength = client.getMWidth() / (liner_count-2);
   p = new Point[liner_count];
   for(int i = 0; i < liner_count; i++) {
     p[i] = new Point();
     //println(i + " * " + width);
     p[i].x = (i-1)*(liner_partLength*2);// +random(-parts,parts); // - partLength/2 + random(-parts,parts); // +partLength/2;
   }
  }

  public void update() {
   for(int i = 0; i < liner_count; i++) {
     p[i].update();
   }
  }

  public void draw() {
   for(int i = 0; i < liner_count; i++) {
     p[i].draw();
   }

   for(int i = 1; i < liner_count-1; i++) {
     //line(p[i].x,p[i].y,p[i+1].x,p[i+1].y);
     stroke(c,s,255);
     p0.x = p[i].x;
     p0.y = p[i].y;
     p1.x = p[i-1].x;
     p1.y = p[i-1].y;
     p2.x = p[i+1].x;
     p2.y = p[i+1].y;
     p1.add(p0);
     p2.add(p0);
     p1.div(2);
     p2.div(2);
     bezier(p1.x, p1.y ,     p[i].x, p[i].y     ,     p[i].x ,p[i].y       ,p2.x , p2.y);
   }

  }

}

class Point {
    float x;
    float y;
    float dy;

  Point() {
    y = random(1,client.getMHeight());
    dy = random(-1,1) * random((count+1)/8,(count+1)/4);
  }

  public void update() {
    if(y >= client.getMHeight()) {
      dy *= -1;
    }
    if(y <= 0) {
      dy *= -1;
    }
    y += dy;
  }

  public void draw() {
    //ellipse(x,y,20.0,20.0);
  }
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--hide-stop", "n0" });
  }
}
