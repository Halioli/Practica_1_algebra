// PRACTICA 2: ENUNCIAT 1  //<>//

// VARIABLES
int inputKey;
int numParticle = 5;
int numSpring = 5;

Particle[][] particles = new Particle[numParticle][numParticle];
Spring[][] springs = new Spring[numSpring][numSpring];
//Spring[][] springsV = new Spring[numSpring - 1][numSpring - 1];

int inputCase;

// Force variables
float friction = 0.02;
float gravity = 9.8;
float third;
PVector SpringEquilDist = new PVector(20.0, 10.0, 20.0);

// SETUP
void setup() {
  size(800, 600, P3D);

  int counterI = 0;
  int counterJ = -(height/4); 

  // Class constructors

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

      springs[i][j] = new Spring (0.5, SpringEquilDist.x, SpringEquilDist.y, SpringEquilDist.z);
      //springsV[i][j] = new Spring (0.5, 20.0, 10.0, 20.0);

      counterJ += 30;
    }
    counterI += 30;
    counterJ = 0;
  }
}

// DRAW
void draw() {
  background(0);

  // ISOMETRIC VIEW
  // 1. Draw everything in the middle of the screen
  translate(width/2.0, height/2.0, 0.0);
  rotateX(radians(-35.26));
  rotateY(radians(-45.0));
  
  // 2. Print 
  // axis to print: X-red,Y-green, Z-blue 
  strokeWeight(2);
  // X axis
  stroke(255, 0, 0);
  line(0.0, 0.0, 0.0, 250.0, 0.0, 0.0);
  // Y axis
  stroke(0, 255, 0);
  line(0.0, 0.0, 0.0, 0.0, -250.0, 0.0);
  // Z axis
  stroke(0, 0, 255);
  line(0.0, 0.0, 0.0, 0.0, 0.0, 250.0);

  //Print all the particles
  for (int i = 0; i < numParticle; i++) {
    for (int j = 0; j < numParticle; j++) {
      particles[i][j].drawn();
      particles[i][j].move();
    }
  }

  //Print all the springs
  PrintSprings();
}

// KEYS
void keyPressed() {
  // get the value of the key pressed
  inputKey = int(key);  // int('0') = 48

  if (inputCase == 0) {

    switch (inputKey) {
    case 102: // f = fricció --> 102
      println("Valid digit: " + key);
      inputCase = 1;
      break;
    case 103: // g = gravetat --> 103
      println("Valid digit: " + key);
      inputCase = 2;
      break;
    case 116: // t = tercera --> 116
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
    inputKey = inputKey - 48;
    if (inputKey >= 0 && inputKey <= 9) {
      println("Valid digit: " + inputKey);

      switch (inputCase) {
      case 1: // f = fricció --> 102
        friction = (float)inputKey/100;
        break;
      case 2: // g = gravetat --> 103
        gravity = (float)inputKey;
        break;
      case 3: // t = tercera --> 116
        third = (float)inputKey;
        break;
      case 4: // x = equilibriumDistanceX --> 120
        SpringEquilDist.x = (float)inputKey;
        break;
      case 5: // y = equilibriumDistanceY --> 121
        SpringEquilDist.y = (float)inputKey;
        break;
      case 6: // z = equilibriumDistanceZ --> 122;
        SpringEquilDist.z = (float)inputKey;
        break;
      default:
        println("Something went wrong");
        break;
      }

      inputCase = 0;
      setup();
    } else {
      println("Invalid you pressed " + key);
      inputCase = 0;
    }
  }
}
