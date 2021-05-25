// Scary Game 

// VARIABLES
// Camera
FPCamera camera;

PImage oscarImage;
PShape oscarShape;

// FUNCTIONS
void setup() {
  size(1200, 800, P3D); 
  // Instantiate camera
  camera = new FPCamera();

  // Load image
  setupGround(9, 10); 
  setupWalls(40); 

  oscarImage = loadImage("OscarCaco_Head.png");
  oscarShape = createShape(BOX,200);
  
  oscarShape.setTexture(oscarImage);

  noStroke();

  //Set cursor invisible
  noCursor();
}

void draw() {
  lights();
  background(0);
  camera.camTransformations();

  pushMatrix();
  translate(0,450,0);
  shape(oscarShape);
  popMatrix();
 
  // Draw the environment
  //  - (Ground)
  drawGround(9, 10, 0, 0, 0, 400, -600);
  drawGround(9, 10, 0, 0, 0, 400, -300);

  // - Walls
  drawWalls(1, 0, -400, 450, 60, 90);
  drawWalls(5, 0, 0, 450, 650, 0);
  drawWalls(4, 0, 300, 450, 650, 0);
  drawWalls(4, 0, -2400, 450, 530, 90);
  drawWalls(4, 0, -2800, 450, 250, 90);
  drawWalls(5, 0, 0, 450, 650, 0);
}
