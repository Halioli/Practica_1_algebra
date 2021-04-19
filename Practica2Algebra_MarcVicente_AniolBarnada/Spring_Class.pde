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
