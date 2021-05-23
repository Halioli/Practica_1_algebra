// Scary Game 

// VARIABLES
// Camera
FPCamera camera;

static int numGrounds = 4;
static int numFilas = 2;

PImage earth; 
PShape[] globes = new PShape[numGrounds];



// FUNCTIONS
void setup() {
  size(1200, 800, P3D); 
  // Instantiate camera
  camera = new FPCamera();

  // Load image
  earth = loadImage("dungeonFloor.jpg");

  int groundSize = 300;

  for (int i = 0; i < numGrounds; i++) {
    globes[i] = createShape(RECT, 0, groundSize * i, groundSize, groundSize);
    globes[i].setTexture(earth);
  }
  // Create shape & set it's texture
  //globe = createShape(RECT, 0, 0, 300, 300); 
  //globe.setTexture(earth);
  noStroke();
}

void draw() {
  lights();
  background(0);
  camera.camTransformations();

  // Draw the environment
  rotateX(radians(90));
  translate(0, 400, -600);
  for (int i = 0; i < numGrounds; i++) {
    shape(globes[i]);
  }
}

void createGround() {
}
