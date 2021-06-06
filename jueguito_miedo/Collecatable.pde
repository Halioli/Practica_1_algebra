class Collectable {
  int numCollectables = 5;

  PImage collectableImage[] = new PImage[5];
  PShape collectableShape[] = new PShape[5];

  PVector collectablePosition = new PVector(0.0, 0.0, 0.0);

  float rotationSpeed;
  float yAngle;

  // Effect
  int numPoints = 4;
  PVector[] controlPoints;
  PVector[] coefficient;
  color effectColor;
  PVector points[] = new PVector[numPoints];

  Collectable (float x, float z) {
    collectablePosition = new PVector(x, 450.0, z);
    rotationSpeed = 1.0;
  }

  void setupCollectables (int i) { 
    collectableImage[i] = loadImage("meme" + (i + 1) + ".png");
    collectableShape[i] = createShape(SPHERE, 30);
    collectableShape[i].setTexture(collectableImage[i]);
  }

  void updateCollect() {
    yAngle += rotationSpeed;
  }

  void drawCollectables (int coll) {
    pushMatrix();
    translate(collectablePosition.x, collectablePosition.y, collectablePosition.z);
    rotateY(radians(yAngle));
    shape(collectableShape[coll]);
    popMatrix();
  }

  void setupEffect (color col) {
    points[0] = new PVector(collectablePosition.x + 70 , collectablePosition.y + 50, collectablePosition.z);
    points[1] = new PVector(collectablePosition.x - 70, collectablePosition.y + 50, collectablePosition.z);
    points[2] = new PVector(collectablePosition.x, collectablePosition.y + 50, collectablePosition.z + 70);
    points[3] = new PVector(collectablePosition.x, collectablePosition.y + 50, collectablePosition.z - 70);

    controlPoints = new PVector[numPoints];
    coefficient = new PVector[numPoints];

    for (int i = 0; i < numPoints; i++) {

      // Initialize
      controlPoints[i] = new PVector(0.0, 0.0);
      coefficient[i] = new PVector(0.0, 0.0);

      controlPoints[i] = points[i];
    }
    effectColor = col;
  }

  void calculateCoefficient() {
    // C0 = P0
    coefficient[0].x = controlPoints[0].x;
    coefficient[0].y = controlPoints[0].y;
    coefficient[0].z = controlPoints[0].z;


    // C1 = -5.5P0 + 9P1 - 4.5P2 + P3
    coefficient[1].x =
      -5.5 * controlPoints[0].x +
      9 * controlPoints[1].x +
      -4.5 * controlPoints[2].x +
      controlPoints[3].x;
    coefficient[1].y =
      -5.5 * controlPoints[0].y +
      9 * controlPoints[1].y +
      -4.5 * controlPoints[2].y +
      controlPoints[3].y;
    coefficient[1].z =
      -5.5 * controlPoints[0].z +
      9 * controlPoints[1].z +
      -4.5 * controlPoints[2].z +
      controlPoints[3].z;


    // C2 = 9P0 - 22.5P1 + 18P2 - 4.5P3
    coefficient[2].x =
      9.0 * controlPoints[0].x
      -22.5 * controlPoints[1].x
      +18.0 * controlPoints[2].x
      -4.5 * controlPoints[3].x;
    coefficient[2].y =
      9.0 * controlPoints[0].y
      -22.5 * controlPoints[1].y
      +18.0 * controlPoints[2].y
      -4.5 * controlPoints[3].y;
    coefficient[2].z =
      9.0 * controlPoints[0].z
      -22.5 * controlPoints[1].z
      +18.0 * controlPoints[2].z
      -4.5 * controlPoints[3].z;

    // C3 = -4.5P0 + 13.5P1 - 13.5P2 + 4.5P3
    coefficient[3].x =
      -4.5 * controlPoints[0].x
      +13.5 * controlPoints[1].x
      -13.5 * controlPoints[2].x
      +4.5 * controlPoints[3].x;
    coefficient[3].y =
      -4.5 * controlPoints[0].y
      +13.5 * controlPoints[1].y
      -13.5 * controlPoints[2].y
      +4.5 * controlPoints[3].y;
    coefficient[3].z =
      -4.5 * controlPoints[0].z
      +13.5 * controlPoints[1].z
      -13.5 * controlPoints[2].z
      +4.5 * controlPoints[3].z;
  }

  void drawEffect() {
    float x, y, z;

    strokeWeight(5);
    stroke(effectColor);

    for (float u = 0.0; u < 1.0; u += 0.01) {
      // p(u) = C0 + C1 * u + C2 * u2 + C3 * u3
      // x(u) = C0x + C1x * u + C2x * u2 + C3x * u3
      x = coefficient[0].x + coefficient[1].x * u
        + coefficient[2].x * u * u
        + coefficient[3].x * u * u * u;

      // y(u) = C0y + C1y * u + C2y * u2 + C3y * u3
      y = coefficient[0].y + coefficient[1].y * u
        + coefficient[2].y * u * u
        + coefficient[3].y * u * u * u;

      z = coefficient[0].z + coefficient[1].z * u
        + coefficient[2].z * u * u
        + coefficient[3].z * u * u * u;

      // Pintamos el punto
      point(x, y, z);
    }
  }
}
