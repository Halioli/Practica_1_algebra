//Object variables
Object[] objects = new Object[8];

class Object {
  //Object variables
  int objectX, objectY;

  //Rect object variables
  int rectHeight;
  int rectWidth;
  float xMin;
  float yMin;
  float xMax;
  float yMax;

  //Circle object variables
  int isRectangle;
  int objectRadius;

  Object () {
    isRectangle = (int)random(0, 2);
    objectX = (int)random(20, width-20);
    objectY = (int)random(20, height-20);
    rectHeight = (int)random(20, 80);
    rectWidth = (int)random(20, 80);
    objectRadius = (int)random(20, 80);
    println(isRectangle);
    if (isRectangle == 0) {
      xMin = objectX - rectWidth/2; 
      yMin = objectY - rectHeight/2;
      xMax = objectX + rectWidth/2;
      yMax = objectY + rectHeight/2;
    }
  }

  void display() {
    fill(0);
    if (isRectangle == 0) {
      rect((float)objectX, (float)objectY, (float)rectHeight, (float)rectWidth);
    } else {
      ellipse((float)objectX, (float)objectY, (float)objectRadius, (float)objectRadius);
    }
  }

  void update() {
    //Collisions
    float[] distance_between_centers;
    float magnitude_of_vector;
    //float distanceCorrection;
    distance_between_centers = new float[2];


    for (int i = 0; i < objects.length; i++) {
      if (objects[i].isRectangle == 0) {
        distance_between_centers[0] = player[0].pcPosition.x - objects[i].objectX;  // Vector coords.
        distance_between_centers[1] = player[0].pcPosition.y - objects[i].objectY;  

        magnitude_of_vector = sqrt(distance_between_centers[0] * distance_between_centers[0] + // Vector's module/distance
          distance_between_centers[1] * distance_between_centers[1]);

        // There's collision if...
        if (magnitude_of_vector * 2 < player[0].pcRadius + objects[i].rectWidth ||
          magnitude_of_vector * 2 < player[0].pcRadius + objects[i].rectHeight) {
          if (player[0].pcPosition.x < objects[i].xMin) {
            player[0].pcPosition.x -= 5;
          } else if (player[0].pcPosition.x > objects[i].xMax) {
            player[0].pcPosition.x += 5;
          }

          if (player[0].pcPosition.y < objects[i].yMax) {
            player[0].pcPosition.y += 5;
          } else if (player[0].pcPosition.y > objects[i].yMin) {
            player[0].pcPosition.y -= 5;
          }
        }
      } else {
        distance_between_centers[0] = player[0].pcPosition.x - objects[i].objectX;  // Vector coords.
        distance_between_centers[1] = player[0].pcPosition.y - objects[i].objectY;  

        magnitude_of_vector = sqrt(distance_between_centers[0] * distance_between_centers[0] + // Vector's module/distance
          distance_between_centers[1] * distance_between_centers[1]); 

        // There's collision if...
        if (magnitude_of_vector * 2 < player[0].pcRadius + objects[i].objectRadius) {
          if (player[0].pcPosition.x > objects[i].objectX)
            player[0].pcPosition.x += 3;
          else if (player[0].pcPosition.x < objects[i].objectX)
            player[0].pcPosition.x -= 3;
          else if (player[0].pcPosition.y < objects[i].objectY)
            player[0].pcPosition.y += 3;
          else if (player[0].pcPosition.y > objects[i].objectY)
            player[0].pcPosition.y -= 3;
        } else {
          player[0].pcSpeed =  player[0].pcMaxSpeed;
        }

        for (int j=0; j < npcFollowersX.length; j++) {
          distance_between_centers[0] = npcFollowersX[j] - objects[i].objectX;  // Vector coords.
          distance_between_centers[1] = npcFollowersY[j] - objects[i].objectY;  

          magnitude_of_vector = sqrt(distance_between_centers[0] * distance_between_centers[0] + // Vector's module/distance
            distance_between_centers[1] * distance_between_centers[1]); 

          // There's collision if...
          if (magnitude_of_vector * 2 < npcRadius + objects[i].objectRadius) {
            if (npcFollowersX[j] > objects[i].objectX)
              npcFollowersX[j] += 3;
            else if (npcFollowersX[j] < objects[i].objectX)
              npcFollowersX[j] -= 3;
            else if (npcFollowersY[j] < objects[i].objectY)
              npcFollowersY[j] += 3;
            else if (npcFollowersY[j] > objects[i].objectY)
              npcFollowersY[j] -= 3;
          } else {
            npcSpeed[j] = random(minSpeed, maxSpeed);
          }
        }
        for (int j=0; j < npcRunnersX.length; j++) {
          distance_between_centers[0] = npcRunnersX[j] - objects[i].objectX;  // Vector coords.
          distance_between_centers[1] = npcRunnersY[j] - objects[i].objectY;  

          magnitude_of_vector = sqrt(distance_between_centers[0] * distance_between_centers[0] + // Vector's module/distance
            distance_between_centers[1] * distance_between_centers[1]); 

          // There's collision if...
          if (magnitude_of_vector * 2 < npcRadius + objects[i].objectRadius) {
            if (npcRunnersX[j] > objects[i].objectX)
              npcRunnersX[j] += 3;
            else if (npcRunnersX[j] < objects[i].objectX)
              npcRunnersX[j] -= 3;
            else if (npcRunnersY[j] < objects[i].objectY)
              npcRunnersY[j] += 3;
            else if (npcRunnersY[j] > objects[i].objectY)
              npcRunnersY[j] -= 3;
          } else {
            npcSpeed[j] = random(minSpeed, maxSpeed);
          }
        }

        for (int j=0; j < npcWanderersX.length; j++) {
          distance_between_centers[0] = npcWanderersX[j] - objects[i].objectX;  // Vector coords.
          distance_between_centers[1] = npcWanderersY[j] - objects[i].objectY;  

          magnitude_of_vector = sqrt(distance_between_centers[0] * distance_between_centers[0] + // Vector's module/distance
            distance_between_centers[1] * distance_between_centers[1]); 

          // There's collision if...
          if (magnitude_of_vector * 2 < npcRadius + objects[i].objectRadius) {
            if (npcWanderersX[j] > objects[i].objectX)
              npcWanderersX[j] += 3;
            else if (npcWanderersX[j] < objects[i].objectX)
              npcWanderersX[j] -= 3;
            else if (npcWanderersY[j] < objects[i].objectY)
              npcWanderersY[j] += 3;
            else if (npcWanderersY[j] > objects[i].objectY)
              npcWanderersY[j] -= 3;
          } else {
            npcSpeed[j] = random(minSpeed, maxSpeed);
          }
        }
      }
    }
  }
}
