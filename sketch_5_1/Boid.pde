class Boid {

  PVector position;
  PVector velocity;
  PVector acceleration;

  float   size;

  Boid() {
    this.position     = new PVector(random(width), random(height));
    this.velocity     = new PVector(random(-1, 1), random(-1, 1));
    this.acceleration = new PVector();
    this.size         = 10;
  }

  Boid(PVector position) {
    this.position     = new PVector(position.x, position.y);
    this.velocity     = new PVector(random(-1, 1), random(-1, 1));
    this.acceleration = new PVector();
    this.size         = 10;
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    
    // Cohesion
    

    // Reappear when out of scene (exercise want the bird to be bounce when hitting the wall)
    if (position.x - size > width) {
      position.x = -size;
    } else if (position.x + size < 0) {
      position.x = width + size;
    }
    if (position.y - size > height) {
      position.y = -size;
    } else if (position.y + size < 0) {
      position.y = height + size;
    }
  }

  void show() {
    fill(255);
    circle(position.x, position.y, size);
  }
}
