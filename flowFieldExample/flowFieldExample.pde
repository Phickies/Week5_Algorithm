// Example of flow field with perlin noise. //<>//

FlowField field;
Vehicle   car;

void setup() {
  size(500, 500);
  noStroke();
  field = new FlowField();
  car   = new Vehicle();
}

void draw() {
  background(0);
  car.follow(field);
  car.update();
  car.show();
}
