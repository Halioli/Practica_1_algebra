void PrintSprings() {
  strokeWeight(2);
  stroke(255, 255, 0);
  
  for (int i = 0; i < numParticle; i++) {
    for (int j = 0; j < numParticle; j++) {
      PVector sSpring = new PVector(0.0, 0.0, 0.0);

      // Horizontal Springs  ─
      if (j < numParticle - 1) {
        // Aplica forces Spring

        // sSpring = -springK * (springEquilH - (particles[i][j+1].pos - particles[i][j].pos));
        // sSpring.set(particles[i][j +1].pos.sub(particles[i][j].pos).sub(springEquilH).mult(-springK));
        // sSpring = springs[i][j].getStrenght(particles[i][j], particles[i + 1][j]);

        //Particle p0 = particles[i][j];
        //Particle p1 = particles[i][j + 1];

        //PVector dist = springEquilH;
        //sSpring = p1.pos.sub(p0.pos);
        //sSpring = dist.sub(sSpring);
        //sSpring.mult(-springK);

        //particles[i][j].forceAcumulator.add(sSpring);
        //particles[i][j + 1].forceAcumulator.sub(sSpring);

        line(particles[i][j].pos.x, particles[i][j].pos.y, particles[i][j + 1].pos.x, particles[i][j + 1].pos.y);
      }

      // Vertical Springs |
      if (i < numParticle - 1) {
        // Aplica forces Spring
        Particle p0 = particles[i][j];
        Particle p1 = particles[i + 1][j];

        PVector dist = springEquilV;
        sSpring = new PVector(0.0, p1.pos.y - p0.pos.y, 0.0);
        //sSpring = p1.pos.sub(p0.pos);
        //sSpring = dist.sub(sSpring);
        sSpring = new PVector(0.0, springEquilV.y - sSpring.y, 0.0);
        sSpring.mult(-springK);

        particles[i][j].forceAcumulator.add(sSpring);
        particles[i + 1][j].forceAcumulator.sub(sSpring);

        line(particles[i][j].pos.x, particles[i][j].pos.y, particles[i + 1][j].pos.x, particles[i + 1][j].pos.y);
      }

      // Diagonal Right Springs /
      //if (i > 0 && j < numParticle -1) {
      //  Particle p0 = particles[i][j];
      //  Particle p1 = particles[i - 1][j + 1];

      //  PVector dist = springEquilD;
      //  sSpring = p1.pos.sub(p0.pos);
      //  sSpring = dist.sub(sSpring);
      //  sSpring.mult(-springK);

      //  particles[i][j].forceAcumulator.add(sSpring);
      //  particles[i - 1][j + 1].forceAcumulator.sub(sSpring);

      //  line(particles[i][j].pos.x, particles[i][j].pos.y, particles[i - 1][j + 1].pos.x, particles[i - 1][j + 1].pos.y);
      //}

      // Diagonal Legt Springs \
      //if (i > 0 && j > 0) {
      //  Particle p0 = particles[i][j];
      //  Particle p1 = particles[i - 1][j - 1];

      //  PVector dist = springEquilD;
      //  sSpring = p1.pos.sub(p0.pos);
      //  sSpring = dist.sub(sSpring);
      //  sSpring.mult(-springK);

      //  particles[i][j].forceAcumulator.add(sSpring);
      //  particles[i - 1][j - 1].forceAcumulator.sub(sSpring);

      //  line(particles[i][j].pos.x, particles[i][j].pos.y, particles[i - 1][j - 1].pos.x, particles[i - 1][j - 1].pos.y);
      //}
    }
  }
}
