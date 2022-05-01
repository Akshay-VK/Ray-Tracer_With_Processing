class Sphere implements Object{
  PVector o, col;
  float rad;
  Material mat;
  Sphere(PVector origin,float radius,Material mat){
    this.o=origin;
    this.rad=radius;
    this.col = new PVector(1f,0f,0f);
    this.mat = mat;
  }
  Record hit(Ray r, float tmin, float tmax, Record rec){
    PVector oc = PVector.sub(r.o,this.o);
    float a = r.d.magSq();
    float hb = PVector.dot(oc,r.d);
    float c = PVector.dot(oc,oc)-this.rad*this.rad;
    float disc = hb*hb-a*c;
    if(disc<0){
      return rec;
    }
    float rtdisc = sqrt(disc);
    float root = (-hb-rtdisc)/a;
    if (root < tmin || tmax < root){
      root = (-hb+rtdisc)/a;
      if(root < tmin || tmax < root){
        return rec;
      }
    }
    rec.t=root;
    rec.p=r.at(rec.t);
    PVector normal=PVector.div(PVector.sub(rec.p,this.o),this.rad);
    rec.set_face_norm(r,normal);
    rec.mat=this.mat;
    return rec;
  }
  PVector colour(){
    return this.col;
  }
}
