import toxi.math.waves.*;

class Particle {  
  float x = 0;
  float y = random(0,height);
  
  float dx = random(7,7);
  
  
  int p_size = (int)random(10,100);
  
  PVector c = new PVector(random(255),random(255),random(255));
  
  AbstractWave waveX=createRandomWave();
  AbstractWave waveY=createRandomWave();

  float a = 0;
  int start_a;
  int frameStart = frameCount;
  PImage img = loadImage("particle.png"); 
  
  Particle (int type) {
    switch(type) {
      case 0: 
        //println("BASS");  // Does not execute
        
        p_size = (int)random(100,300);
        start_a = 40;
        a = 40;
      break;
      case 1: 
        //println("SNARE");  // Prints "Bravo"
        p_size = (int)random(80,150);

        start_a= 100;
        a = 100;
      break;
      case 2:
        //println("HAT");   // Does not execute
        p_size = (int)random(10,70);

        start_a = 255;
        a = 255;
      break;
    }
  }
  
  void update () {
    dx += 0.08*((x/1000)*(x/1000));
    x += dx + waveX.update();
    y += waveY.update() + waveX.update();
    
    
    if(a > 0) {
      if((width -x)*0.25 <= start_a) {
      a = (int)(width - (int)x)*0.25;
      }
    }
    //a = 255;
  }
  
  void draw () {
    tint(c.x, c.y, c.z, a); 
    image(img,x,y,p_size,p_size);
  }
}

AbstractWave createRandomWave() {
  AbstractWave w=null;
  AbstractWave fmod=new SineWave(0, random(0.005, 0.02), random(0.1, 0.5), 0);
  float freq=random(0.005, 0.05);
  switch((int)random(7)) {
  case 0:
    w = new FMTriangleWave(0, freq, 1, 0, fmod);
    break;
  case 1:
    w = new FMSawtoothWave(0, freq, 1, 0, fmod);
    break;
  case 2:
    w = new FMSquareWave(0, freq, 1, 0, fmod);
    break;
  case 3:
    w = new FMHarmonicSquareWave(0, freq, 1, 0, fmod);
    ((FMHarmonicSquareWave)w).maxHarmonics=(int)random(3,30);
    break;
  case 4:
    w = new FMSineWave(0, freq, 1, 0, fmod);
    break;
  case 5:
    w = new AMFMSineWave(0, freq, 0, fmod, new SineWave(0, random(0.01,0.2), random(2, 3), 0));
    break;
  case 6:
    w = new ConstantWave(random(-1,1));
    break;
  }
  return w;
}
