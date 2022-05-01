interface Object{
  PVector o = new PVector(0,0,0);
  PVector col = new PVector(0,0,0);
  Record hit(Ray r, float tmin, float tmax, Record rec);
  PVector colour();
}
