class Obstacle{
  
  PVector position;
  
  float   size;
  color   Color;
  
  Obstacle(){
    this.position = new PVector(random(width), random(height));
    this.size     = random(50, 100);
    this.Color    = color(random(255), random(255), random(255));
  }
  

  void show(){
    fill(Color);
    circle(position.x, position.y, size);
  }
}
