class Dielectric implements Material{
  float ir;
  Util u;
  Dielectric(float index_of_refr){
    this.ir=index_of_refr;
    u = new Util();
    
  }
  Attenuation_Scattered scatter(Ray r_in, Record rec,Attenuation_Scattered att_scat){
    att_scat.attenuation=new PVector(1,1,1);
    float refr_rat=rec.ff?1.0/this.ir:ir;
    PVector unit = r_in.d.normalize();
        
    float cost=min(PVector.dot(PVector.mult(unit,-1),rec.normal),  1.0);
    float sint=sqrt(1-cost*cost);
    
    boolean cant_refr=refr_rat*sint>1.0;
    PVector dir;
    
    if(cant_refr || this.reflectance(cost,refr_rat)>random(1.0)){
      dir=u.reflect(unit,rec.normal);
    }else{
      dir=u.refract(unit,rec.normal,refr_rat);
    }
    
    att_scat.scattered=new Ray(rec.p,dir);
    
    att_scat.bool=true;
    return att_scat;
  }
  private float reflectance(float cosine, float ref_idx){
    float r0=(1-ref_idx)/(1+ref_idx);
    r0 *= r0;
    return r0 + (1-r0)*pow((1 - cosine),5);
  }
}
