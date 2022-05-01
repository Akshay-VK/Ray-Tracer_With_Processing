class Ray{
  PVector o,d;
  Ray(PVector o , PVector d){
    this.o=o;
    this.d=d;
  }
  PVector at(float t){
    return PVector.add(PVector.mult(this.d,t),this.o);
  }
}
