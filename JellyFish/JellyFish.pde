void setup() { 
  size(1000,1000);
  smooth();
  background(0);
  stroke(255,5);
}
void draw() {
  scale(1.2); noiseDetail(3,0.7);
  for(int i=0;i<10000;i++) {
    float x = random(-1,1);
    float y = random(-1,1);
    float xx = map(noise(x,y),0,1, 20,width-20);
    float yy = map(noise(y,x),0,1, 20,height-20);
    point(xx,yy);
  }
}

void mousePressed() {
  saveFrame();
}