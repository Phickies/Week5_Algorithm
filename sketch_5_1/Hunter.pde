class Hunter extends Boid {

  float   size     = 10;
  float   mass     = 2;
  float   maxSpeed = 3;
  float   maxForce = 0.05;

  Hunter() {
    super();
  }

  void update(ObstacleSystem obstacles, Flock birds) {
    update();
    avoid(obstacles);
    hunt(birds);
  }

  void show() {
    float theta = velocity.heading() + PI/2;
    fill(255, 0, 0);
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

  // Hunting birds
  void hunt(Flock list) {
    PVector cohesion        = new PVector();
    PVector sum             = new PVector();
    float neighborDist      = 200;
    int count               = 0;

    for (Boid bird : list.birds) {
      float d = PVector.dist(position, bird.position);

      // Find out how many bird near by the neighbor zone
      if (d < neighborDist) {
        sum.add(bird.position);
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      cohesion = seek(sum);
    }
    cohesion.mult(1.5);
    applyForce(cohesion);
  }

  PVector seek(PVector target) {
    // Calculate the desired vector
    PVector desired = PVector.sub(target, position);
    float d         = desired.mag();
    desired.normalize();

    // If close to target, slow down
    if (d < 200) {
      float b = map(d, 0, 100, 0, maxSpeed);
      desired.mult(b);
    } else {
      desired.mult(maxSpeed);
    }

    // Calculate the steering vector
    PVector steer   = PVector.sub(desired, velocity);
    steer.limit(maxForce);
    return steer;
  }
}
