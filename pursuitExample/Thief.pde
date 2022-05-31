class Thief { //<>//

  PVector position;
  PVector velocity;
  PVector acceleration;

  float   size;
  float   maxSpeed;
  float   maxForce;

  Thief() {
    this.position     = new PVector(random(width), random(height));
    this.velocity     = new PVector(random(-2, 2), random(-2, 2));
    this.acceleration = new PVector();
    this.size         = random(4, 10);
    this.maxSpeed     = map(size, 4, 10, 1, 4);
    this.maxForce     = 0.1;
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);

    // Stay within wall
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

  void avoid(Police police) {

    // Run faster if near the police
    if (PVector.dist(police.position, position) < 30) {
      maxSpeed++;
      maxForce++;
    } else {
      maxSpeed = map(size, 4, 10, 1, 4);
      maxForce = 0.1;
    }

    // Calculate the avoid vector
    PVector avoid = PVector.sub(police.position, position);
    avoid.mult(-1);
    avoid.normalize();
    avoid.mult(maxSpeed);

    // Calculate the steering vector
    if (avoid.mag() <= 10) {
      PVector steer   = PVector.sub(avoid, velocity);
      steer.limit(maxForce);
      acceleration.add(steer);
    }
  }

  void show() {
    fill(255, 0, 0);
    circle(position.x, position.y, size);
  }

  PVector inWallSteering(PVector desired) {
    PVector steer   = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    return steer;
  }
}
