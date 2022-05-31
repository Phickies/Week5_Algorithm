class Obstacle {

  PVector position;

  float   size;
  color   Color;

  Obstacle() {
    this.position = new PVector(random(width), random(height));
    this.size     = random(50, 100);
    this.Color    = color(0, 100, 200);
  }

  void show() {
    fill(Color);
    circle(position.x, position.y, size);
  }

  boolean isHover(PVector mouse) {
    return (Math.pow((mouse.x - position.x), 2) + Math.pow((mouse.y - position.y), 2) < size*size);
  }
}
