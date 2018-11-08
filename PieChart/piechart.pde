float frames = 100;
float time = 0;

float[] data1 = { random(255), random(255),random(255), random(255) };
float[] data2 = {random(255),random(255), random(255), random(255) };
char[] categories = {'A', 'B', 'C', 'D'};

float pctColor = 0.0;
boolean forward = true; 

void setup() {
  size(640, 360, P3D);
  noStroke();
  //noLoop();  // Run once and stop
}

void draw() {
  background(100);
  pieChartTransition(300, time, frames, data1, data2);
  
  if (forward == true) time++;
  else time -=1;
}

void pieChart(float diameter, int[] data) {
  float lastAngle = 0;
  ArrayList<Float> angles = new ArrayList<Float>();
  float total = 0; 
  
  // Calc totals
  for (int i = 0; i < data.length; i++) {
    float _data = data[i];
    total += _data;
  }
  
  // Convert data to angles
  for (int i = 0; i < data.length; i++) {
    float _data = data[i];
    float pct = _data / total;
    float angle = pct * 360.0;
    angles.add(angle);
    
    
  }
  
   
  
  for (int i = 0; i < angles.size(); i++) {
    float gray = map(i, 0, angles.size(), 0, 255);
    fill(gray);
    arc(width/2, height/2, diameter, diameter, lastAngle, lastAngle+radians(angles.get(i)));
    
    
    
    lastAngle += radians(angles.get(i));
  }
}

void pieChartTransition(float diameter, float time, float frames, float[] data1, float[] data2) {
  float lastAngle = 0;
  ArrayList<Float> angles = new ArrayList<Float>();
  float total1 = 0;
  float total2 = 0;
  
  // Calc totals
  for (int i = 0; i < data1.length; i++) {
    float _data = data1[i];
    total1 += _data;
  }
  
  for (int i = 0; i < data2.length; i++) {
    float _data = data2[i];
    total2 += _data;
  }
  
  // Keep track of time passing
  float pctComplete = time / frames;
  
  if (pctComplete >=1.0) {
    
    forward = false;
    //pctComplete = 1.0;
    
  }
  
  if (pctComplete == 0.0) {
  
    forward = true;
  }
  
  // Initialize some lists to store interpolated data
  ArrayList<Float> lerp_data = new ArrayList<Float>();
  ArrayList<Float> lerp_totals = new ArrayList<Float>();
  
  // Create the interpolated data
  for (int i = 0; i < data1.length; i++) {
    
    // Add interpolated values
    float lerped = lerp(data1[i], data2[i], pctComplete);
    lerp_data.add(lerped);
   
    // Add interpolated totals (to calc percentages)
    float lerped_total = lerp(total1, total2, pctComplete);
    lerp_totals.add(lerped_total);
  }
  
  // Convert data to angles (i.e. 360 degrees)
  for (int i = 0; i < lerp_data.size(); i++) {
    
    float _data = lerp_data.get(i);
    float _total = lerp_totals.get(i);
    float pct = _data / _total;
    float angle = pct * 360.0;
    angles.add(angle);
    
  }
  
  // Draw arcs
  for (int i = 0; i < angles.size(); i++) {
    
    float pctColor = map(i, 0, angles.size(), 0, 1);
    fill(pctColor * 255, pctColor * 10, pctColor * 255);
    
    arc(width/2, height/2, diameter, diameter, lastAngle, lastAngle+radians(angles.get(i)));
    
    
    
    lastAngle += radians(angles.get(i));
    
    
  }
}