int INITIAL = 50;

class ParticleSystem {

  float separateForce = 1.5;
  float cohesionForce = 1;

  ArrayList<Particle> particles = new ArrayList<Particle>();

  ParticleSystem() {
    for (int i = 0; i < INITIAL; i++) {
      particles.add(new Particle());
    }
  }

  void update() {
    for (Particle particle : particles) {
      particle.update();
      particle.bounce();
      particle.seek(new PVector(mouseX, mouseY));
    }
  }

  void show() {
    for (Particle particle : particles) {
      particle.show();
    }
  }

  void separate() {
    PVector separate        = new PVector();
    PVector sum             = new PVector();
    float desiredSeparation = 30;
    int count               = 0;

    for (int i = 0; i < particles.size()-1; i++) {
      for (int k = i+1; k < particles.size(); k++) {
        float d = PVector.dist(particles.get(i).position, particles.get(k).position);

        // Find out which particle is about to collide to and sum that up
        if (d < desiredSeparation) {
          PVector diff = PVector.sub(particles.get(i).position, particles.get(k).position);
          sum.add(Normalize(diff, d));
          count++;
        }
      }
      if (count > 0) {
        separate = average(sum, count, particles.get(i));
      }
      separate.mult(separateForce);
      particles.get(i).applyForce(separate);

      // Reset the value
      separate.mult(0);
      sum.mult(0);
      count = 0;
    }
  }

  // The cohesion function is similar to separation function but with few change
  void cohesion() {
    PVector cohesion        = new PVector();
    PVector sum             = new PVector();
    // This desiredCohesion number larger, the less dense the population, grouping become
    float desiredCohesion   = 500;
    int count               = 0;

    for (int i = 0; i < particles.size()-1; i++) {
      for (int k = i+1; k < particles.size(); k++) {
        float d = PVector.dist(particles.get(i).position, particles.get(k).position);

        // Find out which particle is about to collide to and sum that up
        if (d > desiredCohesion) {
          // Alternative the position of other.position and position to achieve cohesion and separation
          PVector diff = PVector.sub(particles.get(k).position, particles.get(i).position);
          sum.add(Normalize(diff, d));
          count++;
        }
      }
      if (count > 0) {
        cohesion = average(sum, count, particles.get(i));
      }
      cohesion.mult(cohesionForce);
      particles.get(i).applyForce(cohesion);

      // Reset the value
      cohesion.mult(0);
      sum.mult(0);
      count = 0;
    }
  }

  PVector Normalize(PVector diff, float distance) {
    diff.normalize();
    diff.div(distance);
    return diff;
  }

  // Calculate the average steering
  PVector average(PVector sum, int count, Particle particle) {
    sum.div(count);
    sum.normalize();
    sum.mult(particle.maxSpeed);
    PVector average = PVector.sub(sum, particle.velocity);
    average.limit(particle.maxForce);
    return average;
  }

  void addParticle(PVector mouse) {
    particles.add(new Particle(mouse));
  }
}
