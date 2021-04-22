// PRACTICA 2: ENUNCIAT 1  //<>//

// VARIABLES
int numParticle = 5;
int numSpring = 5;

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
    counterJ = 0;
  }

  // Springs
  for (int i = 0; i < numSpring; i++) {
    for (int j = 0; j < numSpring; j++) {

      springs[i][j] = new Spring (0.5, 30.0, 20.0, 30.0);
      counterJ += 30;
    }
    counterI += 30;
    counterJ = 0;
  }
}

// DRAW
void draw() {
  background(0);

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

void PrintSprings() {

  PVector sSpring = new PVector(0.0, 0.0, 0.0);

  // First line
  for (int i = 0; i < numSpring; i++) {
    for (int j = 0; j < numSpring; j++) {
      if (i != 0) {
        sSpring = springs[i][j].getStrenght(particles[i][j], particles[i - 1][j]);
        particles[i][j].forceAcumulator.add(sSpring);
        particles[i - 1][j].forceAcumulator.sub(sSpring);

        springs[i][j].drawn(particles[i][j], particles[i - 1][j]);
      }
    }
  }

  for (int i = 0; i < numSpring; i++) {
    for (int j = 1; j < numSpring; j++) {
      // Back
      if (i != 0) {
        sSpring = springs[i][j].getStrenght(particles[i][j], particles[i - 1][j]);
        particles[i][j].forceAcumulator.add(sSpring);
        particles[i - 1][j].forceAcumulator.sub(sSpring);
      }

      // Top      
      sSpring = springs[i][j].getStrenght(particles[i][j], particles[i][j - 1]);
      particles[i][j].forceAcumulator.add(sSpring);
      particles[i][j - 1].forceAcumulator.sub(sSpring);

      // Top left
      if (i != 0) {
        sSpring = springs[i][j].getStrenght(particles[i][j], particles[i - 1][j - 1]);
        particles[i][j].forceAcumulator.add(sSpring);
        particles[i - 1][j - 1].forceAcumulator.sub(sSpring);
      }

      // Top right
      if (i != numParticle - 1) {
        sSpring = springs[i][j].getStrenght(particles[i][j], particles[i + 1][j - 1]);
        particles[i][j].forceAcumulator.add(sSpring);
        particles[i + 1][j - 1].forceAcumulator.sub(sSpring);
      }

      // Draw
      if (i != 0)
        springs[i][j].drawn(particles[i][j], particles[i - 1][j]);

      springs[i][j].drawn(particles[i][j], particles[i][j - 1]);

      if (i != 0)
        springs[i][j].drawn(particles[i][j], particles[i - 1][j - 1]);

      if (i != numParticle - 1)
        springs[i][j].drawn(particles[i][j], particles[i + 1][j - 1]);
    }
  }
}
