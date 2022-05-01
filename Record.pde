class Record{
  float t;
  PVector p,normal;
  boolean ff;
  Material mat;
  Record(){this.t=-1;}
  void set_face_norm(Ray r, PVector out){
    this.ff=PVector.dot(r.d,out)<0;
    this.normal = this.ff?out:PVector.mult(out,-1);
  }
}
