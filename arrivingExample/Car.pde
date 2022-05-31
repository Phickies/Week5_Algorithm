class Car {

  Dest    dest;

  PVector position;
  PVector velocity;
  PVector acceleration;

  float   MAX_SPEED = 4;
  float   MAX_FORCE = 0.09;

  Car(Dest dest) {
    this.dest         = dest;
    this.position     = new PVector(random(width), random(height));
    this.velocity     = new PVector();
    this.acceleration = new PVector();
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(MAX_SPEED);
    position.add(velocity);
    acceleration.mult(0);
  }

  void travel(Dest dest) {
    // Calculate the desired vector
    PVector desired = PVector.sub(dest.position, position);
    float d         = desired.mag();
    desired.normalize();
    if (d < 400) {
      float b = map(d, 0, 100, 0, MAX_SPEED);
      desired.mult(b);
    } else {
      desired.mult(MAX_SPEED);
    }

    // Calculate the steering vector
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(MAX_FORCE);
    acceleration.add(steer);
  }

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
}
