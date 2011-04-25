class Particle {
  
  float start = random(TWO_PI);
  Vec2D m = new Vec2D(sin(start), cos(start));
  float speed = random(0.005,0.018);
  float j = random(0.05,0.1); //0.0994;
  float k = random(0.05,0.1); //0.0576;
  float l = random(0.02,0.05); //0.0341;
  
  float J = random(0,60);
  float K = random(0,80);
  float L = random(0,30);
  
  int p_size = (int)random(20,90);
  
  int kill = 0;
  int mm = 0;
  
  float e = 0;
  int frameStart = frameCount;
  int a = 0;
  TColor C;
  float[] c = C.hsvToRGB(random(0,1),1.0,1.0);
  
  Particle () {
  }
  
  void update () {
    start += speed;
    m.x = sin(start);
    m.y = cos(start);
    
    
    mm += kill;
    
    m.normalizeTo(mm + (sin(frameCount * j) * J) * weight + (cos(frameCount * k) * K) * weight + (sin(frameCount * l) * L) * weight);

    if(a < 255) {
      a = (frameCount - frameStart)*50;
    } else {
      a = 255;
    }
    
    if(mm < 250) {
      mm += 20;
    }
  }
  
  void draw () {
    tint(255 - map(c[0],0,1,0,255) * weight, 255 - map(c[1],0,1,0,255) * weight, 255 - map(c[2],0,1,0,255) * weight, a); 
    image(loaded_img,m.x - loaded_img.width/2,m.y - loaded_img.height/2,p_size,p_size);
  }
}
