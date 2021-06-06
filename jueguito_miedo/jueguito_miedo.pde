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
  setupGround(30, 30); 

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
  //Draw oscar
  oscar.drawOscar();
  
  //Draw collectables and update rotation
  for (int i = 0; i < collectables.length; i++) {
    collectables[i].updateCollect();
    collectables[i].drawCollectables(i);
  }

  //Draw the environment
  drawEnvironment();
}
