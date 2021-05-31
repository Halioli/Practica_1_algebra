// Scary Game 

// VARIABLES
// Camera
FPCamera camera;
//Enemy
EnemyOscar oscar;
//Collectables
Collectable[] collectables = new Collectable[7];

// FUNCTIONS
void setup() {
  size(1200, 800, P3D); 
  // Instantiate camera
  camera = new FPCamera();
  oscar = new EnemyOscar();

  // Load image
  setupGround(9, 10); 
  setupWalls(40); 
  oscar.setupOscar();

  for (int i=0; i < collectables.length; i++) {
    collectables[i] = new Collectable(i);
  }

  for (int i = 0; i < collectables.length; i++) {
    collectables[i].setupCollectables(i);
  }
  noStroke();

  //Set cursor invisible
  noCursor();

  //Set frameRate value
  frameRate(60);
}

void draw() {
  lights();
  background(0);
  camera.camTransformations();

  oscar.drawOscar();

  for (int i = 0; i < collectables.length; i++) {
    collectables[i].updateColl();
    collectables[i].drawCollectables(i);
  }

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
