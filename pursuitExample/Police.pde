class Police {

  Thief   thief;

  PVector position;
  PVector velocity;
  PVector acceleration;

  float   maxSpeed;
  float   maxForce;

  Police(Thief thief) {
    this.thief        = thief;
    this.position     = new PVector(random(width), random(height));
    this.velocity     = new PVector();
    this.acceleration = new PVector();
    this.maxSpeed     = 3;
    this.maxForce     = 0.1;
  }

  Police(Thief thief, PVector position, PVector velocity) {
    this.thief        = thief;
    this.position     = new PVector(position.x, position.y);
    this.velocity     = new PVector(velocity.x, velocity.y);
    this.acceleration = new PVector();
    this.maxSpeed     = 3;
    this.maxForce     = 0.01;
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    //acceleration.mult(0);
  }

  void chase() {
    // Calculate the desired vector
    PVector desired = PVector.sub(thief.position, position);
    desired.normalize();
    desired.mult(maxSpeed);

    // Calculate the steering vector
    PVector steer   = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    acceleration.add(steer);
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
