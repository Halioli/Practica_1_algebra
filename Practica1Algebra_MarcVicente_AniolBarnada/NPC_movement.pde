// NPC Variables
int n;  // Detemined by User Input
float[] npcFollowersX, npcFollowersY;  // 1/3 of n
float[] npcRunnersX, npcRunnersY;      // 1/3 of n
float[] npcWanderersX, npcWanderersY;  // 1/3 of n
float maxSpeed;
float minSpeed;
float[] npcSpeed;
int npcRadius = 8;
float vectorXFollower, vectorYFollower;
float moduleFollower;
float vectorXRunner, vectorYRunner;
float moduleRunner;
float vectorXWanderer, vectorYWanderer;
float moduleWanderer;
int playerRadiusCollider;

void moveNPCFollower() {
  float[] distanceBetweenCenters;
  float magnitudeOfVector;
  distanceBetweenCenters = new float[2];
  boolean collided = false;

  for (int i = 0; i < npcFollowersX.length; i++) {
    distanceBetweenCenters[0] = player[0].pcPosition.x - npcFollowersX[i];  // Vector coords.
    distanceBetweenCenters[1] = player[0].pcPosition.y - npcFollowersY[i];  

    magnitudeOfVector = sqrt(distanceBetweenCenters[0] * distanceBetweenCenters[0] + // Vector's module/distance
      distanceBetweenCenters[1] * distanceBetweenCenters[1]); 

    //distanceCorrection = ((player[0].pcRadius + objects[i].objectRadius) - magnitude_of_vector)/2;
    // There's collision if...
    if (magnitudeOfVector * 2 < player[0].pcRadius + npcRadius) {
      if (player[0].pcPosition.x > npcFollowersX[i]) {
        player[0].health -= 10;
        npcFollowersX[i] = -100;
        npcFollowersY[i] = -100;
        collided = true;
      } else if (player[0].pcPosition.x < npcFollowersX[i]) {
        player[0].health -= 10;
        npcFollowersX[i] = -100;
        npcFollowersY[i] = -100;
        collided = true;
      } else if (player[0].pcPosition.y < npcFollowersY[i]) {
        player[0].health -= 10;
        npcFollowersX[i] = -100;
        npcFollowersY[i] = -100;
        collided = true;
      } else if (player[0].pcPosition.y > npcFollowersY[i]) {
        player[0].health -= 10;
        npcFollowersX[i] = -100;
        npcFollowersY[i] = -100;
        collided = true;
      } else {
        collided = false;
      }
    }
    if (collided) {
      npcSpeed[i] = 0;
    } else {

      // Evaluate a vector
      vectorXFollower = player[0].pcPosition.x - npcFollowersX[i];
      vectorYFollower = player[0].pcPosition.y - npcFollowersY[i];

      // Normalize the vector
      moduleFollower = sqrt(vectorXFollower * vectorXFollower + vectorYFollower * vectorYFollower);

      // Initialize all the enemies speed
      npcSpeed[i] = random(minSpeed, maxSpeed);
      vectorXFollower /= moduleFollower; 
      vectorYFollower /= moduleFollower;

      // 3- Scale the vector
      vectorXFollower *= npcSpeed[i]; 
      vectorYFollower *= npcSpeed[i];

      // 4- Move the enemy
      npcFollowersX[i] += vectorXFollower;
      npcFollowersY[i] += vectorYFollower;

      // 5- Draw everything
      fill(255, 0, 0);
      ellipse(npcFollowersX[i], npcFollowersY[i], npcRadius, npcRadius);
    }
  }
}

void moveNPCRunner() {
  //Variables Collision Trigger
  float[] distanceBetweenCenters;
  float magnitudeOfVector;
  distanceBetweenCenters = new float[2];

  //Variables Collision Player
  float[] distance_between_centers2;
  float magnitude_of_vector2;
  //float distanceCorrection;
  distance_between_centers2 = new float[2];

  for (int i = 0; i < npcRunnersY.length; i++) {
    distanceBetweenCenters[0] = player[0].pcPosition.x - npcRunnersX[i];  //Vector coords.
    distanceBetweenCenters[1] = player[0].pcPosition.y - npcRunnersY[i];  

    magnitudeOfVector = sqrt(distanceBetweenCenters[0] * distanceBetweenCenters[0] + //Vector's module/distance
      distanceBetweenCenters[1] * distanceBetweenCenters[1]); 

    // There's collision if...
    if (magnitudeOfVector < playerRadiusCollider + npcRadius) {
      collidedTrigger = true;
    } else {
      collidedTrigger = false;
    }

    if (collidedTrigger) {
      // Evaluate a vector
      vectorXRunner = player[0].pcPosition.x - npcRunnersX[i];
      vectorYRunner = player[0].pcPosition.y - npcRunnersY[i];

      // Normalize the vector
      moduleRunner = sqrt(vectorXRunner * vectorXRunner + vectorYRunner * vectorYRunner);

      // Initialize all the enemies speed
      npcSpeed[i] = random(minSpeed, maxSpeed);
      vectorXRunner /= moduleRunner; 
      vectorYRunner /= moduleRunner;

      // 3- Scale the vector
      vectorXRunner *= npcSpeed[i]; 
      vectorYRunner *= npcSpeed[i];

      // 4- Move the enemy
      npcRunnersX[i] -= vectorXRunner;
      npcRunnersY[i] -= vectorYRunner;

      // 5- Draw everything
      fill(0, 255, 0);
      ellipse(npcRunnersX[i], npcRunnersY[i], npcRadius, npcRadius);
      text("YES :)", 20, 380);
    } else {
      text("NO  :(", 20, 380);
      fill(0, 255, 0);
      ellipse(npcRunnersX[i], npcRunnersY[i], npcRadius, npcRadius);
    }

    distance_between_centers2[0] = player[0].pcPosition.x - npcRunnersX[i];  // Vector coords.
    distance_between_centers2[1] = player[0].pcPosition.y - npcRunnersY[i];  

    magnitude_of_vector2 = sqrt(distance_between_centers2[0] * distance_between_centers2[0] + // Vector's module/distance
      distance_between_centers2[1] * distance_between_centers2[1]); 

    //distanceCorrection = ((player[0].pcRadius + objects[i].objectRadius) - magnitude_of_vector)/2;
    // There's collision if...
    if (magnitude_of_vector2 * 2 < player[0].pcRadius + npcRadius) {
      if (player[0].pcPosition.x > npcRunnersX[i]) {
        player[0].points += 100;
        npcRunnersX[i] = -100;
        npcRunnersY[i] = -100;
      } else if (player[0].pcPosition.x < npcRunnersX[i]) {
        player[0].points += 100;
        npcRunnersX[i] = -100;
        npcRunnersY[i] = -100;
      } else if (player[0].pcPosition.y < npcRunnersY[i]) {
        player[0].points += 100;
        npcRunnersX[i] = -100;
        npcRunnersY[i] = -100;
      } else if (player[0].pcPosition.y > npcRunnersY[i]) {
        player[0].points += 100;
        npcRunnersX[i] = -100;
        npcRunnersY[i] = -100;
      }
    }
  }
}

void moveNPCWanderer() {
  float[] distanceBetweenCenters;
  float magnitudeOfVector;
  distanceBetweenCenters = new float[2];
  for (int i = 0; i < npcWanderersX.length; i++) {
    distanceBetweenCenters[0] = player[0].pcPosition.x - npcWanderersX[i];  // Vector coords.
    distanceBetweenCenters[1] = player[0].pcPosition.y - npcWanderersY[i];  

    magnitudeOfVector = sqrt(distanceBetweenCenters[0] * distanceBetweenCenters[0] + // Vector's module/distance
      distanceBetweenCenters[1] * distanceBetweenCenters[1]); 

    //distanceCorrection = ((player[0].pcRadius + objects[i].objectRadius) - magnitude_of_vector)/2;
    // There's collision if...
    vectorXWanderer = random(width) - npcWanderersX[i];
    vectorYWanderer = random(height) - npcWanderersY[i];

    // Normalize the vector
    moduleWanderer = sqrt(vectorXWanderer * vectorXWanderer + vectorYWanderer * vectorYWanderer);

    // Initialize all the enemies speed
    npcSpeed[i] = random(minSpeed, maxSpeed);
    vectorXWanderer /= moduleWanderer; 
    vectorYWanderer /= moduleWanderer;

    // 3- Scale the vector
    vectorXWanderer *= npcSpeed[i]; 
    vectorYWanderer *= npcSpeed[i];

    // 4- Move the enemy
    int movement = (int)random(0, 6);
    if (movement == 0) {
      npcWanderersX[i] += vectorXWanderer;
      npcWanderersY[i] += vectorYWanderer;
    } else if (movement == 1) {
      npcWanderersX[i] -= vectorXWanderer;
      npcWanderersY[i] -= vectorYWanderer;
    } else if (movement == 2) {
      npcWanderersX[i] += vectorXWanderer * 2;
      npcWanderersY[i] += vectorYWanderer * 2;
    } else if (movement == 3) {
      npcWanderersX[i] -= vectorXWanderer * 2;
      npcWanderersY[i] -= vectorYWanderer * 2;
    } else if (movement == 4) {
      npcWanderersX[i] += vectorXWanderer * 3;
      npcWanderersY[i] += vectorYWanderer * 3;
    } else if (movement == 5) {
      npcWanderersX[i] -= vectorXWanderer * 3;
      npcWanderersY[i] -= vectorYWanderer * 3;
    }

    // 5- Draw everything
    fill(0, 0, 255);
    ellipse(npcWanderersX[i], npcWanderersY[i], npcRadius, npcRadius);

    if (magnitudeOfVector * 2 < player[0].pcRadius + npcRadius) {
      if (player[0].pcPosition.x > npcWanderersX[i]) {
        player[0].health -= 15;
        npcWanderersX[i] = -100;
        npcWanderersY[i] = -100;
      } else if (player[0].pcPosition.x < npcWanderersX[i]) {
        player[0].health -= 15;
        npcWanderersX[i] = -100;
        npcWanderersY[i] = -100;
      } else if (player[0].pcPosition.y < npcWanderersY[i]) {
        player[0].health -= 15;
        npcWanderersX[i] = -100;
        npcWanderersY[i] = -100;
      } else if (player[0].pcPosition.y > npcWanderersY[i]) {
        player[0].health -= 15;
        npcWanderersX[i] = -100;
        npcWanderersY[i] = -100;
      }
    }
  }
}
