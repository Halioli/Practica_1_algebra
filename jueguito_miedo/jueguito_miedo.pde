//Scary Maze Game 
PImage earth; 
PShape globe;

//Variables
FPCamera camera;

//Functions
void setup() {
  size(1200, 800, P3D);
  camera = new FPCamera();
  earth = loadImage();
  globe = createShape(RECT, 0, 0, 200, 200); 
  globe.setTexture(earth);
  noStroke();
}

void draw() {
  lights();
  background(0);
  camera.camTransformations();
  //Draws environment
  
  rotateX(radians(90));
  translate(0,400,-600);
  shape(globe);
}

//void createGround(){

  
//}
