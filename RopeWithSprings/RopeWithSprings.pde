// ROPE WITH 5 PARTICLES

// VARIABLES
int numParticle = 10;
int numSpring = 9;
Particle[][] particleArray = new Particle[numParticle][numParticle];
Spring[][] springArray = new Spring[numSpring][numSpring];

// CLASS
class Spring {
  // Atributes
  float constant, equilibriumDistanceX, equilibriumDistanceY, equilibriumDistanceZ;

  // Constructor
  Spring (float c, float dX, float dY, float dZ) {
    constant = c;
    equilibriumDistanceX = dX;
    equilibriumDistanceY = dY;
    equilibriumDistanceZ = dZ;
  }

  PVector getStrenght (Particle p0, Particle p1, Particle p2) {
    PVector f = new PVector(0.0, 0.0, 0.0);

    // Hooke
    f.x = -constant * (equilibriumDistanceX - (p1.pos.x - p0.pos.x));
    f.y = -constant * (equilibriumDistanceY - (p1.pos.y - p0.pos.y));
    f.z = -constant * (equilibriumDistanceZ - (p1.pos.z - p0.pos.z));

    return f;
  }

  void drawn (Particle p0, Particle p1) {
    stroke (255, 255, 0);
    line(p0.pos.x, p0.pos.y, p1.pos.x, p1.pos.y);
  }
}

class Particle {
  // Atributes
  PVector pos, vel, forceAcumulator;
  float mass, size, frictionConstant;
  boolean isStatic;

  // Constructor
  Particle (PVector p, PVector v, boolean sta) {
    pos = new PVector(0.0, 0.0, 0.0);
    pos = p;
    vel = new PVector(0.0, 0.0, 0.0);
    vel = v;
    forceAcumulator = new PVector(0.0, 0.0, 0.0);
    mass = 1.0;
    size = 5.0;
    frictionConstant = 0.01;
    isStatic = sta;
  }

  //Methods
  void move() {
    PVector accel = new PVector(0.0, 0.0, 0.0);
    float tInc = 0.04;

    if (!isStatic) {
      // Gravity
      forceAcumulator.x += 0.0;
      forceAcumulator.y += 9.8;
      forceAcumulator.z += 0.0;

      // Friction
      forceAcumulator.x -= frictionConstant * vel.x;
      forceAcumulator.y -= frictionConstant * vel.y;
      forceAcumulator.z -= frictionConstant * vel.z;

      // Euler's solver
      accel.x = forceAcumulator.x / mass;
      accel.y = forceAcumulator.y / mass;
      accel.z = forceAcumulator.z / mass;

      vel.x += accel.x * tInc;
      vel.y += accel.y * tInc;
      vel.z += accel.z * tInc;

      pos.x += vel.x * tInc;
      pos.y += vel.y * tInc;
      pos.z += vel.z * tInc;

      // Reset
      forceAcumulator.x = 0.0;
      forceAcumulator.y = 0.0;
      forceAcumulator.z = 0.0;
    }
  }

  void drawn() {
    strokeWeight(2);
    noFill();
    stroke(255, 0, 0);
    ellipse(pos.x, pos.y, size, size);
  }
}

// SETUP
void setup() {
  size(800, 600, P3D);

  int counterI = width/3;
  int counterJ = 0; 

  // Class constructors

  // Particles
  for (int i = 0; i < numParticle; i++) {
    for (int j = 0; j < numParticle; j++) {

      particleArray[i][j] = new Particle (new PVector(i + counterI, j + counterJ, 0.0), new PVector(0.0, 0.0, 0.0), true);
      counterJ += 30;
    }
    counterI += 30;
    counterJ = 0;
  }

  for (int i = 0; i < numSpring; i++) {
    for (int j = 0; j < numSpring; j++) {

      springArray[i][j] = new Spring (0.2, i + counterI, j + counterJ, 0);
      counterJ += 30;
    }
    counterI += 30;
    counterJ = 0;
  }
  /*particleArray[0] = new Particle (new PVector(width/2.0 - 200.0, height/2.0), 
   new PVector(0.0, 0.0), true);
   
   particleArray[1] = new Particle (new PVector(width/2.0 - 100.0, height/2.0), 
   new PVector(0.0, 0.0), true);
   
   particleArray[2] = new Particle (new PVector(width/2.0, height/2.0), 
   new PVector(0.0, 0.0), true);
   
   particleArray[3] = new Particle (new PVector(width/2.0 + 100.0, height/2.0), 
   new PVector(0.0, 0.0), true);
   
   particleArray[4] = new Particle (new PVector(width/2.0 + 200.0, height/2.0), 
   new PVector(0.0, 0.0), true);*/

  // Springs
  /*springArray[0] = new Spring(0.2, 50.0, 100.0, 10);
   springArray[1] = new Spring(0.2, 50.0, 100.0, 10);
   springArray[2] = new Spring(0.2, 50.0, 100.0, 10);
   springArray[3] = new Spring(0.2, 50.0, 100.0, 10);*/
}

// DRAW
void draw() {
  background(0);

  PVector sSpring = new PVector(0.0, 0.0);

  for (int i = 0; i < numParticle; i++) {
    for (int j = 0; j < numParticle; j++) {
      particleArray[i][j].drawn();
      particleArray[i][j].move();
    }
  }

  for (int i = 0; i < numParticle; i++) {
    for (int j = 0; j < numParticle; j++) {
      /*if (j == 0) 
       if(i == 0)*/
    }
  }
  // Spring 1
  /*sSpring = springArray[0].getStrenght(particleArray[0], particleArray[1]);
   particleArray[0].forceAcumulator.x += sSpring.x;
   particleArray[0].forceAcumulator.y += sSpring.y;
   particleArray[0].forceAcumulator.z += sSpring.z;
   particleArray[1].forceAcumulator.x -= sSpring.x;
   particleArray[1].forceAcumulator.y -= sSpring.y;
   particleArray[1].forceAcumulator.z += sSpring.z;
   // Spring 2
   sSpring = springArray[1].getStrenght(particleArray[1], particleArray[2]);
   particleArray[1].forceAcumulator.x += sSpring.x;
   particleArray[1].forceAcumulator.y += sSpring.y;
   particleArray[1].forceAcumulator.z += sSpring.z;
   particleArray[2].forceAcumulator.x -= sSpring.x;
   particleArray[2].forceAcumulator.y -= sSpring.y;
   particleArray[2].forceAcumulator.z += sSpring.z;
   // Spring 3
   sSpring = springArray[2].getStrenght(particleArray[2], particleArray[3]);
   particleArray[2].forceAcumulator.x += sSpring.x;
   particleArray[2].forceAcumulator.y += sSpring.y;
   particleArray[2].forceAcumulator.z += sSpring.z;
   particleArray[3].forceAcumulator.x -= sSpring.x;
   particleArray[3].forceAcumulator.y -= sSpring.y;
   particleArray[3].forceAcumulator.z += sSpring.z;
   // Spring 4
   sSpring = springArray[3].getStrenght(particleArray[3], particleArray[4]);
   particleArray[3].forceAcumulator.x += sSpring.x;
   particleArray[3].forceAcumulator.y += sSpring.y;
   particleArray[3].forceAcumulator.z += sSpring.z;
   particleArray[4].forceAcumulator.x -= sSpring.x;
   particleArray[4].forceAcumulator.y -= sSpring.y;
   particleArray[4].forceAcumulator.z += sSpring.z;
   */

  //Printa lineas
  /*springArray[0].drawn(particleArray[0], particleArray[1]);
   springArray[1].drawn(particleArray[1], particleArray[2]);
   springArray[2].drawn(particleArray[2], particleArray[3]);
   springArray[3].drawn(particleArray[3], particleArray[4]);
   */
}
