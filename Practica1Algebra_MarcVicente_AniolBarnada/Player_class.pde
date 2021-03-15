boolean pcStartDrawn;
boolean collidedTrigger = false;
Player[] player = new Player[1];

class Player {
  int lives;
  int health;
  int points;
  int pcRadius;
  float pcSpeed;
  float pcMaxSpeed = 1;
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
      moveNPCFollower();
      moveNPCRunner();
      moveNPCWanderer();
    }
  }

  void update() {
    // Do stuff
    if (health <= 0) {
      lives--;
      health = 100;
    }
    if (player[0].lives == 0)
    {
      state = 4;
    }
  }
}
