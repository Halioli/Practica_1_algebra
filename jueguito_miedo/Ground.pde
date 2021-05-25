static int totalRows = 100;
static int totalCols = 100;
PShape[][] globes = new PShape[totalRows][totalCols];

PImage groundImage; 
int groundSize = 300;

void setupGround(int numR, int numC) {
  // Loads image from ./data
  groundImage = loadImage("dungeonFloor.jpg");

  // Creates ground and set it's texture
  for (int i = 0; i < numR; i++) {
    for (int j = 0; j < numC; j++) {
      globes[i][j] = createShape(RECT, groundSize * j, groundSize * i, groundSize, groundSize);
      globes[i][j].setTexture(groundImage);
    }
  }
}

void drawGround(int numR, int numC, int numLastI, int numLastJ, int coordX, int coordY, int coordZ) {
  pushMatrix();
  rotateX(radians(90));
  translate(coordX, coordY, coordZ);
  for (int i = numLastI; i < numR; i++) {
    for (int j = numLastJ; j < numC; j++) {
      shape(globes[i][j]);
    }
  }
  popMatrix();
}
