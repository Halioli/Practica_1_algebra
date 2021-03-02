// VARIABLES
int startPortalX, startPortalY;
int secondPortalX, secondPortalY;  // height/2
int thirdPortalX, thirdPortalY;    // width/2
int fourthPortalX, fourthPortalY;  // width, height/2
float time;
char gameOver, win;

String textInput = "";
boolean start = false;
boolean result = false;

// PC Variables
int lives;
int health;  // form 0 to 100
int pcSpeed;
int points;
int powerUp;  // Boost speed, Freeze time, Heal 

// NPC Variables
int n;  // Detemined by User Input
int[] npcFollowers;  // 1/3 of n
int[] npcRunners;    // 1/3 of n
int[] npcWanderers;  // 1/3 of n
int maxSpeed;
int minSpeed;

// BOSS Variables

// FUNCTIONS
void settings() {
  // Window's size
  size(1600, 900);
}

void setup() {
  // Black background
  background(0);
}

void draw() {
  if (!start) {
    text(textInput, width/2, height/2);
  } else {
    
    background(200);
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
        delay(1000);
        start = true;
      } else {
        println("messirve");
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
