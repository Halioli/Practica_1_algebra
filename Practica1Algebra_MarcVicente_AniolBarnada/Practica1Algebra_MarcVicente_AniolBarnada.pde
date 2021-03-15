// VARIABLES // //<>// //<>//
float topWidth, topHeight;
float rightWidth, rightHeight;

// User Input
String textInput = "";
boolean result = false;
int state;

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
        player[0].pcSpeed = 7;
        player[0].pcPosition.y -= player[0].pcSpeed;
      } else if (keyCode == DOWN) {
        player[0].pcSpeed = 7;
        player[0].pcPosition.y += player[0].pcSpeed;
      } else if (keyCode == LEFT) {
        player[0].pcSpeed = 7;
        player[0].pcPosition.x -= player[0].pcSpeed;
      } else if (keyCode == RIGHT) {
        player[0].pcSpeed = 7;
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
