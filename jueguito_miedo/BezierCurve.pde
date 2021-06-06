class BezierCurve {
  // Atributos
  PVector[] controlPoints;
  PVector[] coefficients;
  color curveColor;

  // Constructor
  BezierCurve (PVector[] point, color cColor) {
    controlPoints = new PVector[4];
    coefficients = new PVector[4];

    for (int i = 0; i < 4; i++) {
      // Initialize
      controlPoints[i] = new PVector(0.0, 0.0, 0.0);
      coefficients[i] = new PVector(0.0, 0.0, 0.0);

      controlPoints[i] = point[i];
    }
    curveColor = cColor;
  }

  // Methods
  void calcular_coefficients() {
    // C0 = P0
    coefficients[0].x = controlPoints[0].x;
    coefficients[0].y = controlPoints[0].y;
    coefficients[0].z = controlPoints[0].z;

    // C1 = -3P0 + 3P1
    coefficients[1].x =
      -3.0 * controlPoints[0].x +
      3.0 * controlPoints[1].x;
    coefficients[1].y =
      -3.0 * controlPoints[0].y +
      3.0 * controlPoints[1].y;
    coefficients[1].z =
      -3.0 * controlPoints[0].z +
      3.0 * controlPoints[1].z;

    // C2 = 3P0 - 6P1 + 3P2
    coefficients[2].x =
      3.0 * controlPoints[0].x
      -6.0 * controlPoints[1].x +
      3.0 * controlPoints[2].x;
    coefficients[2].y =
      3.0 * controlPoints[0].y
      -6.0 * controlPoints[1].y +
      3.0 * controlPoints[2].y;
    coefficients[2].z =
      3.0 * controlPoints[0].z
      -6.0 * controlPoints[1].z +
      3.0 * controlPoints[2].z;

    // C3 = -P0 + 3P1 - 3P2 + P3
    coefficients[3].x =
      -controlPoints[0].x +
      3.0 * controlPoints[1].x
      -3.0 * controlPoints[2].x +
      controlPoints[3].x;
    coefficients[3].y =
      -controlPoints[0].y +
      3.0 * controlPoints[1].y
      -3.0 * controlPoints[2].y +
      controlPoints[3].y;
    coefficients[3].z =
      -controlPoints[0].z +
      3.0 * controlPoints[1].z
      -3.0 * controlPoints[2].z +
      controlPoints[3].z;
  }

  void pintar_curva() {
    float x, y, z;

    strokeWeight(5);
    stroke(curveColor);
    for (float u = 0.0; u < 1.0; u += 0.01) {
      // x(u) = C0x + C1x * u + C2x * u2 + C3x * u3
      x = coefficients[0].x + coefficients[1].x * u
        + coefficients[2].x * u * u
        + coefficients[3].x * u * u * u;

      // y(u) = C0y + C1y * u + C2y * u2 + C3y * u3
      y = coefficients[0].y + coefficients[1].y * u
        + coefficients[2].y * u * u
        + coefficients[3].y * u * u * u;

      // z(u) = C0z + C1z * u + C2z * u2 + C3z * u3
      z = coefficients[0].z + coefficients[1].z * u
        + coefficients[2].z * u * u
        + coefficients[3].z * u * u * u;

      // Draw point
      point(x, y, z);
    }
  }
}
