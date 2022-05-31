// The wander algorithm is taken from Daniel Shiffman Nature of Code Example
// https://github.com/nature-of-code/noc-examples-processing/blob/master/chp06_agents/Exercise_6_04_Wander/Vehicle.pdehttps://github.com/nature-of-code/noc-examples-processing/blob/master/chp06_agents/Exercise_6_04_Wander/Vehicle.pde

Wanderer wanderer;

void setup() {
  size(800, 800);
  background(0);
  ellipseMode(RADIUS);
  noStroke();
  wanderer = new Wanderer();
}

void draw() {
  wanderer.wander();
  wanderer.update();
  wanderer.show();
}
