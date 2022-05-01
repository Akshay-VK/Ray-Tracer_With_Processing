class Lambertian implements Material{
  PVector albedo;
  Util u;
  Lambertian(PVector col){
    this.albedo=col;
    u = new Util();
  }
  Attenuation_Scattered scatter(Ray r_in, Record rec,Attenuation_Scattered att_scat){
    PVector scat_dir = PVector.add(rec.normal,u.rand_in_unit_sphere().normalize());
    if(u.near_zero(scat_dir))scat_dir=rec.normal;
    att_scat.scattered = new Ray(rec.p,scat_dir);
    att_scat.attenuation=this.albedo;
    att_scat.bool=true;
    return att_scat;
  } 
}
