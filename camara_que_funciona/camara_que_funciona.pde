FPCamera mainCamera;

// Enables all camera transformations.
boolean cameraEnabled = false;

void setup() {
  size(1280, 600, P3D);
  // Creates a new camera.
  mainCamera = new FPCamera();
  // Camera transformations are enabled.
  cameraEnabled = true;
}

void draw() {
  background(0);

  // Tells the program that boolean cameraEnabled controls camera transformations.
  if (cameraEnabled == true) {
    mainCamera.camTransformations();
    // Updates and stores the cameras position every frame.
    //debugCamPos();
  }
  // Just some blocks so i can see things move.
  renderEnvironment();
}

// Creats a ground plain.
void renderEnvironment() {
  // number of boxes that are placed along each axis (X and Z only) to form the ground plain.
  int boxNumberPerAxis = 25;

  fill(198, 101, 35);
  // Forming the celling plain.
  for (int z = 0; z < boxNumberPerAxis; z++ ) {
    for (int x = 0; x < boxNumberPerAxis; x++) {
      block(x*50, 0, z*50, 50);
    }
  }

  // Forming the ground plain.
  fill(105, 88, 114);
  for (int z = 0; z < boxNumberPerAxis; z++ ) {
    for (int x = 0; x < boxNumberPerAxis; x++) {
      block(x*50, height-height/3, z*50, 50);
    }
  }
}


class FPCamera {

  // The Main camera's position.
  PVector cameraPosition;

  // Movement velocity and acceleration.
  PVector velocity;
  PVector acceleration;
  // The camera's maximum speed.
  float topspeed;

  boolean enableFly = false;

  FPCamera() {
    cameraPosition = new PVector(width/2, height/2+50, (height/2) / tan(PI*30 / 180));
    velocity = new PVector(0, 0);
    topspeed = 7;
  }



  // All transformations applyed to the camera are here.
  void camTransformations() {

    // Camera rotations.
    pushMatrix();
    translate(cameraPosition.x, cameraPosition.y, cameraPosition.z);

    // Side to side movment
    rotateY(-mouseX*0.01);

    translate(0, 0, -200);
    //ball(0, 0, 0, 20);

    float x = modelX(0, 0, 0);
    float y = modelY(0, 0, 0);
    float z = modelZ(0, 0, 0);
    popMatrix();


    // Up and down movment.
    y = map(mouseY, 0, height, -200, 1200);
    println(y);

    camera(cameraPosition.x, cameraPosition.y, cameraPosition.z, x, y, z, 0, 1, 0);
    println(x);
    println(y);
    println(z);

    // Camera positional movment.

    // Move Forward when pressing W.
    if (keyPressed) {
      if (key == 'w') {
        // Compute a vector that points from location to mouse.
        //PVector targetPosition = new PVector(x, y, z);
        PVector targetPosition = new PVector(x, cameraPosition.y, z);
        PVector acceleration = PVector.sub(targetPosition, cameraPosition);
        // Set magnitude of acceleration
        acceleration.setMag(5);

        // Velocity changes according to acceleration
        velocity.add(acceleration);
        // Limit the velocity by topspeed
        velocity.limit(topspeed);
        // Location changes by velocity
        cameraPosition.add(velocity);
        
      } else if (key == 's') {
        // Compute a vector that points from location to mouse.
        //PVector targetPosition = new PVector(x, y, z);
        PVector targetPosition = new PVector(x, cameraPosition.y, z);
        PVector acceleration = PVector.sub(targetPosition, cameraPosition);
        // Set magnitude of acceleration
        acceleration.setMag(-5);

        // Velocity changes according to acceleration
        velocity.add(acceleration);
        // Limit the velocity by topspeed
        velocity.limit(topspeed);
        // Location changes by velocity
        cameraPosition.add(velocity);
      }
    }
  }
}


void block(float x, float y, float z, float s) {
  pushMatrix();
  translate(x, y, z);
  box(s);
  popMatrix();
}

void ball(float x, float y, float z, float s) {
  pushMatrix();
  translate(x, y, z);
  sphere(s);
  popMatrix();
}
