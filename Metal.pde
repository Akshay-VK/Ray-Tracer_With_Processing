class Metal implements Material{
  PVector albedo;
  float fuzz;
  Util u;
  Metal(PVector col, float fuzz){
    this.albedo=col;
    this.fuzz=min(fuzz,1);
    u = new Util();
  }
  Attenuation_Scattered scatter(Ray r_in, Record rec,Attenuation_Scattered att_scat){
    PVector refl = u.reflect(r_in.d.normalize(),rec.normal);
    att_scat.scattered = new Ray(rec.p,PVector.add(refl,this.u.rand_in_unit_sphere().mult(this.fuzz)));
    att_scat.attenuation = this.albedo;
    att_scat.bool=PVector.dot(att_scat.scattered.d,rec.normal)>0;
    return att_scat;
  }
}
