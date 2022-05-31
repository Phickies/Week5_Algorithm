class Vehicle {

  PVector position;
  PVector velocity;
  PVector acceleration;

  float   maxSpeed;
  float   maxForce;

  Vehicle() {
    this.position     = new PVector(width/2, height/2);
    this.velocity     = new PVector();
    this.acceleration = new PVector();
    this.maxSpeed     = 4;
    this.maxForce     = 0.1;
  }

  void follow(FlowField flow) {
    PVector desired = flow.lookup(position);
    desired.mult(maxSpeed);

    PVector steer   = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    acceleration.add(steer);
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);

    if (position.x - 5 > width) {
      position.x = -5;
    }
    if (position.x + 5 < 0) {
      position.x = width + 5;
    }
    if (position.y - 5 > height) {
      position.y = -5;
    }
    if (position.y + 5 < 0) {
      position.y = height + 5;
    }
  }

  void show() {
    float theta = velocity.heading() + PI/2;
    fill(255);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape();
    vertex(0, -10);
    vertex(-6, 10);
    vertex(6, 10);
    endShape(CLOSE);
    popMatrix();
  }
}
