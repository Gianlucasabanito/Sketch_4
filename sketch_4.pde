class slime{

  PVector pos;
  PVector dir;
  float direction; 
  float Speed;

  float Amt;
  float Dist;

  slime(float x, float y ){
    pos = new PVector(x,y);
    dir = new PVector(0,0);
    
    direction = floor(random(16));
    
    Amt = 170;
    Speed = 6;
    Dist = 7.5;
  }

  void show(){
    
    pushStyle();
    point(pos.x,pos.y);
    popStyle();
  }

  void deposit(trail tm){
    int x = floor(pos.x);
    int y = floor(pos.y);


    tm.grid[x][y] += Amt;
  }

  void sense(trail tm){

    float nextPower = 0;
    float maxPower = 0;
    float maxDirection = 0;
    for(int i = -1; i<2; i++){
      float look = direction + i;
      float angle = radians(look*22.5);

      PVector offset = PVector.fromAngle(angle).mult(Dist);
 

      int currentX, currentY;
      currentX = int(pos.x + offset.x);
      currentY = int(pos.y + offset.y);

      if(currentX > width-1){
        currentX = 0;
      } else if(currentX < 0){
        currentX = width-1;
      }

      if(currentY > height-1){
        currentY = 0;
      } else if(currentY < 0){
        currentY = height-1;
      }

      nextPower = tm.grid[currentX][currentY];
      if(maxPower < nextPower){
        maxPower = nextPower;
        dir.x = offset.x;
        dir.y = offset.y;
        dir.setMag(Speed);
        maxDirection = i;
      }
   }
   
    direction+=maxDirection;
  }

  void move(){
    pos.add(dir);
    wrap();
    
  }

  void wrap(){
    if(pos.x > width-1){
      pos.x = 0;
    } else if (pos.x < 0){
      pos.x = width-1;
    }

    if(pos.y > height-1){
      pos.y = 0;
    } else if (pos.y < 0){
      pos.y = height-1;
    }
  }

  void resetPos(){
    if(pos.x > width-1 || pos.x < 0 ||
      pos.y > height-1 || pos.y < 0){
      pos.x = floor(random(width));
      pos.y = floor(random(height));
      dir = PVector.random2D();
    }
  }

  void reset(){
    pos = new PVector(random(width),random(height));
  }


}
