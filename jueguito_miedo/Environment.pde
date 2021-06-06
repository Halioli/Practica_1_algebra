void drawEnvironment(){
  
  //  - (Ground)
  drawGround(30, 30, 0, 400, -600);
  drawGround(30, 30, 0, 400, -300);
  
// - Walls
  for (int i = 0; i < 1; i++) {
    wallsHorizontal[i].drawWallHorizontal(50, 450, 400, i);
  }

  for (int i = currentWall; i < currentWall + 5; i++) {
    wallsVertical[i].drawWallVertical(0, 450, 650, i);
  }

  for (int i = currentWall; i < currentWall + 4; i++) {
    wallsVertical[i].drawWallVertical(300, 450, 650, i);
  }

  for (int i = currentWall; i < currentWall + 4; i++) {
    wallsHorizontal[i].drawWallHorizontal(-2400, 450, 530, i);
  }

  for (int i = currentWall; i < currentWall + 4; i++) {
    wallsHorizontal[i].drawWallHorizontal(520, 450, 2400, i);
  }

  for (int i = currentWall; i < currentWall + 5; i++) {
    wallsHorizontal[i].drawWallHorizontal(250, 450, 2800, i);
  }

  for (int i = currentWall; i < currentWall + 3; i++) {
    wallsHorizontal[i].drawWallVertical(2250, 450, 1150, i);
  }

  for (int i = currentWall; i < currentWall + 3; i++) {
    wallsHorizontal[i].drawWallVertical(2500, 450, 3030, i);
  }

  for (int i = currentWall; i < currentWall + 8; i++) {
    wallsHorizontal[i].drawWallVertical(2800, 450, 1550, i);
  }

  for (int i = currentWall; i < currentWall + 4; i++) {
    wallsHorizontal[i].drawWallHorizontal(770, 450, 4300, i);
  }

  for (int i = currentWall; i < currentWall + 3; i++) {
    wallsHorizontal[i].drawWallVertical(770, 450, 4300, i);
  }
  for (int i = currentWall; i < currentWall + 4; i++) {
    wallsHorizontal[i].drawWallHorizontal(770, 450, 5500, i);
  }

  for (int i = currentWall; i < currentWall + 3; i++) {
    wallsHorizontal[i].drawWallVertical(2500, 450, 4830, i);
  }

  for (int i = currentWall; i < currentWall + 3; i++) {
    wallsHorizontal[i].drawWallVertical(2850, 450, 5850, i);
  }

  for (int i = currentWall; i < currentWall + 1; i++) {
    wallsHorizontal[i].drawWallHorizontal(2600, 450, 6050, i);
  }

  for (int i = currentWall; i < currentWall + 5; i++) {
    wallsHorizontal[i].drawWallHorizontal(3050, 450, 6550, i);
  }

  for (int i = currentWall; i < currentWall + 4; i++) {
    wallsHorizontal[i].drawWallHorizontal(3550, 450, 4550, i);
  }

  for (int i = currentWall; i < currentWall + 1; i++) {
    wallsHorizontal[i].drawWallHorizontal(3050, 450, 4550, i);
  }

  for (int i = currentWall; i < currentWall + 3; i++) {
    wallsHorizontal[i].drawWallVertical(4300, 450, 5700, i);
  }

  for (int i = currentWall; i < currentWall + 1; i++) {
    wallsHorizontal[i].drawWallVertical(4300, 450, 4800, i);
  }

  for (int i = currentWall; i < currentWall + 4; i++) {
    wallsHorizontal[i].drawWallVertical(5300, 450, 4800, i);
  }

  for (int i = currentWall; i < currentWall + 7; i++) {
    wallsHorizontal[i].drawWallHorizontal(2450, 450, 900, i);
  }
  
  for (int i = currentWall; i < currentWall + 2; i++) {
    wallsHorizontal[i].drawWallVertical(4700, 450, 900, i);
  }
  
  for (int i = currentWall; i < currentWall + 5; i++) {
    wallsHorizontal[i].drawWallVertical(4700, 450, 2300, i);
  }
  
  for (int i = currentWall; i < currentWall + 2; i++) {
    wallsHorizontal[i].drawWallHorizontal(4950, 450, 2900, i);
  }
  
  for (int i = currentWall; i < currentWall + 5; i++) {
    wallsHorizontal[i].drawWallVertical(5700, 450, 1150, i);
  }  
}
