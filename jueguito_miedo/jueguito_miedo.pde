// Scary Game 

// VARIABLES
// Camera
FPCamera camera;

PImage earth; 
PShape globe;

// FUNCTIONS
void setup() {
  size(1200, 800, P3D);
  
  // Instantiate camera
  camera = new FPCamera();
  
  // Load image
  earth = loadImage("cacoOscar.png");
  
  // Create shape & set it's texture
  globe = createShape(RECT, 0, 0, 200, 200); 
  globe.setTexture(earth);
  noStroke();
}

void draw() {
  lights();
  background(0);
  camera.camTransformations();
  
  // Draw the environment
  rotateX(radians(90));
  translate(0,400,-600);
  shape(globe);
}

//void createGround(){

  
//}
