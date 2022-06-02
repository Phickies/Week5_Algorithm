int INITIAL = 200;

class Flock {

  float separateForce  = 1.75;
  float alignForce     = 0.5;
  float cohesionForce  = 0.5;

  float desiredSeparation = 30;
  float neighborDist      = 150;

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

  void flock() {
    for (int i=0; i < birds.size(); i++) {
      birds.get(i).applyForce(separate(birds.get(i), birds));
      birds.get(i).applyForce(align(birds.get(i), birds));
      birds.get(i).applyForce(cohesion(birds.get(i), birds));
    }
  }

  void show() {
    for (Boid bird : birds) {
      bird.show();
    }
  }

  // Add new bird base on your mouse
  void addBird(PVector mouse) {
    birds.add(new Boid(mouse));
  }

  PVector separate(Boid this_boid, ArrayList<Boid> birds) {
    PVector separate        = new PVector();
    PVector sum             = new PVector();
    int count               = 0;

    for (Boid other : birds) {

      float d = PVector.dist(this_boid.position, other.position);

      // Find out how many bird are about to collide and sum that up
      if ((d > 0) && (d < desiredSeparation)) {
        PVector diff = PVector.sub(this_boid.position, other.position);
        diff.normalize();
        diff.div(d);
        sum.add(diff);
        count++;
      }
    }

    if (count > 0) {
      separate = average(sum, count, this_boid);
      separate.mult(separateForce);
    }

    return separate;
  }

  PVector align(Boid this_boid, ArrayList<Boid> birds) {
    PVector align           = new PVector();
    PVector sum             = new PVector();
    int count               = 0;

    for (Boid other : birds) {

      float d = PVector.dist(this_boid.position, other.position);

      // Find out how many bird are about near by the neighbor zone
      if ((d > 0) && (d < neighborDist)) {
        sum.add(other.velocity);
        count++;
      }
    }

    if (count > 0) {
      align = average(sum, count, this_boid);
      align.mult(alignForce);
    }

    return align;
  }

  PVector cohesion(Boid this_boid, ArrayList<Boid> birds) {
    PVector cohesion        = new PVector();
    PVector sum             = new PVector();
    int count               = 0;

    for (Boid other : birds) {

      float d = PVector.dist(this_boid.position, other.position);

      // Find out how many bird are about near by the neighbor zone
      if ((d > 0) && (d < neighborDist)) {
        sum.add(other.position);
        count++;
      }
    }

    if (count > 0) {
      sum.div(count);
      cohesion = this_boid.seek(sum);
      cohesion.mult(cohesionForce);
    }

    return cohesion;
  }

  // Calculate the average steering
  PVector average(PVector sum, int count, Boid boid) {
    sum.div(count);
    sum.normalize();
    sum.mult(boid.maxSpeed);
    PVector average = PVector.sub(sum, boid.velocity);
    average.limit(boid.maxForce);
    return average;
  }
}
