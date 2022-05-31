int MAX_OBSTACLE = 2;

class ObstacleSystem {

  ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

  ObstacleSystem() {
    for (int i = 0; i < MAX_OBSTACLE; i++) {
      obstacles.add(new Obstacle());
    }
  }

  void show() {
    for (Obstacle obstacle : obstacles) {
      obstacle.show();
    }
  }

  void mouseDraggedEvent(PVector mouse) {
    for (Obstacle obstacle : obstacles) {
      if (obstacle.isHover(mouse)) {
        obstacle.position.set(mouse);
      }
    }
  }

  boolean isHover(PVector mouse) {
    boolean isHover = false;
    for (Obstacle obstacle : obstacles) {
      if (obstacle.isHover(mouse)) {
        isHover = true;
      }
    }
    return isHover;
  }
}
