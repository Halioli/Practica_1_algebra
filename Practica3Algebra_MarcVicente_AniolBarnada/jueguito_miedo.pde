// Scary Game 

// VARIABLES
// Camera
FPCamera camera;

// Enemy
EnemyOscar oscar[] = new EnemyOscar[4];

// Bezier's Curve
BezierCurve[] bezierCurve = new BezierCurve[5];

// Collectables
Collectable[] collectables = new Collectable[5];
Wall[] wallsVertical = new Wall[100];
Wall[] wallsHorizontal= new Wall[100];

boolean enemyCollided = false;

// Walls
int numW = 300;
int currentWall = 0;

// FUNCTIONS
void setup() {
  size(1200, 800, P3D);

  // Instantiate camera
  camera = new FPCamera();

  //Instantiate enemies
  oscar[0] = new EnemyOscar(1000, 0, 0);
  oscar[1] = new EnemyOscar(300, 2800, 5900);
  oscar[2] = new EnemyOscar(200, 4300, 4886);
  oscar[3] = new EnemyOscar(200, 5300, 2600);


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

  // Oscar Setup
  for (int i=0; i < oscar.length; i++) {
    oscar[i].setupOscar();
  }

  collectables[0] = new Collectable(1000, 5000);
  collectables[1] = new Collectable(4800, 6200);
  collectables[2] = new Collectable(4400, 4200);
  collectables[3] = new Collectable(5200, 2600);
  collectables[4] = new Collectable(camera.cameraLocation.x, camera.cameraLocation.z + 1000);


  for (int i=0; i < collectables.length; i++) {
    collectables[i].setupCollectables(i);

    // Setup parametric interpolation curve
    collectables[i].setupEffect(color(255, 0, 0));
    collectables[i].calculateCoefficient();

    // Setup Bezier's curve
    bezierCurve[i] = new BezierCurve(collectables[i].collectablePosition);
    bezierCurve[i].calculateCoefficents();
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

  // Draw Oscar
  for (int i = 0; i < oscar.length; i++) {
    oscar[i].drawOscar();
  }

  // Draw collectables and update rotation
  for (int i = 0; i < collectables.length; i++) {
    //Update rotation collectable
    collectables[i].updateCollect();

    //Draw collectables
    collectables[i].drawCollectables(i);

    //Update if collectable is gonna be picked
    //collectables[i].pickCollectable(); NOT WORKING

    // Draw parametric interpolation
    collectables[i].drawEffect();

    // Draw Bezier
    bezierCurve[i].drawCurve();
  }

  // Draw the environment
  drawEnvironment();
}
