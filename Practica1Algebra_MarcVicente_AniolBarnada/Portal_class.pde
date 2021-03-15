float startPortalX, startPortalY;
float secondPortalX, secondPortalY;  // height/2
float thirdPortalX, thirdPortalY;    // width/2
float fourthPortalX, fourthPortalY;  // width, height/2
int bossPortal;
Portal[] exitPortals = new Portal[3];

class Portal {
  PVector location;
  boolean topPortal;
  boolean bossPortal;

  //boolean collided;
  float xMin;
  float yMin;
  float xMax;
  float yMax;

  Portal (float coordX, float coordY, boolean isTop) {
    location = new PVector(coordX, coordY);
    topPortal = isTop;
    if (isTop) {
      xMin = location.x - topWidth/2; 
      yMin = location.y - topHeight/2;
      xMax = location.x + topWidth/2;
      yMax = location.y + topHeight/2;
    } else {
      xMin = location.x - rightWidth/2; 
      yMin = location.y - rightHeight/2;
      xMax = location.x + rightWidth/2;
      yMax = location.y + rightHeight/2;
    }
  }

  void display() {
    // Exit portals color and instance
    fill(231, 36, 250); // Purple
    if (topPortal) {
      rect(location.x, location.y, topWidth, topHeight);
    } else {
      rect(location.x, location.y, rightWidth, rightHeight);
    }
  }

  void update() {
    // Look collisions
    if ((player[0].pcPosition.x < xMin) || (player[0].pcPosition.y < yMin) 
      || (xMax < player[0].pcPosition.x) || (yMax < player[0].pcPosition.y)) {
      //println("NO");
    } else {
      println("Collided with portal");
      if (bossPortal)
      {
        state = 3;
      } else {
        player[0].pcPosition.x = startPortalX;
        player[0].pcPosition.y = startPortalY;
      }
    }
  }
}
