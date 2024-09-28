import java.util.ArrayList;
import java.lang.Float;
import java.lang.Integer;
float x=width/2;
float y=5;
float nX;
float nY;
float targetX;
float targetY;
int l=0;
double d=10000;
float bg=0;
float wobbliness=2;
ArrayList<Float> xs=new ArrayList<Float>();
ArrayList<Float> ys=new ArrayList<Float>();
int sw3;
int timer=0;
boolean incTimer=false;
ArrayList<Float> particlesX=new ArrayList<Float>();
ArrayList<Float> particlesY=new ArrayList<Float>();
ArrayList<Float> particlesDX=new ArrayList<Float>();
ArrayList<Float> particlesDY=new ArrayList<Float>();
ArrayList<Integer> particlesIntensity=new ArrayList<Integer>();

void setup() {
  size(400, 400);
  x=width/2;
  frameRate(120);
}

void unit(boolean recalculate) {
  //scale(mouseX/width); 
  if (recalculate) {
    targetX=mouseX;
    targetY=mouseY;
    x=width/2;
    y=5;
    nX=x;
    nY=y;
    l=0;
    d=10000;
    xs.clear();
    ys.clear();
    xs.add(x);
    ys.add(y);
   
    while (l<2000&&d>2) {
      float m=10;
      if (d<10) {
        m=0;
      }
      nX=x+(float)((Math.random()-0.5)*m);
      nY=y+(float)((Math.random()-0.5)*m);
      d=Math.sqrt((sq(nY-targetY)+sq(nX-targetX)))/wobbliness;
      nX=lerp(nX,targetX,(float)(1/(d+1)));
      nY=lerp(nY,targetY,(float)(1/(d+1)));
      xs.add(nX);
      ys.add(nY);
      //gradientLine(x, y, nX, nY);
      x=nX;
      y=nY;
      l++;
    }
  }
  
  int sw=1;
  int sw2=1;
  for (int _i=0;_i<20/sw2;_i++) {
    for (int i=0;i<l;i++) {
      //strokeWeight(sw3*sw2-(sw3/20.0)*_i*sw2);
      strokeWeight(20*sw2-_i*sw2);
      //stroke(255-(20-sw-_i)*255/10, 255-(20-sw-_i)*255/6, 255-(20-sw-_i)*255/20);
      float[] center={(sw3+400)*255/400,(sw3+400)*255/400,(sw3+400)*255/400};
      float[] outside={lerp(-255,255,bg/255.0),lerp(-595,255,bg/255.0),lerp(0,255,bg/255.0)};
      float t=(20.0-sw-_i)/20.0;
      color middle=color(
      lerp(center[0],outside[0],t),
      lerp(center[1],outside[1],t),
      lerp(center[2],outside[2],t));
      //System.out.println(middle);
      stroke(middle);
      line(xs.get(i),ys.get(i),xs.get(i+1),ys.get(i+1));
    }
  }
  
  //System.out.println("test");
  fill(255);
  noStroke();
  text(Float.toString(wobbliness),50,50);
  text(Integer.toString(sw3),75,50);
}

void draw() {
  background(lerp(-255,255,bg/255.0),lerp(-595,255,bg/255.0),lerp(0,255,bg/255.0));
  if (mousePressed) {
    sw3=400;
    particlesX.add((float)mouseX);
    particlesY.add((float)mouseY);
    particlesDX.add((float)(Math.random()-0.5)*10);
    particlesDY.add((float)(Math.random()-0.5)*2);
    particlesIntensity.add(255);
    //fill(0);
    //noStroke();
    //circle(50,50,50);
  }
  for (int i=0;i<particlesX.size();i++) {
    particlesX.set(i,particlesX.get(i)+particlesDX.get(i));
    particlesY.set(i,particlesY.get(i)+particlesDY.get(i));
    float __x=particlesX.get(i);
    float __y=particlesY.get(i);
    particlesIntensity.set(i,particlesIntensity.get(i)-3);
    if (__x>width||__x<0||__y>height||__y<0||particlesIntensity.get(i)<3) {
      particlesX.remove(i);
      particlesY.remove(i);
      particlesDX.remove(i);
      particlesDY.remove(i);
      particlesIntensity.remove(i);
      continue;
    }
    fill(255,255,255,particlesIntensity.get(i)); //cleared before end o frame
    circle(particlesX.get(i),particlesY.get(i),10);
  }
  if (sw3>-400) {
    sw3-=20;
    bg=sw3*255/400;
    
    unit(sw3==380);
  }
  //for (int i=0;i<particlesX.size();i++) {
}

void keyPressed() {
  if (key=='a') {
    wobbliness+=0.1;
  }
  if (key=='d') {
    wobbliness-=0.1;
  }
  //unit();
}
