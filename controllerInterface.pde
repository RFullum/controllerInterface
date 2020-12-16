/*
*  Wrote this sketch to turn a Raspberry Pi 3a+ with 7" Touchscreen
*  into an XY Touch controller interface via serial, over bluetooth,
*  to remotely control an audio filter cutoff and resonance remotely.
*  
*  Video of sketch in action: https://youtu.be/67J7bS4KMD0
*  
*  Should work for touchscreen or mouse. 
*
*  Robert Fullum 2020
*/

import processing.serial.*;

Serial port;
int val = 0;
int valueScale = 128;


void setup() 
{
  fullScreen();
  printArray(Serial.list());
  port = new Serial(this, Serial.list()[0], 115200);
}

//create touch crosshair vertical line
void verticalLine() 
{
  line(mouseX, 0, mouseX, height);
}

//create touch crosshair horizontal line
void horizontalLine() 
{
  line(0, mouseY, width, mouseY);
}

//Get XY coordinates of touch/mouse
void touchLocation() 
{  
}

// This can be used to test XY values or removed
void printLocation() 
{
  print(mouseX, "\t" , mouseY, "\n");
}

//draw crosshairs that follow touch on screen or mouse
void draw() {
  background(97, 255, 250);
  verticalLine();
  horizontalLine();
  
  int xByte = (mouseX * valueScale)/ width;
  int yByte = (mouseY * valueScale)/ height;
  
  //int xByte = (int)map(mouseX, 0, width, 0, valueScale); //valueScale needs to be 127
  
  port.write(xByte);
  port.write(yByte);
}
