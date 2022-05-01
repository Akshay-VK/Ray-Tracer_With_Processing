final int WIDTH=640,HEIGHT=360;
Scene scn;

void setup(){
  size(900,600);
  
  //Lambertian ground = new Lambertian(new PVector(0.5,0.5,0.5));
  //Lambertian center = new Lambertian(new PVector(0.1,0.2,0.5));
  ////Dielectric center = new Dielectric(1.5);
  ////Metal left = new Metal(new PVector(0.8,0.8,0.8),0.1);
  //Dielectric left = new Dielectric(1.5);
  //Metal right = new Metal(new PVector(0.8,0.6,0.2),0.0);
  
  
  //ArrayList<Object> objs = new ArrayList<Object>();
  //objs.add(new Sphere(new PVector(0,0,-1),0.5,center));
  //objs.add(new Sphere(new PVector(-1,0,-1),0.5,left));
  //objs.add(new Sphere(new PVector(-1,0,-1),-0.45,left));
  //objs.add(new Sphere(new PVector(1,0,-1),0.5,right));
  //objs.add(new Sphere(new PVector(0,-100.5,0),100,ground));
  
  ArrayList<Object> objs = rand_scene();
  PVector o = new PVector(13,2,3);
  PVector dir = new PVector(0,0,0);
  Camera cam=new Camera(900,20.0f,3f/2f,12.0,0.05,o,dir,new PVector(0,1,0),200);
  scn=new Scene(objs,cam,"photo_studio_loft_hall_1k.png");
}
void draw(){
  background(0);
  double a = millis(); 
  scn.render();
  println((millis()-a)/1000.0+" s");
  noLoop();
  save("first_rand_scene_with_hdr2.png");
}
ArrayList<Object> rand_scene(){
  Util u = new Util();
  ArrayList<Object> objs = new ArrayList<Object>();
  
  Lambertian ground = new Lambertian(new PVector(0.5,0.5,0.5));
  objs.add(new Sphere(new PVector(0,-500,0),500,ground));
  
  for(int a = -11; a <11; a++){
    for(int b = -11; b < 11; b++){
      float mat_col = random(1);
      PVector cen = new PVector(a+0.9*random(1),0.2,b+0.9*random(1));
      
      if(PVector.sub(cen,new PVector(4,0.2,0)).mag()>0.9){
        if(mat_col<0.8){
          PVector col=PVector.div(PVector.random3D(),2);
          Lambertian mat = new Lambertian(col);
          objs.add(new Sphere(cen,0.2,mat));
        }else if(mat_col<0.95){
          PVector col = u.rand_vector(0.5,1);
          float fuzz = random(0,0.5);
          Metal mat = new Metal(col,fuzz);
          objs.add(new Sphere(cen,0.2,mat));
        }else{
          Dielectric mat = new Dielectric(1.5);
          objs.add(new Sphere(cen,0.2,mat));
        }
      }
    }
  }
  
  Dielectric mat1 = new Dielectric(1.5);
  objs.add(new Sphere(new PVector(0,1,0),1,mat1));
  
  Lambertian mat2 = new Lambertian(new PVector(0.4,0.2,0.1));
  objs.add(new Sphere(new PVector(-4,1,0),1,mat2));
  
  Metal mat3 = new Metal(new PVector(0.7,0.6,0.5),0);
  objs.add(new Sphere(new PVector(4,1,0),1,mat3));
  
  return objs;
}
