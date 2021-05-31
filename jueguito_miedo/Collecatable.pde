class Collectable {
  int numCollectables = 7;

  PImage collectableImage[] = new PImage[7];
  PShape collectableShape[] = new PShape[7];

  PVector collectablePosition[] = new PVector[7];

  float rotationSpeed;
  float yAngle;

  Collectable(int collectable) {
    collectablePosition[collectable] = new PVector(0.0, 450.0, 0.0);
    rotationSpeed = 3.0;
  }

  void setupCollectables(int i) { 
    collectableImage[i] = loadImage("meme"+(i+1)+".png");
    collectableShape[i] = createShape(SPHERE, 30);
    collectableShape[i].setTexture(collectableImage[i]);
  }

  void updateColl() {
    yAngle += rotationSpeed;
  }

  void drawCollectables(int coll) {
    pushMatrix();
    translate(0.0 + (100 * coll), 450, 0.0);
    rotateY(radians(yAngle));
    shape(collectableShape[coll]);
    popMatrix();
  }
}
