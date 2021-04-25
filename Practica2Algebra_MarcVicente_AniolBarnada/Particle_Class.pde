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
    frictionConstant = friction;
    isStatic = sta;
  }

  //Methods
  void move() {
    PVector accel = new PVector(0.0, 0.0, 0.0);
    float tInc = 0.04;

    if (!isStatic) {
      // Gravity
      forceAcumulator.add(0.0, gravity, 0.0);

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
