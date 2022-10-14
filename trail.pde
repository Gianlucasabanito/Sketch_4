
class trail{
  float[][] grid;
  float[][] buffer;
  float decayRate;
  float R = random(55);
  float g = random(255);
  float b = random(255);


  trail(){
    grid = new float[width][height];
    buffer = new float[width][height];
    decayRate = 0.6;
  }

  void draw(){
    loadPixels(); 
    for(int x = 0; x < width; x++){
      for(int y = 0; y < height; y++){
        int i = y * width + x;
        pixels[i] = color(t.grid[x][y],R,g,b);
      }
    }
    updatePixels();
  }

  void diffuse(){
    loadPixels();
    for(int x = 0; x < width; x++){
      for(int y = 0; y < height; y++){
        float sum = 0;
        float avg = 0;
        float total = 0;

        for(int kx = -1; kx < 2; kx++){
          for(int ky = -1; ky < 2; ky++){

            int currentX, currentY;
             
            if(x==width-1){
              currentX = 0;
            } else if(x==0){
              currentX = width-1;
            } else {
              currentX = kx+x;
            }
            
            if(y==height-1){
              currentY = 0;
            } else if(y==0){
              currentY = height-1;
            } else {
              currentY = ky+y;
            }

            float intensity = grid[currentX][currentY];
            sum += intensity;
            total ++;

          }
        }
        avg = sum / 9.0;
        
        buffer[x][y] = avg;
      }
    }

    
    for(int x = 0; x < width; x++){
      for(int y = 0; y< height; y++){
        grid[x][y] = buffer[x][y];
      }
    }
    clearBuffer();
  }

  void decay(){
    for(int x = 0; x < width; x++){
      for(int y = 0; y < height; y++){
        grid[x][y] *= decayRate;
      }
    }
  }

  void clearBuffer(){
    for(int x = 0; x<width;x++){
      for(int y = 0; y< height; y++){
        buffer[x][y] = 0;
      }
    }
  }

}
