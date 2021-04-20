// PRACTICA 2: ENUNCIAT 1 

// VARIABLES
int numParticle = 10;
int numSpring = 10;
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
  for (int i = 0; i < numSpring; i++) {
    for (int j = 1; j < numSpring; j++) {
      // Back
      if (i != 0) {
        sSpring = springs[i][j].getStrenght(particles[i][j], particles[i - 1][j]);
        particles[i][j].forceAcumulator.x += sSpring.x;
        particles[i][j].forceAcumulator.y += sSpring.y;
        particles[i][j].forceAcumulator.z += sSpring.z;
        particles[i - 1][j].forceAcumulator.x -= sSpring.x;
        particles[i - 1][j].forceAcumulator.y -= sSpring.y;
        particles[i - 1][j].forceAcumulator.z += sSpring.z;
      }

      // Top      
      sSpring = springs[i][j].getStrenght(particles[i][j], particles[i][j - 1]);
      particles[i][j].forceAcumulator.x += sSpring.x;
      particles[i][j].forceAcumulator.y += sSpring.y;
      particles[i][j].forceAcumulator.z += sSpring.z;
      particles[i][j - 1].forceAcumulator.x -= sSpring.x;
      particles[i][j - 1].forceAcumulator.y -= sSpring.y;
      particles[i][j - 1].forceAcumulator.z += sSpring.z;

      // Top left
      if (i != 0) {
        sSpring = springs[i][j].getStrenght(particles[i][j], particles[i - 1][j - 1]);
        particles[i][j].forceAcumulator.x += sSpring.x;
        particles[i][j].forceAcumulator.y += sSpring.y;
        particles[i][j].forceAcumulator.z += sSpring.z;
        particles[i - 1][j - 1].forceAcumulator.x -= sSpring.x;
        particles[i - 1][j - 1].forceAcumulator.y -= sSpring.y;
        particles[i - 1][j - 1].forceAcumulator.z += sSpring.z;
      }

      // Top right
      if (i != 9) {
        sSpring = springs[i][j].getStrenght(particles[i][j], particles[i + 1][j - 1]);
        particles[i][j].forceAcumulator.x += sSpring.x;
        particles[i][j].forceAcumulator.y += sSpring.y;
        particles[i][j].forceAcumulator.z += sSpring.z;
        particles[i + 1][j - 1].forceAcumulator.x -= sSpring.x;
        particles[i + 1][j - 1].forceAcumulator.y -= sSpring.y;
        particles[i + 1][j - 1].forceAcumulator.z += sSpring.z;
      }

      // Draw
      if (i != 0)
        springs[i][j].drawn(particles[i][j], particles[i - 1][j]);

      springs[i][j].drawn(particles[i][j], particles[i][j - 1]);

      if (i != 0)
        springs[i][j].drawn(particles[i][j], particles[i - 1][j - 1]);

      if (i != 9)
        springs[i][j].drawn(particles[i][j], particles[i + 1][j - 1]);
    }
  }
}
