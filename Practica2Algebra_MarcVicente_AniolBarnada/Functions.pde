void PrintSprings() {

  PVector sSpring = new PVector(0.0, 0.0, 0.0);

  for (int i = 0; i < numSpring; i++) {
    for (int j = 0; j < numSpring; j++) {
      // Back
      if (i != 0) {
        sSpring = springs[i][j].getStrenght(particles[i][j], particles[i - 1][j]);
        particles[i][j].forceAcumulator.add(sSpring);
        particles[i - 1][j].forceAcumulator.sub(sSpring);
        // Draw
        springs[i][j].drawn(particles[i][j], particles[i - 1][j]);
      }

      // Top      
      if (j != 0) {
        sSpring = springs[i][j].getStrenght(particles[i][j], particles[i][j - 1]);
        particles[i][j].forceAcumulator.add(sSpring);
        particles[i][j - 1].forceAcumulator.sub(sSpring);
        // Draw
        springs[i][j].drawn(particles[i][j], particles[i][j - 1]);
      }

      // Top left
      //if (i != 0 && j != 0) {
      //  sSpring = springs[i][j].getStrenght(particles[i][j], particles[i - 1][j - 1]);
      //  particles[i][j].forceAcumulator.add(sSpring);
      //  particles[i - 1][j - 1].forceAcumulator.sub(sSpring);
      // Draw
      //  springs[i][j].drawn(particles[i][j], particles[i - 1][j - 1]);
      //}

      //// Top right
      //if (i != numParticle - 1 && j != 0) {
      //  sSpring = springs[i][j].getStrenght(particles[i][j], particles[i + 1][j - 1]);
      //  particles[i][j].forceAcumulator.add(sSpring);
      //  particles[i + 1][j - 1].forceAcumulator.sub(sSpring);
      // Draw
      //  springs[i][j].drawn(particles[i][j], particles[i + 1][j - 1]);
      //}
    }
  }
}
