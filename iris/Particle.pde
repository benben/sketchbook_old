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

  float e = 0;
  int frameStart = frameCount;
  int a = 0;
  TColor C;
  float[] c = C.hsvToRGB(random(0,1),1.0,1.0);
  
  PImage img = loadImage("particle.png"); 
  
  Particle () {
  }
  
  void update () {
     
    

    
    
    /*if(explode) {
    if(e < 100) {
      e = e +25;
    } else {
      e = 100;
      explode = false;
    }
    }
 
     if(implode) {
      if(e > 0) {
        e = e - 1;
      } else {
        e = 0;
        implode = false;
      }
    } */
    start += speed;
    m.x = sin(start);
    m.y = cos(start);
        
    m.normalizeTo(250 + (sin(frameCount * j) * J) * weight + (cos(frameCount * k) * K) * weight + (sin(frameCount * l) * L) * weight);
    //println("weight: " + weight);
    if(a < 255) {
      a = frameCount - frameStart;
    } else {
      a = 255;
    }
  }
  
  void draw () {
    //fill(col.toARGB());
    //gl.glColor(col.toHSVAArray(col));
    /*for(int i = 0; i < 20; i++) {
    fill(255,255,255,(1/pow(i,2)*1000)-2.3);
    ellipseMode(CENTER);
    ellipse(m.x,m.y,(i*i*i*i)*0.0008,(i*i*i*i)*0.0008);
    }*/
    //noFill();
    //ellipse(m.x,m.y,20,20);
    //tint(255, 255, 255, a);
    //println(c[0] + " - " + c[1] + " - " + c[2]);
    tint(255 - map(c[0],0,1,0,255) * weight, 255 - map(c[1],0,1,0,255) * weight, 255 - map(c[2],0,1,0,255) * weight, a); 
    image(img,m.x - img.width/2,m.y - img.height/2,p_size,p_size);
  }
}
