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
    initialSpeed = 0.5;
    maxSpeed = 3;
    currentSpeed = initialSpeed;
    // Radius
    initialRadius = 8;
    maxRadius = 24;
    currentRadius = initialRadius;
    // Movement & Position
    currentPosition = new PVector(width/2, height/2 + 20);
    directionalVector = new PVector(0, 0);
    // Minions
    minionsToSpawn = 5;
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
    fill(250);
    ellipse(currentPosition.x, currentPosition.y, npcRadius, npcRadius);
  }

  void update() {
    switch (phase) {
    case 0:
      display();
      break;

    case 1:
      currentSpeed = maxSpeed/2;
      currentRadius = maxRadius/2;
      display();
      break;

    case 2:
      currentSpeed = maxSpeed;
      currentRadius = maxRadius;
      display();
      break;

    case 3:
      if (!spawnedAll)
        spawnMinions();

      display();
      break;

    default:
      phase = 0;
      display();
      break;
    }
  }

  void spawnMinions() {
    spawnedAll = true;
    for (int i = 0; i < minionsToSpawn; i++) {
      fill(255, 0, 0);
      ellipse(npcFollowersX[i], npcFollowersY[i], npcRadius, npcRadius);
    }
  }
}
