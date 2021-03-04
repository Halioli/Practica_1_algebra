// VARIABLES //<>// //<>// //<>// //<>// //<>//
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
PVector pcSpeedV;
PVector pcLocationV;
int points;
int powerUp;  // Boost speed, Freeze time, Heal 
int pcRadius;
boolean pcStartDrawn;
Mover[] movers = new Mover[1]; // FRANKENSTEIN instancia Mover/Player

// NPC Variables
int n;  // Detemined by User Input
float[] npcFollowersX, npcFollowersY;  // 1/3 of n
float[] npcRunnersX, npcRunnersY;    // 1/3 of n
float[] npcWanderersX, npcWanderersY;  // 1/3 of n
int maxSpeed;
int minSpeed;
int npcRadius = 8;

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
  pcLocationV = new PVector(startPortalX + topWidth/2, startPortalY + topHeight/2);
  pcSpeedV = new PVector(2.5, 5);

  // FRANKENSTEIN declarar tots els Movers/Player
  //mouse = new PVector(mouseX, mouseY);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover();
  }
}

void draw() {
  noStroke();
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
      ellipse(startPortalX + topWidth/2, startPortalY + topHeight/2, (float)pcRadius, pcRadius);
      pcStartDrawn = false;
    } else {
      // FRANKENSTEIN update location
      for (int i = 0; i < movers.length; i++) {
        movers[i].update();
        movers[i].checkEdges();
        movers[i].display();
      }
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

void mouseMoved() {
  if (start && !pcStartDrawn) {
  }
}

// FRANKENSTEIN class Mover/Player
class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;

  Mover() {
    //location = new PVector(random(width), random(height));
    location = new PVector(startPortalX + topWidth/2, startPortalY + topHeight/2);
    velocity = new PVector(0, 0);
    topspeed = 4;
  }

  void update() {

    // Our algorithm for calculating acceleration:
    PVector mouse = new PVector(mouseX, mouseY);
    PVector dir = PVector.sub(mouse, location);  // Find vector pointing towards mouse
    dir.normalize();     // Normalize
    dir.mult(0.5);       // Scale 
    acceleration = dir;  // Set to acceleration

    // Motion 101!  Velocity changes by acceleration.  Location changes by velocity.
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }

  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, 16, 16);
  }

  void checkEdges() {

    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
  }
}
