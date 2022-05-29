int INITIAL_BIRD = 100;

class Flock {

  ArrayList<Boid> bird;
  
  int             count;

  Flock() {
    bird = new ArrayList<Boid>();
    for (int i = 0; i < INITIAL_BIRD; i++){
      bird.add(new Boid());
    }
  }

  void update() {

    for (Boid bird : bird) {
      bird.update();
    }
  }

  void show() {
    for (Boid bird : bird) {
      bird.show();
    }
  }
  
  void addBird(PVector mouse){
    bird.add(new Boid(mouse));
  }
}
