trail t;
slime[] s;

int numslimeball = 20000;

void setup(){
  
  size(800,600);
  
  t = new trail();
  s = new slime[numslimeball];

  for(int i = 0; i < numslimeball; i++){
   
    float x = width/2 + random(100) * cos(radians(random(360)));
    float y = height/2 + random(100) * sin(radians(random(360)));
    s[i] = new slime(x,y);
    s[i].deposit(t);
  }
  
}

void draw(){
  background(0);

  for(int i = 0; i < numslimeball; i++){
    
    s[i].sense(t);
    s[i].move();
    s[i].deposit(t);
  }

  t.diffuse();

  t.decay();

  t.draw();

  if(frameCount%40 == 0){
    println(floor(frameRate));
  }
 
  if(mousePressed){

    for(int i = 0; i < numslimeball; i++){
      s[i].reset();
    }
  }


}
