 import processing.opengl.*;
import javax.media.opengl.*;
import toxi.geom.*;
import toxi.color.*;

boolean capture = false;
int frameCounter = 0;

boolean explode = false;
boolean implode = false;

int kill = 200;

int NUM = 800;

ArrayList particles;

PImage loaded_img;

GL gl;


  float weight = 0;
  float t = 0;
  float tt = 0;
  float wave = -1.0;
void setup()
{
  loaded_img = loadImage("particle.png");
  particles = new ArrayList();
  frameRate(30);
  size(1024,768,OPENGL);
  gl=((PGraphicsOpenGL)g).gl;
  imageMode(CENTER);
  
  for(int i = 1;i<= NUM;i++) {
     particles.add(new Particle());
  }
  
  implode = false;
  explode = true;
}

void draw()
{
  if(frameCount % 60000 == 0) {
   println("changing...");
   implode = !implode;
   explode = !explode; 
  }
  
  if(particles.size() < NUM) {
    for(int i = 0;i<= NUM-particles.size();i++) {
     particles.add(new Particle());
    }
  }
  
  background(0);
  stroke(0);
  fill(255);
  text((int)frameRate + " fps",10,20);
  text("count: " + particles.size(),10,40);
  translate(width/2,height/2);
  
  if(explode) {
    t = t + 1;
    tt = tt + 1;
  }
  if (implode) {
    t = t + 1;
    tt = tt - 1;
  }
  
  for (int i = particles.size()-1; i >= 0; i--) { 
    Particle p = (Particle) particles.get(i);
    p.update();
    if((p.m.x > (width/2 + p.p_size)) || (p.m.y > (height/2 + p.p_size)) || (p.m.x < -(width/2 + p.p_size)) || (p.m.y < -(height/2 + p.p_size))) {
      particles.remove(i);
    }
  }
    
  wave = sin((t-1.6)*0.0033) + tt*0.0003 - 1.3;
  
  if(wave < -1.0) {
    wave = -1.0;
  }
  weight = map(wave,-1,1,0,0.8);
  //println(t + " " + wave);

  
  // Define the blend mode

  //gl.glBlendFunc(GL.GL_SRC_ALPHA,GL.GL_ONE);
  //gl.glBlendFunc(GL.GL_DST_COLOR,GL.GL_ZERO);
for (int i = particles.size()-1; i >= 0; i--) { 
    Particle p = (Particle) particles.get(i);
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

 if(capture) {
    saveFrame("screen-" + nf(frameCounter,6) + ".tif");
    println("saved frame " + nf(frameCounter,6));
    frameCounter++;
  }
}

void keyPressed() {
  if(key == ' '){

  }
  
  if(key == 'k'){
    for(int i = 0; i < kill; i++)
    { 
      Particle p = (Particle) particles.get((int)random(0,particles.size()-1));
      p.kill = (int)random(7,25);
    }
  }
  
  if(key == 'c'){
    // capture != capture;
    if(capture) {
      capture = false; 
    } else {
      capture = true;
    }
  }
  
  if(key == 'e'){
    explode = true;
    implode = false;
  }
  
  if(key == 'i') {
    implode = true;
    explode = false;
}
}
