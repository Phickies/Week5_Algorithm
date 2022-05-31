class Wanderer {

  PVector position;
  PVector velocity;
  PVector acceleration;

  float   wanderTheta;
  float   MAX_SPEED = 2;
  float   MAX_FORCE = 0.1;

  Wanderer() {
    this.position     = new PVector(random(width), random(height));
    this.velocity     = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);
    this.wanderTheta  = 0;
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(MAX_SPEED);
    position.add(velocity);
    acceleration.mult(0);

    // Stay within wall
    if (position.x > width - 25) {
      acceleration.add(inWallSteering(new PVector(-MAX_SPEED, velocity.y)));
    }
    if (position.x < 25) {
      acceleration.add(inWallSteering(new PVector(MAX_SPEED, velocity.y)));
    }
    if (position.y > height - 25) {
      acceleration.add(inWallSteering(new PVector(velocity.x, -MAX_SPEED)));
    }
    if (position.y < 25) {
      acceleration.add(inWallSteering(new PVector(velocity.x, MAX_SPEED)));
    }
  }

  // This algorithm is from Daniel Shiffman
  void wander() {
    int r = 20;                                                                // Radius for our "wander circle"
    int d = 80;                                                                // Distance for our "wander circle"
    wanderTheta += random(-0.3, 0.3);

    // Caculate the new position to steer towards on the wander circle
    PVector circlePos = new PVector();
    circlePos = velocity.copy();                                               // Start with velocity
    circlePos.normalize();                                                     // Normalize to get heading
    circlePos.mult(d);                                                         // Multiply by distance
    circlePos.add(position);                                                   // Make it relative to boid's position

    float h = velocity.heading();                                              // Caculate the angle of rotation for the velocity (offset wandertheta)

    PVector circleOffSet = new PVector(r*cos(wanderTheta + h), r*sin(wanderTheta + h));
    PVector target       = PVector.add(circlePos, circleOffSet); //<>//
    seek(target); //<>//
  }

  void seek(PVector target) {
    // Calculate the desired vector
    PVector desired = PVector.sub(target, position);
    desired.normalize();
    desired.mult(MAX_SPEED);

    // Calculate the steering vector
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(MAX_FORCE);
    acceleration.add(steer);                                                   // Resey acceleration to 0 each cycle
  } //<>//

  void show() {
    float theta = velocity.heading() + PI/2;
    fill(255);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape();
    vertex(0, -15);
    vertex(-10, 15);
    vertex(10, 15);
    endShape(CLOSE);
    popMatrix();
  }

  PVector inWallSteering(PVector desired) {
    PVector steer   = PVector.sub(desired, velocity);
    steer.limit(MAX_FORCE);
    return steer;
  }
}
