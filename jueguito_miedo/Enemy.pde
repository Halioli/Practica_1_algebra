class EnemyOscar {
  PImage oscarImage;
  PShape oscarShape;

  PVector enemyPosition = new PVector();
  PVector speedEnemy = new PVector();
  PVector vectorEnemy = new PVector();

  boolean collided;

  EnemyOscar() {
    enemyPosition = new PVector(0.0, 450.0, 0.0);
    speedEnemy = new PVector(3.0, 0.0, 3.0);
    vectorEnemy = new PVector(0.0, 0.0, 0.0);
    collided = false;
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

      // Initialize the enemy speed
      vectorEnemy.x /= moduleEnemy; 
      vectorEnemy.y /= moduleEnemy;
      vectorEnemy.z /= moduleEnemy;

      // 3- Scale the vector
      vectorEnemy.x *= speedEnemy.x;
      vectorEnemy.y *= speedEnemy.y;
      vectorEnemy.z *= speedEnemy.z;

      // 4- Move the enemy
      enemyPosition.x += vectorEnemy.x;
      enemyPosition.y += vectorEnemy.y;
      enemyPosition.z += vectorEnemy.z;


      pushMatrix();
      translate(enemyPosition.x, enemyPosition.y, enemyPosition.z);
      shape(oscarShape);
      popMatrix();
  
    } else {
      speedEnemy = new PVector(0.0,0.0,0.0);
    }
  }
}
