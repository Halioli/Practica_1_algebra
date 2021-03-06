// PRACTICA 2: ENUNCIAT 1  //<>//

// VARIABLES
int inputKey;
int numParticle = 10;
int numSpring = 10;

Particle[][] particles = new Particle[numParticle][numParticle];
Spring[][] springs = new Spring[numSpring][numSpring];

int inputCase;

// Force variables
float friction = 0.05;
float gravity = 9.8;
float third;
PVector SpringEquilDist = new PVector(0, -30, 0);
float constant = 1;


// SETUP
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
void setup() {
  size(800, 600, P3D);

  // Set initial positions
  int counterI = 0;
  int counterJ = -(height/4); 

  // CLASS CONSTRUCTORS

  // Particles
  for (int i = 0; i < numParticle; i++) {
    for (int j = 0; j < numParticle; j++) {
      if (j == 0 && i == 0 || j == 0 && i == numParticle - 1)
        particles[i][j] = new Particle 
          (new PVector(i + counterI, j + counterJ, 0.0), new PVector(0.0, 0.0, 0.0), true);
      else { 
        particles[i][j] = new Particle 
          (new PVector(i + counterI, j + counterJ, 0.0), new PVector(0.0, 0.0, 0.0), false);
      }
      counterJ += 30;
    }
    counterI += 30;
    counterJ = -(height/4);
  }

  // Springs
  for (int i = 0; i < numSpring; i++) {
    for (int j = 0; j < numSpring; j++) {

      springs[i][j] = new Spring (constant, SpringEquilDist.x, SpringEquilDist.y, SpringEquilDist.z);

      counterJ += 30;
    }
    counterI += 30;
    counterJ = 0;
  }
}


// DRAW
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
void draw() {
  background(0);

  // ISOMETRIC VIEW
  // Draw everything in the middle of the screen
  translate(width/2.0, height/2.0, 0.0);
  rotateX(radians(-35.26));
  rotateY(radians(-45.0));
  
  // Print
  strokeWeight(2);
  // X axis (red)
  stroke(255, 0, 0);
  line(0.0, 0.0, 0.0, 250.0, 0.0, 0.0);
  // Y axis (green)
  stroke(0, 255, 0);
  line(0.0, 0.0, 0.0, 0.0, -250.0, 0.0);
  // Z axis (blue)
  stroke(0, 0, 255);
  line(0.0, 0.0, 0.0, 0.0, 0.0, 250.0);

  // Print all the particles
  for (int i = 0; i < numParticle; i++) {
    for (int j = 0; j < numParticle; j++) {
      particles[i][j].drawn();
      particles[i][j].move();
    }
  }

  // Print all the springs
  PrintSprings();
}


// KEY INPUTS
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
void keyPressed() {
  // Get the value of the key pressed
  inputKey = int(key);  // int('0') = 48

  if (inputCase == 0) {

    // Letter input
    switch (inputKey) {
    case 102: // f = friction --> 102
      println("Valid digit: " + key);
      inputCase = 1;
      break;
    case 103: // g = gravity --> 103
      println("Valid digit: " + key);
      inputCase = 2;
      break;
    case 116: // t = third --> 116
      println("Valid digit: " + key);
      inputCase = 3;
      break;
    case 120: // x = equilibriumDistanceX --> 120
      println("Valid digit: " + key);
      inputCase = 4;
      break;
    case 121: // y = equilibriumDistanceY --> 121
      println("Valid digit: " + key);
      inputCase = 5;
      break;
    case 122: // z = equilibriumDistanceZ --> 122
      println("Valid digit: " + key);
      inputCase = 6;
      break;
    default:
      println("Invalid, you pressed: " + key);
      inputCase = 0;
      break;
    }
    
  } else {
    
    // Number input
    inputKey = inputKey - 48;
    if (inputKey >= 0 && inputKey <= 9) {
      println("Valid digit: " + inputKey);

      switch (inputCase) {
      case 1: // friction
        friction = (float)inputKey/100;
        break;
      case 2: // gravity
        gravity = (float)inputKey;
        break;
      case 3: // third
        third = (float)inputKey;
        break;
      case 4: // equilibriumDistanceX
        SpringEquilDist.x = (float)inputKey;
        break;
      case 5: // equilibriumDistanceY
        SpringEquilDist.y = (float)-(inputKey * 10);
        break;
      case 6: // equilibriumDistanceZ
        SpringEquilDist.z = (float)inputKey;
        break;
      default:
        println("Something went wrong");
        break;
      }

      inputCase = 0;
      
      // Reset the scene
      setup();
    } else {
      
      println("Invalid you pressed " + key);
      inputCase = 0;
    }
  }
}
