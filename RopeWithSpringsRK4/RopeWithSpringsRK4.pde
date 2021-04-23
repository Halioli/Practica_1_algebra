// ROPE WITH 5 PARTICLES

// VARIABLES
int numParticle = 5;
int numSpring = 4;
Particle[] particleArray = new Particle[numParticle];
Spring[] springArray = new Spring[numSpring];

// CLASS
class Spring {
  // Atributes
  float constant, equilibriumDistanceX, equilibriumDistanceY;

  // Constructor
  Spring (float c, float dX, float dY) {
    constant = c;
    equilibriumDistanceX = dX;
    equilibriumDistanceY = dY;
  }

  PVector getStrenght (Particle p0, Particle p1) {
    PVector f = new PVector(0.0, 0.0);

    // Hooke
    f.x = -constant * (equilibriumDistanceX - (p1.pos.x - p0.pos.x));
    f.y = -constant * (equilibriumDistanceY - (p1.pos.y - p0.pos.y));

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
    pos = new PVector(0.0, 0.0);
    pos = p;
    vel = new PVector(0.0, 0.0);
    vel = v;
    forceAcumulator = new PVector(0.0, 0.0);
    mass = 1.0;
    size = 5.0;
    frictionConstant = 0.01;
    isStatic = sta;
  }

  //Methods
  void move() {
    PVector accel = new PVector(0.0, 0.0, 0.0);
    float tInc = 0.04;
    float time = millis();

    if (!isStatic) {
      // Gravity
      forceAcumulator.x += 0.0;
      forceAcumulator.y += 9.8;

      // Friction
      forceAcumulator.x -= frictionConstant * vel.x;
      forceAcumulator.y -= frictionConstant * vel.y;

      // Euler's solver
      /*accel.x = forceAcumulator.x / mass;
      accel.y = forceAcumulator.y / mass;

      vel.x += accel.x * tInc;
      vel.y += accel.y * tInc;

      pos.x += vel.x * tInc;
      pos.y += vel.y * tInc;*/

      // Runge Kutta 4 solver

      // input
      U1 = sin(pow(time, 0.2));
       
       // placeholders
       float time2 = time + 0.5 * tInc;
       float time3 = time + tInc;
       
       // forward iterations
       K1 = timeInc * func1(pos.y);
       L1 = timeInc * func2(time, pos.y, pos.x, U1);
       
       K2 = timeInc * func1(pos.y + 0.5 * L1);
       L2 = timeInc * func2(time2, pos.y + 0.5 * L1, pos.x + 0.5 * K1, U1);
       
       K3 = timeInc * func1(pos.y + 0.5 * L2);
       L3 = timeInc * func2(time2, pos.y + 0.5 * L2, pos.x + 0.5 * K2, U1);
       
       K3 = timeInc * func1(pos.y + L3);
       L3 = timeInc * func2(time3, pos.y + L3, pos.x + K3, U1);
       
       // update X-position
       pos.x = pos.x + a1 * (K1 + K4) + a2 * (K2 + K3);
       
       // update Y-position
       pos.y = pos.y + a1 * (L1 + L4) + a2 * (L2 + L3);

      // Reset
      forceAcumulator.x = 0.0;
      forceAcumulator.y = 0.0;
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
  size(800, 600);

  setupRK();

  // Class constructors

  // Particles
  particleArray[0] = new Particle (new PVector(width/2.0 - 200.0, height/2.0), 
    new PVector(0.0, 0.0), true);

  particleArray[1] = new Particle (new PVector(width/2.0 - 100.0, height/2.0), 
    new PVector(0.0, 0.0), false);

  particleArray[2] = new Particle (new PVector(width/2.0, height/2.0), 
    new PVector(0.0, 0.0), false);

  particleArray[3] = new Particle (new PVector(width/2.0 + 100.0, height/2.0), 
    new PVector(0.0, 0.0), false);

  particleArray[4] = new Particle (new PVector(width/2.0 + 200.0, height/2.0), 
    new PVector(0.0, 0.0), true);

  // Springs
  springArray[0] = new Spring(0.2, 50.0, 100.0);
  springArray[1] = new Spring(0.2, 50.0, 100.0);
  springArray[2] = new Spring(0.2, 50.0, 100.0);
  springArray[3] = new Spring(0.2, 50.0, 100.0);
}

// DRAW
void draw() {
  background(0);

  PVector sSpring = new PVector(0.0, 0.0);
  // Spring 1
  sSpring = springArray[0].getStrenght(particleArray[0], particleArray[1]);
  particleArray[0].forceAcumulator.x += sSpring.x;
  particleArray[0].forceAcumulator.y += sSpring.y;
  particleArray[1].forceAcumulator.x -= sSpring.x;
  particleArray[1].forceAcumulator.y -= sSpring.y;
  // Spring 2
  sSpring = springArray[1].getStrenght(particleArray[1], particleArray[2]);
  particleArray[1].forceAcumulator.x += sSpring.x;
  particleArray[1].forceAcumulator.y += sSpring.y;
  particleArray[2].forceAcumulator.x -= sSpring.x;
  particleArray[2].forceAcumulator.y -= sSpring.y;
  // Spring 3
  sSpring = springArray[2].getStrenght(particleArray[2], particleArray[3]);
  particleArray[2].forceAcumulator.x += sSpring.x;
  particleArray[2].forceAcumulator.y += sSpring.y;
  particleArray[3].forceAcumulator.x -= sSpring.x;
  particleArray[3].forceAcumulator.y -= sSpring.y;
  // Spring 4
  sSpring = springArray[3].getStrenght(particleArray[3], particleArray[4]);
  particleArray[3].forceAcumulator.x += sSpring.x;
  particleArray[3].forceAcumulator.y += sSpring.y;
  particleArray[4].forceAcumulator.x -= sSpring.x;
  particleArray[4].forceAcumulator.y -= sSpring.y;


  for (int i = 0; i < numParticle; i++) {
    particleArray[i].drawn();
    particleArray[i].move();
  }

  springArray[0].drawn(particleArray[0], particleArray[1]);
  springArray[1].drawn(particleArray[1], particleArray[2]);
  springArray[2].drawn(particleArray[2], particleArray[3]);
  springArray[3].drawn(particleArray[3], particleArray[4]);
}
