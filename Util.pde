class Util{
  Util(){}
  PVector rand_vector(float min, float max){
    return new PVector(random(min,max),random(min,max),random(min,max));
  }
  PVector rand_in_unit_sphere(){
    while(true){
      PVector p = this.rand_vector(-1f,1f);
      if(p.magSq()>=1)continue;
      return p;
    }
  }
  PVector rand_in_unit_disk(){
    while(true){
      PVector p = this.rand_vector(-1f,1f);
      p.z=0;
      if(p.magSq()>=1)continue;
      return p;
    }
  }
  boolean near_zero(PVector v){
    return v.mag() < 1e-8;
  }
  PVector reflect(PVector v, PVector n){
    return PVector.sub(v,PVector.mult(n,(2*PVector.dot(v,n))));
  }
  PVector refract(PVector uv, PVector n, float etai_over_etat){
    float cost=min(PVector.dot(PVector.mult(uv,-1),n),  1.0);
    PVector ro_perp=PVector.mult(PVector.add(uv,PVector.mult(n,cost)),etai_over_etat);
    PVector ro_par=PVector.mult(n,-sqrt(abs(-ro_perp.magSq()+1)));
    return PVector.add(ro_perp,ro_par);
  }
}
class Attenuation_Scattered{
  PVector attenuation;
  Ray scattered;
  boolean bool;
  Attenuation_Scattered(PVector attenuation, Ray scattered){
    this.attenuation=attenuation;
    this.scattered=scattered;
    this.bool=false;
  }
}
