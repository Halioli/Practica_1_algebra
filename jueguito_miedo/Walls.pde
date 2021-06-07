static int numWalls = 100; //<>//
PShape wallShapeVertical;
PShape wallShapeHorizontal;

class Wall {
  PImage wallImage;

  int wallSize = 500;

  boolean collided;

  float minX;
  float maxX; 
  float minZ;
  float maxZ;

  PVector vectorWall = new PVector();
  PVector wallPosition = new PVector();

  Wall() {
  }

  void setupWallsVertical() {
    // Loads image from ./data
    wallImage = loadImage("wall.jpg");

    // Creates wall and set it's texture
    wallShapeVertical = createShape(BOX, 40, 300, wallSize);
    wallShapeVertical.setTexture(wallImage);
  }

  void setupWallsHorizontal() {
    // Loads image from ./data
    wallImage = loadImage("wall.jpg");

    // Creates wall and set it's texture
    wallShapeHorizontal = createShape(BOX, wallSize, 300, 40);
    wallShapeHorizontal.setTexture(wallImage);
  }

  void drawWallVertical(int coordX, int coordY, int coordZ, int nW) {
    pushMatrix();
    translate(coordX, coordY, coordZ + (wallSize) * nW);
    wallPosition =new  PVector(coordX, coordY, coordZ);
    
    //box(41,301,wallSize + 1);
    shape(wallShapeVertical);
    popMatrix();
    getMinMaxVertical(coordX, coordZ+ (wallSize)* nW );
    wallCollision();
    applyCollisionVertical();
  }

  void drawWallHorizontal(int coordX, int coordY, int coordZ, int nW) {
    pushMatrix();
    translate(coordX + (wallSize) * nW, coordY, coordZ );
    wallPosition =new  PVector(coordX, coordY, coordZ);
    
    //box(41,301,wallSize + 1);
    shape(wallShapeHorizontal);
    popMatrix();
    getMinMaxHorizontal(coordX + (wallSize) * nW, coordZ);
    wallCollision();
    applyCollisionHorizontal();
  }

  void getMinMaxVertical(int coordX, int coordZ) {
    minX = coordX  - 50;
    maxX = coordX  + 50;
    minZ = coordZ - wallSize/2;
    maxZ = coordZ + wallSize/2;
  }

  void getMinMaxHorizontal(int coordX, int coordZ) {
    minZ = coordZ  - 50;
    maxZ = coordZ  + 50;
    minX = coordX - wallSize/2;
    maxX = coordX + wallSize/2;
  }

  void wallCollision() {
    if ((minX <= camera.maxX && maxX >= camera.minX) &&
      (minZ <= camera.maxZ && maxZ >= camera.minZ)) {
      collided = true;
      println("Collided");
    } else {
      collided = false;
    }
  }

  void applyCollisionVertical() {
    PVector newSpeedV = new PVector(0.0, 0.0, 0.0);
    if (collided) {
      if (minX <= camera.maxX - 60) {
        newSpeedV = new PVector(10.0, 0.0, 0.0);
        camera.cameraLocation.x += newSpeedV.x;
        
      } else if (maxX >= camera.minX + 60) {
        newSpeedV = new PVector(10.0, 0.0, 0.0);
        camera.cameraLocation.x -= newSpeedV.x;
      } 
    }
  }

  void applyCollisionHorizontal() {
    PVector newSpeedV = new PVector(0.0, 0.0, 0.0);
    if (collided) {
      if (maxZ >= camera.minZ + 60) {
        newSpeedV = new PVector(0.0, 0.0, 8.0);
        camera.cameraLocation.z -= newSpeedV.z;
        println("minZ collision");
      } 
      else if (minZ <= camera.maxZ-60) {
        newSpeedV = new PVector(0.0, 0.0, 8.0);
        camera.cameraLocation.z += newSpeedV.z;

        println("maxZ collision");
      }
    }
  }
}
