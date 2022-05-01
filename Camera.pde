class Camera{
  PVector o, hor, vert, llc, w, u, v;
  float wdth,h,vw,vh,aspect, foc_dist, aperture, lens_rad;
  int samples, total_pixels;
  Util util;
  Camera(float _w, float vfov,  float aspect_ratio, float foc_dist, float aperture, PVector o, PVector dir, PVector up, int samples){
    this.wdth=_w;
    this.h=(int)(wdth/aspect_ratio);
    
    float theta = radians(vfov),h=tan(theta/2.0);
    this.vh=h*2.0;
    this.vw=aspect_ratio*this.vh;
    this.aspect=aspect_ratio;
    this.o=o;
    this.total_pixels=(int)(this.wdth*this.h);
    
    this.util=new Util();
    
    this.samples=samples;
    
    this.w = PVector.sub(o,dir).normalize();
    this.u = up.cross(w).normalize();
    this.v = w.cross(u);
    
    this.foc_dist=foc_dist;
    this.aperture=aperture;
    this.lens_rad=aperture/2;
    
    
    this.hor=u.mult(this.vw*this.foc_dist);
    this.vert=v.mult(this.vh*this.foc_dist);
    this.llc=PVector.sub(this.o , PVector.add(PVector.add( PVector.div(this.hor,2) , PVector.div(this.vert,2) ),this.w.mult(foc_dist)));
  }
  void render(Scene s,float tmin,float tmax, int depth){
    noStroke();
    int pix=0;
    
    for (int j = 0; j < this.h; j++){
      for (int i = 0; i < this.wdth; i++){
        PVector colour = new PVector(0,0,0);
        for(int q=0;q<this.samples;q++){
          float u = (i+random(1.0))/(this.wdth-1);
          float v = (j+random(1.0))/(this.h-1);
          
          Ray r = this.get_ray(u,v);
          colour.add(s.colour_at(r,tmin,tmax,depth));
        }        
        colour=this.convertTo256(colour,this.samples);

        fill(colour.x,colour.y,colour.z);
        rect(i,height-j,2,2);
        println("Done: "+(pix++*100/this.total_pixels));
      }
    }
  }
  Ray get_ray(float s,float t){
    
    PVector rd = PVector.mult(this.util.rand_in_unit_disk(),this.lens_rad);
    PVector off = PVector.add(PVector.mult(this.u,rd.x),PVector.mult(this.v,rd.y));
    return new Ray(PVector.add(this.o,off),PVector.sub(PVector.add(this.llc,PVector.add(PVector.mult(this.hor,s) ,PVector.mult(this.vert,t))) , PVector.add(this.o,off)));
  }
  PVector convertTo256(PVector colour, int samples){
    float scl = 1.0/samples;
    colour.mult(scl);
    return new PVector((int)(256*min(max(sqrt(colour.x),0),0.999)),
                       (int)(256*min(max(sqrt(colour.y),0),0.999)),
                       (int)(256*min(max(sqrt(colour.z),0),0.999)));
  }
  
}
