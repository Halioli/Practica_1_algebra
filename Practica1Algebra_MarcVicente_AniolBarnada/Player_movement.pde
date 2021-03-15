// Player mouse movement
void mouseDragged() {
  if (!pcStartDrawn && (state != 4 || state != 5)) {
    // 1- Evaluate a vector
    float vectorX, vectorY;
    vectorX = mouseX - player[0].pcPosition.x;
    vectorY = mouseY - player[0].pcPosition.y;

    // 2- Normalize the vector
    float modulo = sqrt(vectorX*vectorX + vectorY*vectorY);
    vectorX /= modulo; 
    vectorY /= modulo;

    // 3- Scale the vector
    vectorX *= player[0].pcSpeed; 
    vectorY *= player[0].pcSpeed;

    // 4- Move the enemy
    player[0].pcPosition.x += vectorX;
    player[0].pcPosition.y += vectorY;

    // Collide with edges
    CollideWithEdgesPlayer();

    // 5- Draw everything
    fill(251, 208, 255);
    ellipse(player[0].pcPosition.x, player[0].pcPosition.y, 15, 15);
  }
}

void CollideWithEdgesPlayer() {
  if ((player[0].pcPosition.x + player[0].pcRadius) >= width ) {
    player[0].pcPosition.x -= 2;
  } else if ( (player[0].pcPosition.x + player[0].pcRadius) <= 0) {
    player[0].pcPosition.x = 2;
  } else if ( (player[0].pcPosition.y + player[0].pcRadius) <= 0) {
    player[0].pcPosition.y = 2;
  } else if ((player[0].pcPosition.y + player[0].pcRadius) >= height) {
    player[0].pcPosition.y -= 2;
  }
}
