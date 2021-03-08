// VARIABLES //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
float startPortalX, startPortalY;
float secondPortalX, secondPortalY;  // height/2
float thirdPortalX, thirdPortalY;    // width/2
float fourthPortalX, fourthPortalY;  // width, height/2

float topWidth, topHeight;
float rightWidth, rightHeight;

float time;
char gameOver, win;

String textInput = "";
boolean start = false;
boolean result = false;

// PC Variables
int lives;
int health;  // fromm 0 to 100
int points;
int powerUp;  // Boost speed, Freeze time, Heal 
int pcRadius;
float pcPositionX, pcPositionY;
float pcSpeed = 2;
boolean pcStartDrawn;

// NPC Variables
int n;  // Detemined by User Input
float[] npcFollowersX, npcFollowersY;  // 1/3 of n
float[] npcRunnersX, npcRunnersY;    // 1/3 of n
float[] npcWanderersX, npcWanderersY;  // 1/3 of n
float maxSpeed;
float minSpeed;
float[] npcSpeed;
int npcRadius = 8;
float vectorXFollower, vectorYFollower;
float moduloFollower;



// BOSS Variables

// FUNCTIONS
void settings() {
  // Window's size
  size(1600, 900);
}

void setup() {
  // Black background
  background(0);

  //Set Portal Size
  topWidth = 100;
  topHeight = 20;
  rightWidth = 20; 
  rightHeight = 100;

  //Set Start Portal coords
  startPortalX = width/2 - topWidth/2;
  startPortalY = height - topHeight;

  //Set Exit Portal coords
  secondPortalX = 0;
  secondPortalY = height/2 - rightHeight/2;

  thirdPortalX = width/2 - topWidth/2;
  thirdPortalY = 0;

  fourthPortalX = width - rightWidth;
  fourthPortalY = height/2 - rightHeight/2;

  //PC variable values
  pcRadius = 12;
  pcStartDrawn = true;
  pcPositionX = startPortalX + topWidth/2;
  pcPositionY = startPortalY + topHeight/2;

  //Set npcSpeed randomly
  maxSpeed = 4;
  minSpeed = 1;
}

void draw() {
  if (!start) {
    text(textInput, width/2, height/2);
  } else {



    background(200);

    for (int i=0; i<n/3; i++) {
      fill(255, 0, 0);
      ellipse(npcFollowersX[i], npcFollowersY[i], npcRadius, npcRadius);
      fill(0, 255, 0);
      ellipse(npcRunnersX[i], npcRunnersY[i], npcRadius, npcRadius);
      fill(0, 0, 255);
      ellipse(npcWanderersX[i], npcWanderersY[i], npcRadius, npcRadius);
    }

    //Start Portal color and instance
    fill(252, 250, 66); //Yellow
    rect(startPortalX, startPortalY, topWidth, topHeight);

    //Exit portals color and instance
    fill(231, 36, 250); //Purple
    rect(secondPortalX, secondPortalY, rightWidth, rightHeight);
    rect(thirdPortalX, thirdPortalY, topWidth, topHeight);
    rect(fourthPortalX, fourthPortalY, rightWidth, rightHeight);

    if (pcStartDrawn) {
      //Starting draw PC
      fill( 247, 163, 255);
      ellipse(pcPositionX, pcPositionY, (float)pcRadius, pcRadius);
      pcStartDrawn = false;
    } else {
      movePCMouse();
      moveNPCFollower();
    }
  }
}

// EVENTS (callbacks)

void keyPressed() {
  if (!start) {
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
        start = true;
      } else {
        println("no messirve");
        background(0);
        text("Invalid input", width/2, height/2 -20);
        textInput = "";
      }
    } else {
      textInput+=key;
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

void SpawnEnemies(int numEnemies) {

  //int remainder = numEnemies % 3;
  numEnemies /= 3;

  npcFollowersX = new float[numEnemies];
  npcFollowersY = new float[numEnemies];

  npcRunnersX = new float[numEnemies];
  npcRunnersY = new float[numEnemies];

  npcWanderersX = new float[numEnemies];
  npcWanderersY = new float[numEnemies];

  int counter = 0;
  for (int i=0; i<numEnemies; i++)
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
}

void movePCMouse() {
  //1- Evaluate a vector
  float vectorX, vectorY;
  vectorX = mouseX-pcPositionX;
  vectorY = mouseY-pcPositionY;
  //2- Normalize the vector
  float modulo = sqrt(vectorX*vectorX + vectorY*vectorY);
  vectorX/=modulo; 
  vectorY/=modulo;
  //3- Scale the vector
  vectorX*=pcSpeed; 
  vectorY*=pcSpeed;
  //4- Move the enemy
  pcPositionX += vectorX;
  pcPositionY += vectorY;

  //5- Draw everything
  ellipse(pcPositionX, pcPositionY, 15, 15);
}

void moveNPCFollower() {


  for (int i=0; i < npcFollowersY.length; i++) {
    // Evaluate a vector
    vectorXFollower = pcPositionX-npcFollowersX[i];
    vectorYFollower = pcPositionY-npcFollowersY[i];
    // Normalize the vector
    moduloFollower = sqrt(vectorXFollower*vectorXFollower + vectorYFollower*vectorYFollower);

    //Initialize all the enemies speed
    npcSpeed[i] = random(minSpeed, maxSpeed);
    vectorXFollower/=moduloFollower; 
    vectorYFollower/=moduloFollower;
    //3- Scale the vector
    vectorXFollower*=npcSpeed[i]; 
    vectorYFollower*=npcSpeed[i];

    //4- Move the enemy
    npcFollowersX[i] += vectorXFollower;
    npcFollowersY[i] += vectorYFollower;
    //5- Draw everything
    fill(255, 0, 0);
    ellipse(npcFollowersX[i], npcFollowersY[i], 15, 15);
  }
}
