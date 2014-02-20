// The MidiBus library
import themidibus.*;
// Libraries for Arduino
import processing.serial.*;
import org.firmata.*;
import cc.arduino.*;

// Dimensions of sketch
int WIDTH = 400;
int HEIGHT = 400;
// Radius of circle to draw
int RAD = 0;
// Arduino object and properties
Arduino arduino;
int potPin = 2;
double potVal = 0;
boolean play = true;
// MidiBus object and some channels
MidiBus mb;
int pitch = 0;
int channel1 = 0;
int channel2 = 1;
int channel3 = 2;
int channel4 = 3;
// LiveNote and other music properties
LiveNote note, note2;
//int BPM = 70;
int milsPassed = 0;
int lastMils = 0;
int INTERVAL = 1000;

void setup() {
  	// Set up the sketch
  	size(WIDTH, HEIGHT);
  	RAD = Math.min(WIDTH, HEIGHT);
  	ellipseMode(CENTER);
  	// Connect to the first available Arduino
  	println(Arduino.list());
  	arduino = new Arduino(this, "/dev/tty.usbmodem411", 57600);
  	// Instantiate the MidiBus
  	MidiBus.list();
  	mb = new MidiBus(this, -1, 1);
}

void draw() {
	  background(0,0,0);
    // Get a 0-1 value of the pot
  	potVal = (double) arduino.analogRead(potPin) / 1024;
    // Use potVal to determine theh pitch
    pitch = (int) (potVal * 38) + 60;
    // Draw a circle based on the pot value
    fill(255,255,255);
  	ellipse((int)WIDTH/2, (int)HEIGHT/2, (int)(RAD * potVal), (int)(RAD * potVal));
  	// Play a note based on the pot value
    milsPassed = millis();
    if (play) {
        if (milsPassed - lastMils >= INTERVAL) {
            note = new LiveNote(pitch, channel1, INTERVAL, 127);
            this.registerDraw(note);
            //note2 = new LiveNote(pitch + 7, channel2, INTERVAL, 127);
            //this.registerDraw(note2);
            lastMils = milsPassed;
        }     
    }
}

void keyPressed() {
    // Toggle playing if the spacebar is pressed
    if (key == ' ') {
        play = !play;
    }
}
