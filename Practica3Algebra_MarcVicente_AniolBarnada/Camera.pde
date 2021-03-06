class FPCamera {
  PVector cameraLocation;

  // Movement velocity and acceleration.
  PVector velocity;
  PVector acceleration;
  float topSpeed;

  boolean collided = false;

  float minX, maxX, minZ, maxZ;

  FPCamera() {
    cameraLocation = new PVector(width/2-400, height/2+50, (height/2) / tan(PI*30 / 180)-150);
    velocity = new PVector(0, 0);
    topSpeed = 7;
  }

  void camTransformations() {
    pushMatrix();
    translate(cameraLocation.x, cameraLocation.y, cameraLocation.z);

    // Side to side movement
    rotateY(-mouseX*0.005);
    noFill();
    noStroke();
    box(100);
    translate(0, 0, -200);
    float x = modelX(0, 0, 0);
    float y = modelY(0, 0, 0);
    float z = modelZ(0, 0, 0);

    minX = cameraLocation.x - 50;
    maxX = cameraLocation.x + 50;
    minZ = cameraLocation.z - 50;
    maxZ = cameraLocation.z + 50;
    popMatrix();


    // Up and down movment.
    y = map(mouseY, 0, height, -200, 1200);
    println(y);


    camera(cameraLocation.x, cameraLocation.y, cameraLocation.z, x, y, z, 0, 1, 0);
    println("X: "+x);
    println("Y: "+y);
    println("Z: "+z);

    // Move Forward when pressing W.
    if (keyPressed) {
      if (!collided) {
        if (key == 'w' || key == 'W') {

          // Compute a vector that points from location to mouse.
          PVector targetPosition = new PVector(x, cameraLocation.y, z);
          PVector acceleration = PVector.sub(targetPosition, cameraLocation);
          // Set magnitude of acceleration
          acceleration.setMag(5);

          // Velocity changes according to acceleration
          velocity.add(acceleration);

          // Limit the velocity by topspeed
          velocity.limit(topSpeed);

          // Location changes by velocity
          cameraLocation.add(velocity);
        } else if (key == 's' || key == 'S') {
          // Compute a vector that points from location to mouse.
          //PVector targetPosition = new PVector(x, y, z);
          PVector targetPosition = new PVector(x, cameraLocation.y, z);
          PVector acceleration = PVector.sub(targetPosition, cameraLocation);

          // Set magnitude of acceleration
          acceleration.setMag(-5);

          // Velocity changes according to acceleration
          velocity.add(acceleration);

          // Limit the velocity by topspeed
          velocity.limit(topSpeed);

          // Location changes by velocity
          cameraLocation.add(velocity);
        }
      } else {
        cameraLocation.sub(cameraLocation);
      }
    }
  }
}
