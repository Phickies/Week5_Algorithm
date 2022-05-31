// Further development where car can adjust the MAX_FORCE and MAX_SPEED so that
// it can break further, more realistic

Dest dest;
Car car;

void setup() {
  size(800, 800);
  ellipseMode(RADIUS);
  noStroke();
  dest = new Dest();
  car  = new Car(dest);
}

void draw() {
  background(0);
  car.travel(dest);
  car.update();
  dest.show();
  car.show();
}

void mousePressed() {
  dest.relocate(new PVector(mouseX, mouseY));
}
