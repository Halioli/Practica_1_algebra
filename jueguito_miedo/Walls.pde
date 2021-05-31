static int numWalls = 100;

class Wall {
  PImage wallImage;
  PShape[] walls = new PShape[numWalls];
  int wallSize = 500;
  PVector[] wallCenter = new PVector[numWalls];

  PVector vectorCamera = new PVector();
  boolean collided;

  float[] minX = new float[numWalls];
  float[] maxX = new float[numWalls];
  float[] minZ = new float[numWalls];
  float[] maxZ = new float[numWalls];


  Wall() {
  }

  void setupWalls(int numW) {
    // Loads image from ./data
    wallImage = loadImage("wall.jpg");

    // Creates wall and set it's texture
    for (int i = 0; i < numW; i++) {
      walls[i] = createShape(BOX, 40, 300, wallSize);
      walls[i].setTexture(wallImage);
      wallCenter[i] = new PVector();
    }
  }

  void drawWalls(int numW, int lastW, int coordX, int coordY, int coordZ, int rotY) {
    for (int i = lastW; i < numW; i++) {
      pushMatrix();
      rotateY(radians(rotY));
      translate(coordX, coordY, coordZ + (wallSize * i));
      wallCenter[i] = new PVector(coordX, coordY, coordZ+ (wallSize * i));
      //box(41,301,wallSize + 1);
      shape(walls[i]);
      popMatrix();
      getMinMax(i, coordX, coordZ);
      wallCollision(i);
    }
  }

  void getMinMax(int wall, int coordX, int coordZ) {
    minX[wall] = (coordX * wall) - 20;
    maxX[wall] = (coordX * wall) + 20;
    minZ[wall] = coordZ - (wallSize * wall)/2;
    maxZ[wall] = coordZ + (wallSize * wall)/2;
  }

  void wallCollision(int wall) {
    if ((minX[wall] <= camera.maxX && maxX[wall] >= camera.minX) &&
      (minZ[wall] <= camera.maxZ && maxZ[wall] >= camera.minZ)) {
      collided = true;
      println("Collided");
    } else {
      collided = false;
    }
  }
}
