Boss[] boss = new Boss[1];

class Boss {
  int phase;
  // Speed
  float initialSpeed;
  float maxSpeed;
  float currentSpeed;
  // Radius
  int initialRadius;
  int maxRadius;
  int currentRadius;
  // Movement
  float module;
  PVector currentPosition;
  PVector directionalVector;
  // Minions
  int minionsToSpawn;
  boolean spawnedAll;

  Boss () {
    // Speed
    initialSpeed = 1;
    maxSpeed = 3;
    currentSpeed = initialSpeed;
    // Radius
    initialRadius = 32;
    maxRadius = 128;
    currentRadius = initialRadius;
    // Movement & Position
    currentPosition = new PVector(width/2, height/2 + 20);
    directionalVector = new PVector(0, 0);
    // Minions
    if (minionsToSpawn > n/3)
      minionsToSpawn = 5;
    else
      minionsToSpawn = n/3;

    spawnedAll = false;
  }

  void display() {
    // Evaluate a vector
    directionalVector.x = player[0].pcPosition.x - currentPosition.x;
    directionalVector.y = player[0].pcPosition.y - currentPosition.y;

    // Normalize the vector
    module = sqrt(directionalVector.x * directionalVector.x + directionalVector.y * directionalVector.y);

    // Initialize all the enemies speed
    directionalVector.x /= module; 
    directionalVector.y /= module;

    // 3- Scale the vector
    directionalVector.x *= currentSpeed; 
    directionalVector.y *= currentSpeed;

    // 4- Move the enemy
    currentPosition.x += directionalVector.x;
    currentPosition.y += directionalVector.y;

    // 5- Draw everything
    ellipse(currentPosition.x, currentPosition.y, currentRadius, currentRadius);
  }

  void update() {
    checkCollisions(currentPosition);

    switch (phase) {
    case 0:
      fill(175);
      display();
      break;

    case 1:
      fill(200);
      currentSpeed = maxSpeed/2;
      currentRadius = 48;
      display();
      break;

    case 2:
      fill(225);
      currentSpeed = maxSpeed;
      currentRadius = 64;
      display();
      break;

    case 3:
      fill(255);
      currentRadius = maxRadius;
      display();
      moveNPCFollower();
      break;

    default:
      phase = 0;
      display();
      break;
    }
  }
}

void checkCollisions(PVector currPos) {
  float[] distanceBetweenCenters;
  float magnitudeOfVector;
  distanceBetweenCenters = new float[2];

  for (int i = 0; i < npcFollowersX.length; i++) {
    distanceBetweenCenters[0] = player[0].pcPosition.x - currPos.x;
    distanceBetweenCenters[1] = player[0].pcPosition.y - currPos.y;  

    magnitudeOfVector = sqrt(distanceBetweenCenters[0] * distanceBetweenCenters[0] +
      distanceBetweenCenters[1] * distanceBetweenCenters[1]); 

    if (magnitudeOfVector * 2 < player[0].pcRadius + npcRadius) {
      if (player[0].pcPosition.x > currPos.x) {
        player[0].health -= 15;
        currPos.set(width/2, height/2 + 20);
      } else if (player[0].pcPosition.x < currPos.x) {
        player[0].health -= 15;
        currPos.set(width/2, height/2 + 20);
      } else if (player[0].pcPosition.y < currPos.y) {
        player[0].health -= 15;
        currPos.set(width/2, height/2 + 20);
      } else if (player[0].pcPosition.y > currPos.y) {
        player[0].health -= 15;
        currPos.set(width/2, height/2 + 20);
      }
    }
  }
}
