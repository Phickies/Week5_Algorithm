class Boid {

  PVector position;
  PVector velocity;
  PVector acceleration;

  float   size     = 5;
  float   mass     = 1;
  float   maxSpeed = 4;
  float   maxForce = 0.1;

  Boid() {
    this.position     = new PVector(random(width), random(height));
    this.velocity     = new PVector(random(-1, 1), random(-1, 1));
    this.acceleration = new PVector();
  }

  Boid(PVector position) {
    this.position     = new PVector(position.x, position.y);
    this.velocity     = new PVector(random(-1, 1), random(-1, 1));
    this.acceleration = new PVector();
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);

    // bounce within the wall
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

  void avoid(ObstacleSystem list) {
    for (Obstacle obstacle : list.obstacles) {
      float d = PVector.dist(position, obstacle.position);

      if (d < (obstacle.size + 100)) {
        // Calculate the avoid vector
        PVector avoid = PVector.sub(position, obstacle.position);
        avoid.normalize();
        avoid.mult(maxSpeed);

        // Calculate the steering vector
        if (avoid.mag() < 10) {
          PVector steer   = PVector.sub(avoid, velocity);
          steer.limit(maxForce);
          applyForce(steer);
        }
      }
    }
  }

  void avoid(Hunter hunter) {
    float d = PVector.dist(position, hunter.position);

    if (d < (hunter.size + 100)) {
      // Calculate the avoid vector
      PVector avoid = PVector.sub(position, hunter.position);
      avoid.normalize();
      avoid.mult(maxSpeed);

      // Calculate the steering vector
      if (avoid.mag() < 10) {
        PVector steer   = PVector.sub(avoid, velocity);
        steer.limit(maxForce);
        applyForce(steer);
      }
    }
  }

  void show() {
    float theta = velocity.heading() + PI/2;
    fill(255);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape();
    vertex(0, -size*2);
    vertex(-size, size*2);
    vertex(size, size*2);
    endShape(CLOSE);
    popMatrix();
  }

  void applyForce(PVector force) {
    acceleration.add(PVector.div(force, mass));
  }

  // Finding nearby birds
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);
    desired.normalize();
    desired.mult(maxSpeed);

    PVector steer   = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    return steer;
  }

  PVector inWallSteering(PVector desired) {
    PVector steer   = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    return steer;
  }
}
