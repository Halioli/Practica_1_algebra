// acd 2014
// forum.processing.org/two/discussion/3633/runge-kutta-troubleshooting
 
import processing.opengl.*;
//import peasy.*;
 
static final int TIMESPAN = 10000;
static final int COLOURS = 1000;
 
static final double h = 0.005;
static final double sigma = 10.0;
static final double r = 28.0;
static final double b = 8.0 / 3.0;
 
PVector[] pos = new PVector[TIMESPAN];
 
 
void setup() {
  size(500,500, P3D);
  int i = 0;
  pos[i] = new PVector(5, 5, 5);
  //println("p[" + i + "] (" + pos[i].x + ", " + pos[i].y + ", " + pos[i].z + ")");
  for(i = 1 ; i < TIMESPAN ; i++) {
    pos[i] = func(pos[i - 1]);
    //println("p[" + i + "] (" + pos[i].x + ", " + pos[i].y + ", " + pos[i].z + ")");
  }
  strokeWeight(2);
  stroke(0);
  fill(0);
  colorMode(HSB, COLOURS, 100, 100);
}
 
void draw() {
  background(255);
  scale(2);
  for(int i = 0; i < TIMESPAN; i++) {
    stroke(i % COLOURS, 70, 70);
    point(pos[i]);
  }
}
 
// PVector version of translate
void translate(PVector p) {
  translate(p.x, p.y, p.z);
}
void point(PVector p) {
  point(p.x, p.y, p.z);
}
 
// lewisdartnell.com/Lorenz/Lorenz_page.htm
// fx(p) = a * (p.y - p.x)
// fy(p) = b * p.x - p.y - p.x * p.z
// fz(p) = p.x * p.y - c * p.z
// k1 = f1(p)
// k2 = f1(p + .5*h*A)
// k3 = f1(p + .5*h*B)
// k4 = f1(p + h*C)
// K = p + h*(A + 2*B + 2*C + D)/6
 
double fx(double x, double y, double z) {
  return sigma * (y - x);
}
 
double fy(double x, double y, double z) {
  return r * x - y - x * z;
}
 
double fz(double x, double y, double z) {
  return x * y - b * z;
}
 
PVector func(PVector p) {
  double x = p.x;
  double y = p.y;
  double z = p.z;
 
  // k1 = h * fn(p)
  double k1x = h * fx(x, y, z);
  double k1y = h * fy(x, y, z);
  double k1z = h * fz(x, y, z);
 
  // k2 = h * fn(p + .5 * k1)
  double k2x = h * fx(x + .5 * k1x, y + .5 * k1y, z + .5 * k1z);
  double k2y = h * fy(x + .5 * k1x, y + .5 * k1y, z + .5 * k1z);
  double k2z = h * fz(x + .5 * k1x, y + .5 * k1y, z + .5 * k1z);
 
  // k3 = h * fn(p + .5 * k2)
  double k3x = h * fx(x + .5 * k2x, y + .5 * k2y, z + .5 * k2z);
  double k3y = h * fy(x + .5 * k2x, y + .5 * k2y, z + .5 * k2z);
  double k3z = h * fz(x + .5 * k2x, y + .5 * k2y, z + .5 * k2z);
 
  // k4 = h * fn(p + k3)
  double k4x = h * fx(x + k3x, y + k3y, z + k3z);
  double k4y = h * fy(x + k3x, y + k3y, z + k3z);
  double k4z = h * fz(x + k3x, y + k3y, z + k3z);
 
  // K = p + h*(A + 2*B + 2*C + D)/6
  double kx = x + (k1x + 2 * k2x + 2 * k3x + k4x) / 6.0;
  double ky = y + (k1y + 2 * k2y + 2 * k3y + k4y) / 6.0;
  double kz = z + (k1z + 2 * k2z + 2 * k3z + k4z) / 6.0;
 
  return new PVector((float)kx, (float)ky, (float)kz);
}
