int INITIAL = 50;

class Flock {

  float separateForce  = 1.75;
  float alignForce     = 0.5;
  float cohesionForce  = 0.5;

  ArrayList<Boid> birds = new ArrayList<Boid>();

  Flock() {
    for (int i = 0; i < INITIAL; i++) {
      birds.add(new Boid());
    }
  }

  void update(ObstacleSystem obstacles, Hunter hunter) {
    for (Boid bird : birds) {
      bird.update();
      bird.avoid(obstacles);
      bird.avoid(hunter);
    }
  }

  void separate() {
    PVector separate        = new PVector();
    PVector sum             = new PVector();
    float desiredSeparation = 30;
    int count               = 0;

    for (int i = 0; i < birds.size(); i++) {
      for (int k = 0; k < birds.size(); k++) {
        float d = PVector.dist(birds.get(i).position, birds.get(k).position);

        // Find out how many bird are about to collide and sum that up
        if ((d > 0) && (d < desiredSeparation)) {
          PVector diff = PVector.sub(birds.get(i).position, birds.get(k).position);
          diff.normalize();
          diff.div(d);
          sum.add(diff);
          count++;
        }
      }
      if (count > 0) {
        separate = average(sum, count, birds.get(i));
      }
      separate.mult(separateForce);
      birds.get(i).applyForce(separate);

      // Reset the value
      separate.mult(0);
      sum.mult(0);
      count = 0;
    }
  }

  void align() {
    PVector align           = new PVector();
    PVector sum             = new PVector();
    float neighborDist      = 150;
    int count               = 0;

    for (int i = 0; i < birds.size(); i++) {
      for (int k = 0; k < birds.size(); k++) {
        float d = PVector.dist(birds.get(i).position, birds.get(k).position);

        // Find out how many bird are about near by the neighbor zone
        if ((d > 0) && (d < neighborDist)) {
          sum.add(birds.get(k).velocity);
          count++;
        }
      }
      if (count > 0) {
        align = average(sum, count, birds.get(i));
      }
      align.mult(alignForce);
      birds.get(i).applyForce(align);

      // Reset the value
      align.mult(0);
      sum.mult(0);
      count = 0;
    }
  }

  void cohesion() {
    PVector cohesion        = new PVector();
    PVector sum             = new PVector();
    float neighborDist      = 150;
    int count               = 0;

    for (int i = 0; i < birds.size(); i++) {
      for (int k = 0; k < birds.size(); k++) {
        float d = PVector.dist(birds.get(i).position, birds.get(k).position);

        // Find out how many bird are about near by the neighbor zone
        if ((d > 0) && (d < neighborDist)) {
          sum.add(birds.get(k).position);
          count++;
        }
      }
      if (count > 0) {
        sum.div(count);
        cohesion = birds.get(i).seek(sum);
      }
      cohesion.mult(cohesionForce);
      birds.get(i).applyForce(cohesion);

      // Reset the value
      cohesion.mult(0);
      sum.mult(0);
      count = 0;
    }
  }

  void show() {
    for (Boid bird : birds) {
      bird.show();
    }
  }

  // Calculate the average steering
  PVector average(PVector sum, int count, Boid bird) {
    sum.div(count);
    sum.normalize();
    sum.mult(bird.maxSpeed);
    PVector average = PVector.sub(sum, bird.velocity);
    average.limit(bird.maxForce);
    return average;
  }

  // Add new bird base on your mouse
  void addBird(PVector mouse) {
    birds.add(new Boid(mouse));
  }
}
