BossButtons[] bossButton = new BossButtons[1];

class BossButtons {
  PVector firstPositions;
  PVector secondPositions;
  PVector thirdPositions;
  PVector forthPositions;
  int currentPosition;
  int dimensions;
  float[] xMin;
  float[] yMin;
  float[] xMax;
  float[] yMax;

  BossButtons() {
    // Size
    dimensions = 30;

    // Positions
    currentPosition = 0;
    firstPositions = new PVector(width/4, height/4);
    secondPositions = new PVector(width/4 * 3, height/4 * 3);
    thirdPositions = new PVector(width/4, height/4 * 3);
    forthPositions = new PVector(width/4 * 3, height/4);

    // Vertex
    xMin = new float[4];
    yMin = new float[4];
    xMax = new float[4];
    yMax = new float[4];

    xMin[0] = firstPositions.x - dimensions/2; 
    yMin[0] = firstPositions.y - dimensions/2;
    xMax[0] = firstPositions.x + dimensions/2;
    yMax[0] = firstPositions.y + dimensions/2;

    xMin[1] = secondPositions.x - dimensions/2; 
    yMin[1] = secondPositions.y - dimensions/2;
    xMax[1] = secondPositions.x + dimensions/2;
    yMax[1] = secondPositions.y + dimensions/2;

    xMin[2] = thirdPositions.x - dimensions/2; 
    yMin[2] = thirdPositions.y - dimensions/2;
    xMax[2] = thirdPositions.x + dimensions/2;
    yMax[2] = thirdPositions.y + dimensions/2;

    xMin[3] = forthPositions.x - dimensions/2; 
    yMin[3] = forthPositions.y - dimensions/2;
    xMax[3] = forthPositions.x + dimensions/2;
    yMax[3] = forthPositions.y + dimensions/2;
  }

  void display() {
    fill(0, 255, 0);
    switch (currentPosition) {
    case 0:
      rect(firstPositions.x, firstPositions.y, (float)dimensions, (float)dimensions);
      break;

    case 1:
      rect(secondPositions.x, secondPositions.y, (float)dimensions, (float)dimensions);
      break;

    case 2:
      rect(thirdPositions.x, thirdPositions.y, (float)dimensions, (float)dimensions);
      break;

    case 3:
      rect(forthPositions.x, forthPositions.y, (float)dimensions, (float)dimensions);
      break;

    default:
      break;
    }
  }

  void update() {
    // Look collisions
    switch (currentPosition) {
    case 0:
      if ((player[0].pcPosition.x < xMin[0]) || (player[0].pcPosition.y < yMin[0]) 
        || (xMax[0] < player[0].pcPosition.x) || (yMax[0] < player[0].pcPosition.y)) {
        //println("NO");
      } else {
        println("Collided with button");
        currentPosition++;
        boss[0].phase++;
      }
      break;

    case 1:
      if ((player[0].pcPosition.x < xMin[1]) || (player[0].pcPosition.y < yMin[1]) 
        || (xMax[1] < player[0].pcPosition.x) || (yMax[1] < player[0].pcPosition.y)) {
        //println("NO");
      } else {
        println("Collided with button");
        currentPosition++;
        boss[0].phase++;
      }
      break;

    case 2:
      if ((player[0].pcPosition.x < xMin[2]) || (player[0].pcPosition.y < yMin[2]) 
        || (xMax[2] < player[0].pcPosition.x) || (yMax[2] < player[0].pcPosition.y)) {
        //println("NO");
      } else {
        println("Collided with button");
        currentPosition++;
        boss[0].phase++;
      }
      break;

    case 3:
      if ((player[0].pcPosition.x < xMin[3]) || (player[0].pcPosition.y < yMin[3]) 
        || (xMax[3] < player[0].pcPosition.x) || (yMax[3] < player[0].pcPosition.y)) {
        //println("NO");
      } else {
        println("Collided with button");
        currentPosition++;
        boss[0].phase++;
        if (currentPosition > 3) {
          player[0].points += 200;
          state = 5;
        }
      }
      break;

    default:
      println("Collided with button");
      currentPosition++;
      if (currentPosition > 3) {
        player[0].points += 200;
        state = 5;
      }
      break;
    }
  }
}
