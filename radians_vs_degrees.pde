// Pi Clock face by Rupert Russell
// Code on Git Hub at: https://github.com/rupertrussell/radians-vs-degrees
// Created 4 Jan 2017 v3-006
// Updated to produce a PDF file for laser engraving 18 Jan 2020
// Code uploaded to Github 18 Jan 2020
// Artwork on Redbubble at: https://www.redbubble.com/people/rupertrussell/works/24688144-radians-vs-degrees-clock-v001
// How to calculate points on a circle
// Based on code from http://www.mathopenref.com/coordcirclealgorithm...
// Licensed under Creative Commons Attribution ShareAlike
// https://creativecommons.org/licenses/by-sa/3.0
// https://creativecommons.org/licenses/GPL/2.0/

float steps = 12;
int counterA = 0;
int counterB = 10;
import processing.pdf.*;

PFont myFont;

void setup() {
  background(255);

  myFont = createFont("Georgia", 620);
  textFont(myFont, 200);
  size(13500, 13500); // Size of finished clock
  noLoop();
  smooth();
  strokeCap(SQUARE);
  beginRecord(PDF, "radians-vs-degrees.pdf"); // Saves to a PDF uncomment endrecord at bottom of code as wells
}
float clockRadius = 13500 / 2;
int xOffset = 0;
int yOffset = 0;
void draw() {
  textAlign(CENTER, CENTER);
  char m; // Declare variable 'm' of type char
  m = 960 ; // 960 = PI
  fill(100);
  ellipseMode(RADIUS); // Set ellipseMode to RADIUS
  strokeWeight(10);

  // Divide the clock into 12 hour segments
  stroke(0);
  strokeWeight(10);
  for (float i = 0; i < 360; i = i+( 360 / steps)) {
    line(width/2, height/2, clockRadius * 0.8 * cos(radians(i + 15 )) + width/2, clockRadius * 0.8 * sin(radians(i + 15)) + height/2 );
  }
  // White center
  fill(255);
  stroke(0);
  strokeWeight(17);
  ellipse(width/2, height/2, clockRadius * 0.65, clockRadius * 0.65);

  // Divide the clock into 365 degree segments
  stroke(0);
  strokeWeight(5);
  for (float i = 0; i < 360; i = i + 1) {
    line(clockRadius * 0.55 * cos(radians(i )) + width/2, clockRadius * 0.55 * sin(radians(i)) + height/2, clockRadius * 0.65 * cos(radians(i )) + width/2, clockRadius * 0.65 * sin(radians(i)) + height/2 );
  }

  // Divide the clock into radians segments
  stroke(255, 0, 0);
  strokeWeight(5);
  for (float radians = 2 * PI; radians >= 0; radians = radians - 0.01) {
    if (counterA == 5) {
      // every 5th division make the line thicker and a little higher
      strokeWeight(17);
      line(clockRadius * 0.65 * cos(radians) + width/2, clockRadius * 0.65 * sin(radians) + height/2, clockRadius * 0.69 * cos(radians) + width/2, clockRadius * 0.69 * sin(radians) + height/2 );
      counterA = 0;
    }
    if (counterB == 10) {
      strokeWeight(17);
      line(clockRadius * 0.65 * cos(radians) + width/2, clockRadius * 0.65 * sin(radians) + height/2, clockRadius * 0.71 * cos(radians) + width/2, clockRadius * 0.71 * sin(radians) + height/2 );
      counterB = 0;
    }
    strokeWeight(5);
    line(clockRadius * 0.65 * cos(radians) + width/2, clockRadius * 0.65 * sin(radians) + height/2, clockRadius * 0.67 * cos(radians) + width/2, clockRadius * 0.67 * sin(radians) + height/2 );
    counterA = counterA + 1;
    counterB = counterB + 1;
  }

  // Dashes for each hour
  strokeWeight(15);
  double step = radians(360) / 12;
  float h = width / 2;
  float k = height /2;
  float r = clockRadius * 0.29;
  for (float theta=0; theta < 2 * PI; theta += step) {
    float x1 = h + r * 1.1 * cos(theta);
    float y1 = k - r * 1.1 * sin(theta); //note 2.
    float x2 = h + r * 0.9 * cos(theta);
    float y2 = k - r * 0.9 * sin(theta); //note 2.
    line(x1, y1, x2, y2); // draw the dashes for each hour
  }
  fill(0);
  stroke(0);
  textFont(myFont, 150); // set the font size for each fraction of PI

  // PI / 2 (12 O Clock)
  float x1 = h + r * 1.6 * cos(PI /2);
  float y1 = k - r * 1.6 * sin(PI /2);
  text(m, x1, y1); // PI
  line(x1 - 90, y1 + 110, x1 + 90, y1 + 110 );
  text(2, x1, y1 + 180);
  // END PI / 2 (12 O Clock) -——————

  // PI / 3 (1'Clock) -————————
  xOffset = - 90;
  x1 = h + r * 1.6 * cos(PI /3);
  y1 = k - r * 1.6 * sin(PI /3);
  textAlign(CENTER, CENTER);
  text(m, x1 + xOffset, y1);
  line(x1 - 90 + xOffset, y1 + 110, x1 + 90 + xOffset, y1 + 110 );
  text(3, x1 + xOffset, y1 + 180);
  // END PI / 3 (1'Clock) -———————

  // PI / 6 (2'Clock) -————————
  xOffset = - 80;
  x1 = h + r * 1.6 * cos(PI /6);
  y1 = k - r * 1.6 * sin(PI /6);
  textAlign(CENTER, CENTER);
  text(m, x1 + xOffset, y1);
  line(x1 - 90 + xOffset, y1 + 110, x1 + 90 + xOffset, y1 + 110);
  text(6, x1 + xOffset, y1 + 180);
  // END PI / 6 (2'Clock) -———————

  // 2 * PI (3'Clock) -————————
  x1 = h + r * 1.6 * cos(2 * PI);
  y1 = k - r * 1.6 * sin(2 * PI);
  textAlign(CENTER, CENTER);
  text(m, x1, y1 - 20);
  text(2, x1 - 90, y1 - 20);
  // END 2 * PI (3'Clock) -————————

  // 11 * PI /6 (4'Clock) -————————
  x1 = h + r * 1.6 * cos(11 * PI /6);
  y1 = k - r * 1.6 * sin(11 * PI /6);
  textAlign(CENTER, CENTER);
  text(m, x1, y1 - 200);
  line(x1 - 200, y1 - 80, x1 + 60, y1 - 80);
  text(11, x1 - 120, y1 - 200);
  text(6, x1 - 80, y1 + -20);
  // END 11 * PI /6 (4'Clock) -————————

  // 5 * PI /3 (5'Clock) -————————
  x1 = h + r * 1.6 * cos(5 * PI /3);
  y1 = k - r * 1.6 * sin(5 * PI /3);
  textAlign(CENTER, CENTER);
  text(m, x1 - 50, y1 - 200); // PI Position on line
  //line(x1 - 200, y1 110, x1 + 60, y1 110);
  line(x1 - 200, y1 - 80, x1 + 0, y1 - 80); // Line length 200
  text(5, x1 - 140, y1 - 200);
  text(3, x1 - 80, y1 + -20);
  // END 4 * PI /4 (5'Clock) -————————

  // 3 * PI/2 (6'Clock) -————————
  x1 = h + r * 1.6 * cos(3 * PI /2);
  y1 = k - r * 1.6 * sin(3 * PI /2);
  text(m, x1 + 50, y1 - 200);
  line(x1 - 100, y1 - 80 , x1 + 100, y1 - 80); // Line length 200
  text(3, x1 - 40, y1 - 200);
  text(2, x1, y1 + -20);
  // END 3 * PI/2 (6'Clock) -————————

  // 4 * PI /3 (7'Clock) -————————
  x1 = h + r * 1.6 * cos(4 * PI /3);
  y1 = k - r * 1.6 * sin(4 * PI /3);
  xOffset = 100;
  text(m, x1 + 50 + xOffset, y1 - 200);
  line(x1 - 100 + xOffset, y1 - 80, x1 + 100 + xOffset, y1 - 80); // Line length 200
  text(4, x1 - 40 + xOffset, y1 - 200);
  text(3, x1 + xOffset, y1 + -20);
  // END 4 * PI /3 (7'Clock) -————————

  // 7 * PI /6 (8'Clock) -————————
  x1 = h + r * 1.6 * cos(7 * PI /6);
  y1 = k - r * 1.6 * sin(7 * PI /6);
  xOffset = 100;
  text(m, x1 + 50 + xOffset, y1 - 200);
  line(x1 - 100 + xOffset, y1 - 80, x1 + 100 + xOffset, y1 - 80); // Line length 200
  text(7, x1 - 40 + xOffset, y1 - 200);
  text(6, x1 + xOffset, y1 + -20);
  // END 7 * PI /6 (8'Clock) -————————

  // PI (9'Clock) -————————
  x1 = h + r * 1.6 * cos(PI);
  y1 = k - r * 1.6 * sin(PI);
  xOffset = 100;
  yOffset = - 25;
  text(m, x1 + 50 + xOffset, y1 + yOffset);
  // END PI (9'Clock) -————————

  // 5 * PI /6 (10'Clock) -————————
  x1 = h + r * 1.6 * cos(5 * PI /6);
  y1 = k - r * 1.6 * sin(5 * PI /6);
  xOffset = 100;
  text(m, x1 + 50 + xOffset, y1 - 0); // Pi
  line(x1 - 100 + xOffset, y1 + 120, x1 + 100 + xOffset, y1 + 120); // Line length 200
  text(5, x1 - 40 + xOffset, y1 - 0);
  text(6, x1 + xOffset, y1 + 185);
  // END 5 * PI /6 (10'Clock) -————————

  // 2 * PI /3 (11'Clock) -————————
  x1 = h + r * 1.6 * cos(2 * PI /3);
  y1 = k - r * 1.6 * sin(2 * PI /3);
  xOffset = 100;
  text(m, x1 + 50 + xOffset, y1 - 0); // Pi
  line(x1 - 100 + xOffset, y1 + 110, x1 + 100 + xOffset, y1 + 110); // Line length 200
  text(2, x1 - 40 + xOffset, y1 - 0);
  text(3, x1 + xOffset, y1 + 185);
  // END 2 * PI /3 (11'Clock) -————————
  // print PI at center of clock
  x1 = h + r * 1.8 * cos( PI / 2);
  y1 = k - r * 1.8 * sin( PI / 2); //note 2.
  fill(0);

  noFill();
  strokeWeight(17);
  ellipse(width/2, height/2, clockRadius * 0.65, clockRadius * 0.65);

  // Display the Pi Symbol in the center of the clock face 
  textFont(myFont, 700);
  text(m, width / 2, height / 2 - 75);
  save("radians-vs-degrees.png");
  endRecord();  // Save the PDF file
  exit();
}
/*
Like most graphics systems, the canvas element differs from the usual mathematical coordinate plane:
 The origin is in the top left corner.
 The code above compensates by assuming that h, and k are actually relative to the top left.
 The y axis is inverted. Positive y is down the screen, not up. To correct for this, the k variable (the y coordinate of the center) must be positive to place the center some way down the screen.
 Also the y calculation has to subtract the sin(x) term instead of add.
 Marked in the code as Note 1.
 Note 2. The step size is set to an exact division of 2? to avoid gaps or over-runs in the circle. This code divides the circle into exactly 20 segments.
 Note too that as in most computer languages, the trig functions operate in radians, not degrees.
 360° = 2? radians.
 */
