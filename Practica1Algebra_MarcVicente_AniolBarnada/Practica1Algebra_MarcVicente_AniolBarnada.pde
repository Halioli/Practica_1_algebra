// VARIABLES // //<>// //<>//

// Portal
float startPortalX, startPortalY;
float secondPortalX, secondPortalY;  // height/2
float thirdPortalX, thirdPortalY;    // width/2
float fourthPortalX, fourthPortalY;  // width, height/2
int bossPortal;
Portal[] exitPortals = new Portal[3];

float topWidth, topHeight;
float rightWidth, rightHeight;

// User Input
String textInput = "";
boolean result = false;
int state;

// PC Variables
boolean pcStartDrawn;
boolean collidedTrigger = false;
Player[] player = new Player[1];

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
float moduloFollower;
float vectorXRunner, vectorYRunner;
float moduloRunner;
float vectorXWanderer, vectorYWanderer;
float moduloWanderer;
int playerRadiusCollider;

//Timer variables
String time = "102";
int t;
int interval = 102;

//Message Win/Lose strings
String gameOverMessage = "You lose";
String  winMessage = "You win";

//Object variables
Object[] objects = new Object[8];
// BOSS Variables


// FUNCTIONS //
// ===================================================
void settings() {
  // Window's size
  size(1600, 900);
}

void setup() {
  // Black background
  background(0);

  // Set rectangle mode
  rectMode(CENTER);

  // Set Portal Size
  topWidth = 100;
  topHeight = 20;
  rightWidth = 20; 
  rightHeight = 100;

  // Set Start Portal coords
  startPortalX = width/2;
  startPortalY = height - topHeight;

  // Set exit portal coords
  secondPortalX = rightWidth/2;
  secondPortalY = height/2 - rightHeight/2;

  thirdPortalX = width/2;
  thirdPortalY = topHeight/2;

  fourthPortalX = width - rightWidth/2;
  fourthPortalY = height/2 - rightHeight/2;

  // Set exit portal
  bossPortal = (int)random(0, 2);

  // Instantiate portals
  exitPortals[0] = new Portal(secondPortalX, secondPortalY, false);
  exitPortals[1] = new Portal(thirdPortalX, thirdPortalY, true);
  exitPortals[2] = new Portal(fourthPortalX, fourthPortalY, false);
  exitPortals[bossPortal].bossPortal = true;

  // PC variable values
  player[0] = new Player(startPortalX, startPortalY);
  pcStartDrawn = true;

  // Instantiate objects
  for (int i=0; i < objects.length; i++) {
    objects[i] = new Object();
  }

  // Set npcSpeed
  maxSpeed = 3;
  minSpeed = 0.5;

  // Set radius action runner
  playerRadiusCollider = player[0].pcRadius + 200;

  // Set text size
  textSize(26);
}

// DRAW
// ===================================================
void draw() {
  switch(state) {
    // Choose Enemies(n) Screen
  case 0:
    text(textInput, width/2, height/2);
    break;

    // First scene
  case 1:
    background(200);

    // Timer
    t = interval - int(millis()/1000);
    time = nf(t, 3);
    if (t == 0) {
      player[0].lives--;
      interval += 100;
    }
    fill(0);
    text(time, 20, 40);

    // Nº lives
    text("Lives: " + player[0].lives, 20, height - 40);

    // Health bar
    fill(0);
    rect(width - 150, height - 35, 100, 30);
    fill(0, 255, 0);
    rect(width - 150, height - 35, player[0].health, 30);

    //Points Text
    fill(0);
    text("Points: " + player[0].points, 20, height - 80);
    // Spawn NPC's intial positions
    for (int i = 0; i < n/3; i++) {
      fill(255, 0, 0);
      ellipse(npcFollowersX[i], npcFollowersY[i], npcRadius, npcRadius);
      fill(0, 255, 0);
      ellipse(npcRunnersX[i], npcRunnersY[i], npcRadius, npcRadius);
      fill(0, 0, 255);
      ellipse(npcWanderersX[i], npcWanderersY[i], npcRadius, npcRadius);
    }

    // Start Portal color and instance
    fill(252, 250, 66); // Yellow
    rect(startPortalX, startPortalY, topWidth, topHeight);

    // Exit portals color and instance
    for (int i = 0; i < 3; i++) {
      exitPortals[i].display();
      exitPortals[i].update();
    }

    // Starting draw PC
    player[0].display();
    player[0].update();

    for (int i=0; i< objects.length; i++) {
      objects[i].display();
      objects[i].update();
    }

    break;

  case 3:  
    // Boss battle state code
    background(0);
    break;

  case 4:
    // Lose Screen
    background(0);
    fill(255);
    textSize(40);
    text(gameOverMessage, width/2, height/2);
    break;

  case 5:
    // Win Screen
    background(0);
    fill(255);
    textSize(40);
    text(winMessage, width/2, height/2);
    break;

  default:
    // Something went wrong code
    text("Something went wrong", width/2, height/2);
    break;
  }
}

// EVENTS (callbacks) //
// ===================================================
void keyPressed() {
  if (state == 0) {
    text(textInput, width/2, height/2);
    if (key == BACKSPACE)
    {
      textInput = "";
      background(0);
    } else if (key == ENTER) {

      if (isInteger(textInput)) {
        n = Integer.parseInt(textInput);
        println("ha funcionado "+n);
        background(0);
        SpawnEnemies(n);
        delay(1000);
        state = 1;
      } else {
        println("no messirve");
        background(0);
        text("Invalid input", width/2, height/2 -20);
        textInput = "";
      }
    } else {
      textInput+=key;
    }
  } else if (state == 1 || state == 3) {
    if (key == CODED) {
      if (keyCode == UP) {
        player[0].pcPosition.y -= player[0].pcSpeed;
      } else if (keyCode == DOWN) {
        player[0].pcPosition.y += player[0].pcSpeed;
      } else if (keyCode == LEFT) {
        player[0].pcPosition.x -= player[0].pcSpeed;
      } else if (keyCode == RIGHT) {
        player[0].pcPosition.x += player[0].pcSpeed;
      }
    }
  }
}

boolean isInteger(String s) {
  boolean result = false;
  try {
    Integer.parseInt(s);
    result = true;
  }
  catch(NumberFormatException e) {
  }
  return result;
}

// Game start
void SpawnEnemies(int numEnemies) {
  //int remainder = numEnemies % 3;
  numEnemies /= 3;

  npcFollowersX = new float[numEnemies];
  npcFollowersY = new float[numEnemies];

  npcRunnersX = new float[numEnemies];
  npcRunnersY = new float[numEnemies];

  npcWanderersX = new float[numEnemies];
  npcWanderersY = new float[numEnemies];

  npcSpeed = new float[numEnemies];

  int counter = 0;
  for (int i = 0; i < numEnemies; i++)
  {
    switch(counter) {
    case 0:
      npcFollowersX[i] = (int)random(width/4);
      npcFollowersY[i] = (int)random(height/4);

      npcRunnersX[i] = (int)random(width/4);
      npcRunnersY[i] = (int)random(height/4);

      npcWanderersX[i] = (int)random(width/4);
      npcWanderersY[i] = (int)random(height/4);
      counter++;
      break;

    case 1:
      npcFollowersX[i] = (int)random(width/4 * 3, width);
      npcFollowersY[i] = (int)random(height/4);

      npcRunnersX[i] = (int)random(width/4 * 3, width);
      npcRunnersY[i] = (int)random(height/4);

      npcWanderersX[i] = (int)random(width/4 * 3, width);
      npcWanderersY[i] = (int)random(height/4);
      counter++;
      break;

    case 2:
      npcFollowersX[i] = (int)random(width/4);
      npcFollowersY[i] = (int)random(height/4 * 3, height);

      npcRunnersX[i] = (int)random(width/4);
      npcRunnersY[i] = (int)random(height/4 * 3, height);

      npcWanderersX[i] = (int)random(width/4);
      npcWanderersY[i] = (int)random(height/4 * 3, height);
      counter++;
      break;

    case 3:
      npcFollowersX[i] = (int)random(width/4 * 3, width);
      npcFollowersY[i] = (int)random(height/4 * 3, height);

      npcRunnersX[i] = (int)random(width/4 * 3, width);
      npcRunnersY[i] = (int)random(height/4 * 3, height);

      npcWanderersX[i] = (int)random(width/4 * 3, width);
      npcWanderersY[i] = (int)random(height/4 * 3, height);
      counter = 0;
      break;

    default:
      counter = 0;
      break;
    }
  }
  for (int i = 0; i < numEnemies; i++) {
    npcSpeed[i] = random(maxSpeed, minSpeed);
  }
}

// Player mouse movement
void mouseDragged() {
  if (!pcStartDrawn && (state != 4 || state != 5)) {
    // 1- Evaluate a vector
    float vectorX, vectorY;
    vectorX = mouseX - player[0].pcPosition.x;
    vectorY = mouseY - player[0].pcPosition.y;

    // 2- Normalize the vector
    float modulo = sqrt(vectorX*vectorX + vectorY*vectorY);
    vectorX /= modulo; 
    vectorY /= modulo;

    // 3- Scale the vector
    vectorX *= player[0].pcSpeed; 
    vectorY *= player[0].pcSpeed;

    // 4- Move the enemy
    player[0].pcPosition.x += vectorX;
    player[0].pcPosition.y += vectorY;

    // Collide with edges
    CollideWithEdgesPlayer();

    // 5- Draw everything
    fill(251, 208, 255);
    ellipse(player[0].pcPosition.x, player[0].pcPosition.y, 15, 15);
  }
}

void CollideWithEdgesPlayer() {
  if ((player[0].pcPosition.x + player[0].pcRadius) >= width ) {
    player[0].pcPosition.x -= 2;
  } else if ( (player[0].pcPosition.x + player[0].pcRadius) <= 0) {
    player[0].pcPosition.x = 2;
  } else if ( (player[0].pcPosition.y + player[0].pcRadius) <= 0) {
    player[0].pcPosition.y = 2;
  } else if ((player[0].pcPosition.y + player[0].pcRadius) >= height) {
    player[0].pcPosition.y -= 2;
  }
}

// AI
void moveFollower() {
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
      moduloFollower = sqrt(vectorXFollower * vectorXFollower + vectorYFollower * vectorYFollower);

      // Initialize all the enemies speed
      npcSpeed[i] = random(minSpeed, maxSpeed);
      vectorXFollower /= moduloFollower; 
      vectorYFollower /= moduloFollower;

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
      moduloRunner = sqrt(vectorXRunner * vectorXRunner + vectorYRunner * vectorYRunner);

      // Initialize all the enemies speed
      npcSpeed[i] = random(minSpeed, maxSpeed);
      vectorXRunner /= moduloRunner; 
      vectorYRunner /= moduloRunner;

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

void moveWanderer() {
  for (int i = 0; i < npcWanderersX.length; i++) {
    float[] distanceBetweenCenters;
    float magnitudeOfVector;
    distanceBetweenCenters = new float[2];

    distanceBetweenCenters[0] = player[0].pcPosition.x - npcRunnersX[i];  // Vector coords.
    distanceBetweenCenters[1] = player[0].pcPosition.y - npcRunnersY[i];  

    magnitudeOfVector = sqrt(distanceBetweenCenters[0] * distanceBetweenCenters[0] + // Vector's module/distance
      distanceBetweenCenters[1] * distanceBetweenCenters[1]); 

    //distanceCorrection = ((player[0].pcRadius + objects[i].objectRadius) - magnitude_of_vector)/2;
    // There's collision if...
    if (magnitudeOfVector * 2 < player[0].pcRadius + npcRadius) {
      if (player[0].pcPosition.x > npcWanderersX[i]) {
        player[0].points += 100;
        npcWanderersX[i] = -100;
        npcWanderersY[i] = -100;
      } else if (player[0].pcPosition.x < npcWanderersX[i]) {
        player[0].points += 100;
        npcWanderersX[i] = -100;
        npcWanderersY[i] = -100;
      } else if (player[0].pcPosition.y < npcWanderersY[i]) {
        player[0].points += 100;
        npcWanderersX[i] = -100;
        npcWanderersY[i] = -100;
      } else if (player[0].pcPosition.y > npcWanderersY[i]) {
        player[0].points += 100;
        npcWanderersX[i] = -100;
        npcWanderersY[i] = -100;
      }

      vectorXWanderer = random(width) - npcWanderersX[i];
      vectorYWanderer = random(height) - npcWanderersY[i];

      // Normalize the vector
      moduloWanderer = sqrt(vectorXWanderer * vectorXWanderer + vectorYWanderer * vectorYWanderer);

      // Initialize all the enemies speed
      npcSpeed[i] = random(minSpeed, maxSpeed);
      vectorXWanderer /= moduloWanderer; 
      vectorYWanderer /= moduloWanderer;

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
    }
  }
}


// Classes
class Portal {
  PVector location;
  boolean topPortal;
  boolean bossPortal;

  //boolean collided;
  float xMin;
  float yMin;
  float xMax;
  float yMax;

  Portal (float coordX, float coordY, boolean isTop) {
    location = new PVector(coordX, coordY);
    topPortal = isTop;
    if (isTop) {
      xMin = location.x - topWidth/2; 
      yMin = location.y - topHeight/2;
      xMax = location.x + topWidth/2;
      yMax = location.y + topHeight/2;
    } else {
      xMin = location.x - rightWidth/2; 
      yMin = location.y - rightHeight/2;
      xMax = location.x + rightWidth/2;
      yMax = location.y + rightHeight/2;
    }
  }

  void display() {
    // Exit portals color and instance
    fill(231, 36, 250); // Purple
    if (topPortal) {
      rect(location.x, location.y, topWidth, topHeight);
    } else {
      rect(location.x, location.y, rightWidth, rightHeight);
    }
  }

  void update() {
    // Look collisions
    if ((player[0].pcPosition.x < xMin) || (player[0].pcPosition.y < yMin) 
      || (xMax < player[0].pcPosition.x) || (yMax < player[0].pcPosition.y)) {
      //println("NO");
    } else {
      println("Collided with portal");
      if (bossPortal)
      {
        state = 3;
      } else {
        player[0].pcPosition.x = startPortalX;
        player[0].pcPosition.y = startPortalY;
      }
    }
  }
}

class Player {
  int lives;
  int health;
  int points;
  int pcRadius;
  float pcSpeed;
  float pcMaxSpeed = 2;
  PVector pcPosition;
  boolean collidedTrigger = false;

  Player (float coordX, float coordY) {
    lives = 3;
    health = 100;
    points = 0; 
    pcRadius = 12;
    pcSpeed = pcMaxSpeed;
    pcPosition = new PVector(coordX, coordY);
  }

  void display() {
    if (pcStartDrawn) {
      fill( 247, 163, 255);
      ellipse(pcPosition.x, pcPosition.y, pcRadius, pcRadius);
      noFill();
      ellipse(pcPosition.x, pcPosition.y, playerRadiusCollider, playerRadiusCollider);
      pcStartDrawn = false;
    } else {      
      ellipse(pcPosition.x, pcPosition.y, 15, 15);
      moveFollower();
      moveNPCRunner();
      moveWanderer();
    }
  }

  void update() {
    // Do stuff
    if (health == 0) {
      lives--;
      health = 100;
    }
    if (player[0].lives == 0)
    {
      state = 4;
    }
  }
}


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
        if ((player[0].pcPosition.x < xMin) || (player[0].pcPosition.y < yMin) ||
          (xMax < player[0].pcPosition.x) || (yMax < player[0].pcPosition.y)) {
          //println("NO");
        } else {
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
      }
    }
  }
}
