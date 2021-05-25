static int numWalls = 100;

PImage wallImage;
PShape[] walls = new PShape[numWalls];
int wallSize = 500;


void setupWalls(int numW) {
  // Loads image from ./data
  wallImage = loadImage("wall.jpg");

  // Creates wall and set it's texture
  for (int i = 0; i < numW; i++) {
    walls[i] = createShape(BOX, 40, 300, wallSize);
    walls[i].setTexture(wallImage);
  }
}

void drawWalls(int numW, int lastW, int coordX, int coordY, int coordZ, int rotY) {
  for (int i = lastW; i < numW; i++) {
    pushMatrix();
    rotateY(radians(rotY));
    translate(coordX, coordY, coordZ + (wallSize * i));
    shape(walls[i]);
    popMatrix();
  }
  
  
}
