Flock    birds;
Obstacle obstacle;

void setup() {
  size(800, 800);
  noStroke();
  ellipseMode(RADIUS);
  birds    = new Flock();
  obstacle = new Obstacle();
}

void draw() {
  background(0);
  birds.update();
  birds.show();
  //obstacle.show();
}

void mousePressed(){
  birds.addBird(new PVector(mouseX, mouseY));
}
