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
float[] xs={};
float[] ys={};
int sw3;
int timer=0;
boolean incTimer=false;
float[] particlesX={};
float[] particlesY={};
float[] particlesDX={};
float[] particlesDY={};
//float[] newList;
//int[] newListInt;
int[] particlesIntensity={};

float[] add(float[] list,float a) {
  int n=list.length+1;
  float newList[] = new float[n];
  for (int i=0;i<list.length;i++) {
    newList[i]=list[i];
  }
  newList[list.length]=a;
  return newList;
}

float[] remove(float[] list,int idx) {
  int n=list.length-1;
  float newList[]=new float[n];
  for (int i=0;i<idx;i++) {
    newList[i]=list[i];
  }
  for (int i=idx+1;i<list.length-1;i++) {
    newList[i]=list[i];
  }
  return newList;
}

int[] addInt(int[] list,int a) {
  int n=list.length+1;
  int newListInt[]=new int[n];
  for (int i=0;i<list.length;i++) {
    newListInt[i]=list[i];
  }
  newListInt[list.length]=a;
  return newListInt;
}

int[] removeInt(int[] list,int idx) {
  int n=list.length-1;
  int newListInt[]=new int[n];
  for (int i=0;i<idx;i++) {
    newListInt[i]=list[i];
  }
  for (int i=idx+1;i<list.length-1;i++) {
    newListInt[i]=list[i];
  }
  return newListInt;
}

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
    xs=new float[0];
    ys=new float[0];
    xs=add(xs,x);
    ys=add(ys,y);
   
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
      xs=add(xs,nX);
      ys=add(ys,nY);
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
      line(xs[i],ys[i],xs[i+1],ys[i+1]);
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
    particlesX=add(particlesX,(float)mouseX);
    particlesY=add(particlesY,(float)mouseY);
    particlesDX=add(particlesDX,(float)(Math.random()-0.5)*10);
    particlesDY=add(particlesDY,(float)(Math.random()-0.5)*2);
    particlesIntensity=addInt(particlesIntensity,255);
    //fill(0);
    //noStroke();
    //circle(50,50,50);
  }
  for (int i=0;i<particlesX.length;i++) {
    particlesX[i]=particlesX[i]+particlesDX[i];
    particlesY[i]=particlesY[i]+particlesDY[i];
    float __x=particlesX[i];
    float __y=particlesY[i];
    particlesIntensity[i]=particlesIntensity[i]-3;
    if (__x>width||__x<0||__y>height||__y<0||particlesIntensity[i]<3) {
      particlesX=remove(particlesX,i);
      particlesY=remove(particlesY,i);
      particlesDX=remove(particlesDX,i);
      particlesDY=remove(particlesDY,i);
      particlesIntensity=removeInt(particlesIntensity,i);
      continue;
    }
    fill(255,255,255,particlesIntensity[i]); //cleared before end o frame
    circle(particlesX[i],particlesY[i],10);
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
