PImage img;

void setup() {
  size(825,825);
  // Make a new instance of a PImage by loading an image file
  img=loadImage("grayscaletest.jpg");
}

void draw() {
  loadPixels();
  img.loadPixels();
  for(int i = 0; i < img.pixels.length; i++){
    float r = red(img.pixels[i]);
    float g = green(img.pixels[i]);
    float b = blue(img.pixels[i]);
    float mean = (r+g+b)/3;
    pixels[i] = color(mean,mean,mean);  
  }
  updatePixels();
}
