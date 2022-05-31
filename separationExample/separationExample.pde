ParticleSystem particles;

void setup() {
  size(800, 800);
  noStroke();
  ellipseMode(RADIUS);

  particles = new ParticleSystem();
}

void draw() {
  background(0);
  particles.update();
  particles.separate();
  particles.cohesion();
  particles.show();
}

void mouseDragged() {
  particles.addParticle(new PVector(mouseX, mouseY));
}
