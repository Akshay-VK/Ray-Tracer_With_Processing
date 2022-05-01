interface Material{
  Attenuation_Scattered scatter(Ray r_in, Record rec,Attenuation_Scattered att_scat);
}
