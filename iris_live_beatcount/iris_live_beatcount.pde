 import processing.opengl.*;
import javax.media.opengl.*;
import toxi.geom.*;
import toxi.color.*;


int NUM = 5000;
int count = 0;
ArrayList particles;

GL gl;


import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
BeatDetect beat;
BeatListener bl;

AudioInput in;
AudioPlayer song;

float kickSize, snareSize, hatSize;

void setup()
{
  frameRate(30);
  size(1280,720,OPENGL);
  gl=((PGraphicsOpenGL)g).gl;
  imageMode(CENTER);
  particles = new ArrayList();
  
  
   minim = new Minim(this);
  minim.debugOn();
  
  in = minim.getLineIn(Minim.STEREO, 512);
  song = minim.loadFile("marcus_kellis_theme.mp3", 2048);
  song.play();
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  beat.setSensitivity(300);  
  kickSize = snareSize = hatSize = 16;
  // make a new beat listener, so that we won't miss any buffers for the analysis
  bl = new BeatListener(beat, song);  
}

void draw()
{
   /*
  if(frameCount % 1 == 0) {
    particles.add(new Particle());
    particles.add(new Particle());
    particles.add(new Particle());
    particles.add(new Particle());
  }*/
  background(0);
  stroke(0);
  fill(255);
  text((int)frameRate + " fps",10,20);
  text("count: " + particles.size(),10,40);
  
  for (int i = particles.size()-1; i >= 0; i--) { 
    // An ArrayList doesn't know what it is storing so we have 
    // to cast the object coming out
    Particle p = (Particle) particles.get(i);
    p.update();
    gl.glEnable(GL.GL_BLEND);
    gl.glDisable(GL.GL_DEPTH_TEST);
    //print(p[i].m.magnitude() + " - ");
    //m = map(p[i].m.magnitude(),250,350,0,1);
    //println(m);
    //c.newHSVA(1.0,1.0,m,1.0);
    //gl.glBlendColor(1.0,1.0,0.0,1.0);
    gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE);
    //gl.glBlendFunc( GL.GL_ZERO, GL.GL_DST_ALPHA );
    
    //gl.glBlendFuncSeparate(GL.GL_DST_ALPHA, GL.GL_ONE_MINUS_CONSTANT_COLOR, GL.GL_DST_ALPHA, GL.GL_DST_ALPHA );
    p.draw();
    gl.glDisable(GL.GL_BLEND);
  }
  
  fill(255);
  if ( beat.isKick() ) {
    rect(10,10,20,20);
    for(int i = 0; i < 10; i++) {
      particles.add(new Particle(0));
    }
  }
  
  if ( beat.isSnare() ) {
    //rect(10,10,20,20);
    for(int i = 0; i < 20; i++) {
      particles.add(new Particle(1));
    }
  }
  
  if ( beat.isHat() ) {
    //rect(10,10,20,20);
    for(int i = 0; i < 60; i++) {
      particles.add(new Particle(2));
    }
  }
  for (int i = particles.size()-1; i >= 0; i--) { 
      Particle p = (Particle) particles.get(i);
      if (p.x > width+p.p_size) {
      // Items can be deleted with remove()
      particles.remove(i);
    }
  }
}

void keyPressed() {

}

void stop()
{
  // always close Minim audio classes when you are finished with them
  song.close();
  in.close();
  // always stop Minim before exiting
  minim.stop();
  // this closes the sketch
  super.stop();
}
