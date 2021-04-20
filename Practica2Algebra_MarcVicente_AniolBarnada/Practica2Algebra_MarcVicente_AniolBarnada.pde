// PRACTICA 2: ENUNCIAT 1 

// VARIABLES
int numParticle = 10;
int numSpring = 9;
Particle[][] particles = new Particle[numParticle][numParticle];
Spring[][] springs = new Spring[numSpring][numSpring];

// SETUP
void setup() {
  size(800, 600, P3D);

  int counterI = width/3;
  int counterJ = 0; 

  // Class constructors

  // Particles
  for (int i = 0; i < numParticle; i++) {
    for (int j = 0; j < numParticle; j++) {

      particles[i][j] = new Particle (new PVector(i + counterI, j + counterJ, 0.0), new PVector(0.0, 0.0, 0.0), true);
      counterJ += 30;
    }
    counterI += 30;
    counterJ = 0;
  }

  // Springs
  for (int i = 0; i < numSpring; i++) {
    for (int j = 0; j < numSpring; j++) {

      springs[i][j] = new Spring (0.2, i + counterI, j + counterJ, 0);
      counterJ += 30;
    }
    counterI += 30;
    counterJ = 0;
  }
}

// DRAW
void draw() {
  background(0);

  PVector sSpring = new PVector(0.0, 0.0, 0.0);

  //Print all the particles
  for (int i = 0; i < numParticle; i++) {
    for (int j = 0; j < numParticle; j++) {
      particles[i][j].drawn();
      particles[i][j].move();
    }
  }

  //Print all the springs
  for (int i = 1; i < numSpring; i++) {
    for (int j = 1; j < numSpring; j++) {  // NEED TO SEPARATE FIRST COLUMN & LINE
      // Left spring to particle
      springs[i][j].drawn(particles[i][j], particles[i - 1][j]);
      particles[i][j].forceAcumulator.x += sSpring.x;
      particles[i][j].forceAcumulator.y += sSpring.y;
      particles[i][j].forceAcumulator.z += sSpring.z;
      particles[i - 1][j].forceAcumulator.x -= sSpring.x;
      particles[i - 1][j].forceAcumulator.y -= sSpring.y;
      particles[i - 1][j].forceAcumulator.z += sSpring.z;
      
      // Top spring to particle
      springs[i][j].drawn(particles[i][j], particles[i][j - 1]);
      particles[i][j].forceAcumulator.x += sSpring.x;
      particles[i][j].forceAcumulator.y += sSpring.y;
      particles[i][j].forceAcumulator.z += sSpring.z;
      particles[i][j - 1].forceAcumulator.x -= sSpring.x;
      particles[i][j - 1].forceAcumulator.y -= sSpring.y;
      particles[i][j - 1].forceAcumulator.z += sSpring.z;
      
      // Top left spring to particle
      springs[i][j].drawn(particles[i][j], particles[i - 1][j - 1]);
      particles[i][j].forceAcumulator.x += sSpring.x;
      particles[i][j].forceAcumulator.y += sSpring.y;
      particles[i][j].forceAcumulator.z += sSpring.z;
      particles[i - 1][j - 1].forceAcumulator.x -= sSpring.x;
      particles[i - 1][j - 1].forceAcumulator.y -= sSpring.y;
      particles[i - 1][j - 1].forceAcumulator.z += sSpring.z;
      
      // Top right spring to particle
      springs[i][j].drawn(particles[i][j], particles[i + 1][j - 1]);
      particles[i][j].forceAcumulator.x += sSpring.x;
      particles[i][j].forceAcumulator.y += sSpring.y;
      particles[i][j].forceAcumulator.z += sSpring.z;
      particles[i + 1][j - 1].forceAcumulator.x -= sSpring.x;
      particles[i + 1][j - 1].forceAcumulator.y -= sSpring.y;
      particles[i + 1][j - 1].forceAcumulator.z += sSpring.z;
    }
  }
  // Spring 1
  /*sSpring = springs[0].getStrenght(particles[0], particles[1]);
   particles[0].forceAcumulator.x += sSpring.x;
   particles[0].forceAcumulator.y += sSpring.y;
   particles[0].forceAcumulator.z += sSpring.z;
   particles[1].forceAcumulator.x -= sSpring.x;
   particles[1].forceAcumulator.y -= sSpring.y;
   particles[1].forceAcumulator.z += sSpring.z;
   // Spring 2
   sSpring = springs[1].getStrenght(particles[1], particles[2]);
   particles[1].forceAcumulator.x += sSpring.x;
   particles[1].forceAcumulator.y += sSpring.y;
   particles[1].forceAcumulator.z += sSpring.z;
   particles[2].forceAcumulator.x -= sSpring.x;
   particles[2].forceAcumulator.y -= sSpring.y;
   particles[2].forceAcumulator.z += sSpring.z;
   // Spring 3
   sSpring = springs[2].getStrenght(particles[2], particles[3]);
   particles[2].forceAcumulator.x += sSpring.x;
   particles[2].forceAcumulator.y += sSpring.y;
   particles[2].forceAcumulator.z += sSpring.z;
   particles[3].forceAcumulator.x -= sSpring.x;
   particles[3].forceAcumulator.y -= sSpring.y;
   particles[3].forceAcumulator.z += sSpring.z;
   // Spring 4
   sSpring = springs[3].getStrenght(particles[3], particles[4]);
   particles[3].forceAcumulator.x += sSpring.x;
   particles[3].forceAcumulator.y += sSpring.y;
   particles[3].forceAcumulator.z += sSpring.z;
   particles[4].forceAcumulator.x -= sSpring.x;
   particles[4].forceAcumulator.y -= sSpring.y;
   particles[4].forceAcumulator.z += sSpring.z;
   */

  //Printa lineas
  /*springs[0].drawn(particles[0], particles[1]);
   springs[1].drawn(particles[1], particles[2]);
   springs[2].drawn(particles[2], particles[3]);
   springs[3].drawn(particles[3], particles[4]);
   */
}
