public class LiveNote{
  
  int startTime = 0;
  int endTime = 0;
  boolean alive = true;
  
  int pitch;
  int channel;
  int duration;
  int velocity;
  
  LiveNote(int aPitch, int aChannel, int aDuration, int aVelocity){
    
    pitch = aPitch;
    channel = aChannel;
    duration = aDuration;
    velocity = aVelocity;
    
    //fill(random(255),random(255),random(255));
    
    mb.sendNoteOn(channel, pitch, velocity);
    //ellipse(random(400),random(400),50,50);
    
    startTime = milsPassed;
    endTime = startTime + duration;

    // announce creation
    println("alive at ",milsPassed);
    
  } // constructor
  
  void draw(){
    //println("I AM ALIVE AND HAVE PERSISTED FOR ", milsPassed);
    
    // if alive & expiration time hit
    if(alive && milsPassed >= endTime){
      
      // just a visual signal that the note's dying
      //rect(random(400),random(400),50,50);
      
      // da juicy shet
      mb.sendNoteOff(channel, pitch, velocity);
      
      // disable timer
      alive = false;
      
      // announce death
      println("dead at ",milsPassed);
      
      // note that no garbage collection or memory management
      // is going on here. We need to test whether garbage
      // builds up to dangerous levels over the course of hours
    } // if
  } // draw

  // turn beats into mils for the note calls
  /*float beatsToMils(float beats){
    // (one second split into single beats) * # needed
    float convertedNumber = (60000 / BPM) * beats;
    return convertedNumber;
  }*/
  
  
} // class
