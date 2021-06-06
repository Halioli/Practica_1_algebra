static int boxSize = 200;

class EnemyOscar {
  PImage oscarImage;
  PShape oscarShape;

  PVector enemyPosition = new PVector();
  PVector speedEnemy = new PVector();
  PVector vectorEnemy = new PVector();


  boolean collided;

  float maxX, minX, maxZ, minZ;
  float minDistance;
  
  EnemyOscar(float minD) {
    enemyPosition = new PVector(0.0, 450.0, 0.0);
    speedEnemy = new PVector(3.0, 0.0, 3.0);
    vectorEnemy = new PVector(0.0, 0.0, 0.0);
    collided = false;
    minDistance = minD;
  }

  void setupOscar() {

    oscarImage = loadImage("OscarCaco_Head.png");
    oscarShape = createShape(BOX, 200);

    oscarShape.setTexture(oscarImage);
    pushMatrix();
    translate(0.0, 450, 0.0);
    shape(oscarShape);
    popMatrix();
  }

  void drawOscar() {
    float moduleEnemy;

    if (!collided) {
      // Evaluate a vector
      vectorEnemy.x = camera.cameraLocation.x - enemyPosition.x;
      vectorEnemy.y = camera.cameraLocation.y - enemyPosition.y;
      vectorEnemy.z = camera.cameraLocation.z - enemyPosition.z;

      // Normalize the vector
      moduleEnemy = sqrt(vectorEnemy.x * vectorEnemy.x + vectorEnemy.y * vectorEnemy.y + vectorEnemy.z * vectorEnemy.z);

      if (moduleEnemy <= minDistance) { 
        // Initialize the enemy speed
        vectorEnemy.x /= moduleEnemy; 
        vectorEnemy.y /= moduleEnemy;
        vectorEnemy.z /= moduleEnemy;

        // Scale the vector
        vectorEnemy.x *= speedEnemy.x;
        vectorEnemy.y *= speedEnemy.y;
        vectorEnemy.z *= speedEnemy.z;

        // Move the enemy
        enemyPosition.x += vectorEnemy.x;
        enemyPosition.y += vectorEnemy.y;
        enemyPosition.z += vectorEnemy.z;

        //Apply vectors
        pushMatrix();
        translate(enemyPosition.x, enemyPosition.y, enemyPosition.z);
        shape(oscarShape);
        popMatrix();
      }
      //Check collisions with Player
      getMinMaxOscar((int)enemyPosition.x, (int)enemyPosition.z);
      enemyCollision();
    } else {
      enemyPosition = new PVector(camera.cameraLocation.x + 20, camera.cameraLocation.y, camera.cameraLocation.z + 20);
      pushMatrix();
      translate(enemyPosition.x, enemyPosition.y, enemyPosition.z);
      shape(oscarShape);
      popMatrix();
    }
  }


  void getMinMaxOscar(int coordX, int coordZ) {
    minX = coordX  - 20;
    maxX = coordX  + 20;
    minZ = coordZ - boxSize/2;
    maxZ = coordZ + boxSize/2;
  }

  void enemyCollision() {
    if ((minX <= camera.maxX && maxX >= camera.minX) &&
      (minZ <= camera.maxZ && maxZ >= camera.minZ)) {
      collided = true;
      println("Enemy Collided");
      enemyCollided = true;
    } else {
      collided = false;
    }
  }
}
