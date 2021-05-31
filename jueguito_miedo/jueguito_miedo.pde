// Scary Game 

// VARIABLES
// Camera
FPCamera camera;
//Enemy
EnemyOscar oscar;
//Collectables
Collectable[] collectables = new Collectable[7];
//Walls
Wall[] walls = new Wall[100];
int numW = 40;

// FUNCTIONS
void setup() {
  size(1200, 800, P3D); 
  // Instantiate camera
  camera = new FPCamera();
  oscar = new EnemyOscar();
  for (int i = 0; i < numW; i++) {
    walls[i] = new Wall();
    walls[i].setupWalls(40);
  }
  // Load image
  setupGround(9, 10); 

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

  //oscar.drawOscar();

  for (int i = 0; i < collectables.length; i++) {
    collectables[i].updateColl();
    collectables[i].drawCollectables(i);
  }

  // Draw the environment
  //  - (Ground)
  drawGround(9, 10, 0, 0, 0, 400, -600);
  drawGround(9, 10, 0, 0, 0, 400, -300);

  // - Walls
  walls[0].drawWalls(1, 0, -400, 450, 60, 90);
  walls[1].drawWalls(5, 0, 0, 450, 650, 0);
  walls[2].drawWalls(4, 0, 300, 450, 650, 0);
  walls[3].drawWalls(4, 0, -2400, 450, 530, 90);
  walls[4].drawWalls(4, 0, -2800, 450, 250, 90);
  walls[5].drawWalls(5, 0, 0, 450, 650, 0);
}
