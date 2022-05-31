class Dest {

  PVector position;

  Dest() {
    this.position = new PVector(random(width), random(height));
  }

  void show() {
    fill(255, 255, 0);
    circle(position.x, position.y, 4);
  }

  void relocate(PVector mouse) {
    position.set(mouse);
  }
}
