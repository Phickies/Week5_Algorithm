class Particle {

  PVector position;
  PVector velocity;
  PVector acceleration;

  float   size     = 5;
  float   maxSpeed = 4;
  float   maxForce = 0.1;

  Particle() {
    this.position     = new PVector(random(width), random(height));
    this.velocity     = new PVector(random(-1, 1), random(-1, 1));
    this.acceleration = new PVector();
  }

  Particle(PVector position) {
    this.position     = new PVector(position.x, position.y);
    this.velocity     = new PVector(random(-1, 1), random(-1, 1));
    this.acceleration = new PVector();
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
  }

  void bounce() {
    if (position.x > width - 25) {
      acceleration.add(inWallSteering(new PVector(-maxSpeed, velocity.y)));
    }
    if (position.x < 25) {
      acceleration.add(inWallSteering(new PVector(maxSpeed, velocity.y)));
    }
    if (position.y > height - 25) {
      acceleration.add(inWallSteering(new PVector(velocity.x, -maxSpeed)));
    }
    if (position.y < 25) {
      acceleration.add(inWallSteering(new PVector(velocity.x, maxSpeed)));
    }
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, position);
    desired.normalize();
    desired.mult(maxSpeed);

    PVector steer   = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    acceleration.add(steer);
  }

  void show() {
    fill(255);
    circle(position.x, position.y, size);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  PVector inWallSteering(PVector desired) {
    PVector steer   = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    return steer;
  }
}
