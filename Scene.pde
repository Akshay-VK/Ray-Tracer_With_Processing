class Scene{
  Camera cam;
  PVector white, sky;
  int depth;
  ArrayList<Object> objs;
  Util u;
  PImage skybox;
  Scene(ArrayList<Object> obj,Camera camera,String skyURL){
    this.cam=camera;
    println("Image width: "+this.cam.w);
    println("Image height: "+this.cam.h);
    println("Virtual width: "+this.cam.vw);
    println("Virtual height: "+this.cam.vh);
    white=new PVector(1.0,1.0,1.0);
    sky = new PVector(0.5,0.7,1.0);
    
    
    this.objs = obj;
    
    //float R = cos(PI/4);
    
    //Lambertian left = new Lambertian(new PVector(0.0,0.0,1.0));
    //Lambertian right = new Lambertian(new PVector(1.0,0.0,0.0));
    
    //this.objs=new Object[2];
    //this.objs[0]=new Sphere(new PVector(-R,0,-1),R,left);
    //this.objs[1]=new Sphere(new PVector(R,0,-1),R,right);
    
    this.depth=7;
    
    u=new Util();
    this.skybox = loadImage(skyURL);
  }
  void render(){
    this.cam.render(this,0.0000001,10000,this.depth);
  }
  PVector colour_at(Ray r, float tmin, float tmax, int depth){
    float closest=tmax;
    Record rec = new Record();
    if(depth<=0)return new PVector(0,0,0);
    for(int i = 0; i < this.objs.size(); i++){
      
      Record temp_rec = new Record();
      temp_rec= this.objs.get(i).hit(r,tmin,closest,rec);
      if(temp_rec.t>0){
        closest=temp_rec.t;
        rec=temp_rec;
      }
    }
    if(rec.t>0){
      Attenuation_Scattered attscat = new Attenuation_Scattered(new PVector(0,0,0),new Ray(new PVector(0,0,0),new PVector(0,0,0)));//default init
      attscat = rec.mat.scatter(r,rec,attscat);
      if(attscat.bool){
        PVector col = this.colour_at(attscat.scattered,tmin,tmax,depth-1);
        return new PVector(
          attscat.attenuation.x*col.x,
          attscat.attenuation.y*col.y,
          attscat.attenuation.z*col.z
        );
      }
      return new PVector(0,0,0);
      //PVector tar = PVector.add(PVector.add(rec.p,rec.normal),u.rand_in_unit_sphere().normalize());
      //return this.colour_at(new Ray(rec.p,PVector.sub(tar,rec.p)),tmin,tmax,depth-1).mult(0.5);
      //return PVector.mult(PVector.add(rec.normal,new PVector(1,1,1)),0.5);
    }
    //BLUE TO WHITE SKY
    //PVector unit = r.d.normalize();
    //float t = 0.5*(unit.y+1.0);
    //PVector res =PVector.add(PVector.mult(this.white,(1.0-t)),PVector.mult(this.sky,t));
    
    ////HDR
    PVector d = r.d.normalize();
    d.y*=-1;
    float u = 0.5+(atan2(d.x,d.z)/TWO_PI),v = 0.5+(asin(d.y)/PI);
    //println(u+"   "+v);
    
    color skycol = this.skybox.get((int)(u*this.skybox.width),(int)(v*this.skybox.height));
    PVector res = new PVector(red(skycol)/256.0,green(skycol)/256.0,blue(skycol)/256.0);
    //PVector res =new PVector(u,v,0);
    
    return res;
  }
}
