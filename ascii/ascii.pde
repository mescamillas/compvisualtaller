/*
* ascii.pde
*
* By: Marcelo Escamilla
*
* use Up and Down keys to control the program's precision. A higher precision
* means a "lower resolution" ascii image, meanwhile a lower precision (min value = 1)
* is a "higher resolution" ascii image. You can experiment by adding different
* characters to the letters string.
*/

// the image to asciify and its original for display.
PImage img;
PImage put;

// Characters for ascii image
String letters = "MN@#$o;:,.";
 
// sampling precision: colors will be sampled every n pixels 
// to determine which character to display
int precision = 5;

// array to hold characters for pixel replacement
char[] ascii;
 
void setup() {
  img = loadImage("grayscaletest.jpg");
  put = img.copy();
  img.resize(width/2,0);
  put.resize(width/2,0);
  
  size(825,825);
  surface.setSize(825, img.height);
  background(255);
  fill(0);
  noStroke();
 
  // build up a character array that corresponds to brightness values
  ascii = new char[256];
  for (int i = 0; i < 256; i++) {
    int index = int(map(i, 0, 256, 0, letters.length()));
    ascii[i] = letters.charAt(index);
  }
 

}

void draw(){
  background(255);
  PFont mono = createFont("Courier", precision + 2);
  textFont(mono);
  image(put,width/2,0);
  asciify();

}
 
void asciify() {
  // since the text is just black and white, converting the image
  // to grayscale seems a little more accurate when calculating brightness
  img.filter(GRAY);
  img.loadPixels();
 
  // grab the color of every nth pixel in the image
  // and replace it with the character of similar brightness
  for (int y = 0; y < img.height; y += precision) {
    for (int x = 0; x < img.width; x += precision) {
      color pixel = img.pixels[y * img.width + x];
      text(ascii[int(brightness(pixel))], x, y);
    }
  }
}

void keyPressed(){
  // These conditions prevent the precision from turning into a
  // negative value or a large number.
  if(keyCode == UP && precision > 1){
    precision--;
  }else if(keyCode == DOWN && precision <= 200){
    precision++;
  }
}
