/*
*filters.pde
*
* By: Marcelo Escamilla
*
* Use Up and Down key to sort through the 
* various filters and convolution masks 
* programmed here. The name will be displayed
* 
* If you want to add a filter, you should write it
* as a function that modifies a pixel built-in array.
* Add the name of the filter to the filters array and
* change the FILTERS variable. also add the filter function
* into the switch in chooseFilter()
*
*/
PImage img;

int picker = 2;
int FILTERS = 4;

String[] filters ={"gray scale,mean values","original","edge detection","embossed"};

void setup() {
  size(825,825);
  // Make a new instance of a PImage by loading an image file
  img=loadImage("gato.jpg");
  surface.setSize(img.width,img.height);
  textSize(32);
}

void draw() {
  background(0);
  loadPixels();
  chooseFilter();
  print(picker);
  
  
  updatePixels();
  fill(255,0,0);
   text(filters[picker],50,50);
}

void chooseFilter(){
 switch(picker){
   case 0:
     grayScaleMean();
     break;
   case 1:
     original();
     break;
   case 2:
     edgeDetection();
     break;
   case 3:
     embossed();
     break;
    
 } 
}

void grayScaleMean(){
   for(int i = 0; i < img.pixels.length; i++){
    float r = red(img.pixels[i]);
    float g = green(img.pixels[i]);
    float b = blue(img.pixels[i]);
    float mean = (r+g+b)/3;
    pixels[i] = color(mean,mean,mean);  
  }

}

void original(){
   for(int i = 0; i < img.pixels.length; i++){
    float r = red(img.pixels[i]);
    float g = green(img.pixels[i]);
    float b = blue(img.pixels[i]);
    pixels[i] = color(r,g,b);  
  }
}

void edgeDetection(){
 float [][] kernel = {{-1,-1,-1},
                      {-1,9,-1},
                      {-1,-1,-1}};
 for (int y = 1; y < img.height-1; y++) { // Skip top and bottom edges
    for (int x = 1; x < img.width-1; x++) { // Skip left and right edges
      float redsum = 0; // Kernel sum for this pixel
      float greensum =0;
      float bluesum =0;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*img.width + (x + kx);
          // Image is grayscale, red/green/blue are identical
          float val = red(img.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          redsum += kernel[ky+1][kx+1] * val;
          val = green(img.pixels[pos]);
          greensum += kernel[ky+1][kx+1] * val;
          val = blue(img.pixels[pos]);
          bluesum += kernel[ky+1][kx+1] * val;
        }
      }
      // For this pixel in the new image, set the gray value
      // based on the sum from the kernel
      pixels[y*img.width + x] = color(redsum, greensum, bluesum);
    }
  }           
}

void embossed(){
 float [][] kernel = {{-2,-1,0},
                      {-1,1,1},
                      {0,1,2}};
 for (int y = 1; y < img.height-1; y++) { // Skip top and bottom edges
    for (int x = 1; x < img.width-1; x++) { // Skip left and right edges
      float redsum = 0; // Kernel sum for this pixel
      float greensum =0;
      float bluesum =0;
      for (int ky = -1; ky <= 1; ky++) {
        for (int kx = -1; kx <= 1; kx++) {
          // Calculate the adjacent pixel for this kernel point
          int pos = (y + ky)*img.width + (x + kx);
          // Image is grayscale, red/green/blue are identical
          float val = red(img.pixels[pos]);
          // Multiply adjacent pixels based on the kernel values
          redsum += kernel[ky+1][kx+1] * val;
          val = green(img.pixels[pos]);
          greensum += kernel[ky+1][kx+1] * val;
          val = blue(img.pixels[pos]);
          bluesum += kernel[ky+1][kx+1] * val;
        }
      }
      // For this pixel in the new image, set the gray value
      // based on the sum from the kernel
      pixels[y*img.width + x] = color(redsum, greensum, bluesum);
    }
  }           
}


void HSL(){
    for(int i = 0; i < img.pixels.length; i++){
    float r = map(red(img.pixels[i]),0,255,0,1);
    float g = map(green(img.pixels[i]),0,255,0,1);
    float b = map(blue(img.pixels[i]),0,255,0,1);
    
    float M = max(r,g,b);
    float m = min(r,g,b);
    float C = M - m;
    
    print(r,g,b);
    //pixels[i] = color(r,g,b);  
  }
}

void keyPressed(){
  // These conditions prevent the precision from turning into a
  // negative value or a large number.
  if(keyCode == UP){
    picker = (picker+1)%FILTERS;
  }else if(keyCode == DOWN){
    picker=(picker-1)%FILTERS;
    if (picker ==-1) picker = FILTERS-1;
  }
}
