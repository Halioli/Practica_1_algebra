// Scary Game 

// VARIABLES
// Camera
FPCamera camera;
//Enemy
EnemyOscar oscar;
//Collectables
Collectable[] collectables = new Collectable[7];
Wall[] wallsVertical = new Wall[100];
Wall[] wallsHorizontal= new Wall[100];

boolean enemyCollided = false;

//Walls
int numW = 300;
int currentWall = 0;


// FUNCTIONS
void setup() {
  size(1200, 800, P3D); 
  // Instantiate camera
  camera = new FPCamera();
  oscar = new EnemyOscar(1000);

  for (int i = 0; i < wallsVertical.length; i++) {
    wallsVertical[i] = new Wall();
    wallsVertical[i].setupWallsVertical();
  }
  for (int i = 0; i < wallsHorizontal.length; i++) {
    wallsHorizontal[i] = new Wall();
    wallsHorizontal[i].setupWallsHorizontal();
  }
  // Load image
  setupGround(9, 10); 

  oscar.setupOscar();

  for (int i=0; i < collectables.length; i++) {
    collectables[i] = new Collectable(i);
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
  if (!enemyCollided) {
    camera.camTransformations();
  } else {
  }

  oscar.drawOscar();

  for (int i = 0; i < collectables.length; i++) {
    collectables[i].updateColl();
    collectables[i].drawCollectables(i);
  }

  // Draw the environment
  //  - (Ground)
  drawGround(9, 10, 0, 400, -600);
  drawGround(9, 10, 0, 400, -300);

  // - Walls
  for (int i = 0; i < 1; i++) {
    wallsHorizontal[i].drawWallHorizontal(50, 450, 400, i);
  }

  for (int i = currentWall; i < currentWall + 5; i++) {
    wallsVertical[i].drawWallVertical(0, 450, 650, i);
  }

  for (int i = currentWall; i < currentWall + 4; i++) {
    wallsVertical[i].drawWallVertical(300, 450, 650, i);
  }

  for (int i = currentWall; i < currentWall + 4; i++) {
    wallsHorizontal[i].drawWallHorizontal(-2400, 450, 530, i);
  }

  for (int i = currentWall; i < currentWall + 4; i++) {
    wallsHorizontal[i].drawWallHorizontal(520, 450, 2400, i);
  }

  for (int i = currentWall; i < currentWall + 5; i++) {
    wallsHorizontal[i].drawWallHorizontal(250, 450, 2800, i);
  }


  for (int i = currentWall; i < currentWall + 3; i++) {
    wallsHorizontal[i].drawWallVertical(2250, 450, 1150, i);
  }

  for (int i = currentWall; i < currentWall + 3; i++) {
    wallsHorizontal[i].drawWallVertical(2500, 450, 3030, i);
  }

  for (int i = currentWall; i < currentWall + 7; i++) {
    wallsHorizontal[i].drawWallVertical(2800, 450, 1550, i);
  }

  for (int i = currentWall; i < currentWall + 4; i++) {
    wallsHorizontal[i].drawWallHorizontal(770, 450, 4300, i);
  }

  for (int i = currentWall; i < currentWall + 3; i++) {
    wallsHorizontal[i].drawWallVertical(770, 450, 4300, i);
  }
  for (int i = currentWall; i < currentWall + 4; i++) {
    wallsHorizontal[i].drawWallHorizontal(770, 450, 5500, i);
  }
}
