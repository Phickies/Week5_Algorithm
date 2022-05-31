Thief thief; //<>//
ArrayList<Police> police;

void setup() {
  size(500, 500);
  ellipseMode(RADIUS);
  noStroke();
  thief    = new Thief();
  police   = new ArrayList<Police>();
}

void draw() { //<>//
  background(0);
  for (Police police : police) {
    police.update();
    police.chase();
    thief.avoid(police);
    police.show();
  }
  thief.update();
  thief.show();
}

void mousePressed() {
  police.add(new Police(thief, new PVector(mouseX, mouseY), new PVector(random(-2, 2), random(-2, 2))));
}
