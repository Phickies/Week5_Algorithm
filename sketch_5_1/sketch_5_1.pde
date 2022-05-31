// Program for assignment 5.1, 5.2 and 5.3 for Algorithm course
// Written by Tran Quy An

ObstacleSystem obstacles;
Flock          birds;
Hunter         dog;

void setup() {
  size(1000, 1000);
  noStroke();
  ellipseMode(RADIUS);
  obstacles = new ObstacleSystem();
  birds     = new Flock();
  dog       = new Hunter();
}

void draw() {
  background(0);
  birds.update(obstacles, dog);
  dog.update();
  dog.avoid(obstacles);
  birds.separate();
  birds.align();
  birds.cohesion();
  dog.hunt(birds);
  birds.show();
  dog.show();
  obstacles.show();
}

void mousePressed() {
  if (!obstacles.isHover(new PVector(mouseX, mouseY))) {
    birds.addBird(new PVector(mouseX, mouseY));
  }
}

void mouseDragged() {
  if (obstacles.isHover(new PVector(mouseX, mouseY))) {
    obstacles.mouseDraggedEvent(new PVector(mouseX, mouseY));
  }
}
