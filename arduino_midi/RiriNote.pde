/*
*	RiriNote
*
*	Encapsulates values and operations for playing a MIDI note
*/

public class RiriNote {
	
	/*
	*	Instance Variables
	*/

	// GLOBALS
	// MidiBus mb;

	// Am I currently playing?
	boolean playing = false;

	// Start/end time (in milliseconds)
	int duration = 0;
	int startTime = 0;
	int endTime = 0;

	// MIDI note properties
	int channel = 0;
	int pitch = 0;
	int velocity = 0;

	/*
	*	Default Constructor	
	*/
	public RiriNote() {
		
	}

	/*
	*	Constructor
	*	@param int aChannel = the channel the note should be played on (0-15)
	*	@param int aPitch = the pitch of the note (0-127)
	*	@param int aVelocity = the velocity of the note (0-127)
	*/
	public RiriNote(int aChannel, int aPitch, int aVelocity) {
		// Set instance vars
		channel = aChannel;
		pitch = aPitch;
		velocity = aVelocity;
	}

	/*
	*	Constructor
	*	@param int aChannel = the channel the note should be played on (0-15)
	*	@param int aPitch = the pitch of the note (0-127)
	*	@param int aVelocity = the velocity of the note (0-127)
	*	@param int aDuration = the duration of the note (in milliseconds)
	*/
	public RiriNote(int aChannel, int aPitch, int aVelocity, int aDuration) {
		// Set instance vars
		channel = aChannel;
		pitch = aPitch;
		velocity = aVelocity;
		duration = aDuration;
	}

	/*
	*	draw() - Code to run during the sketch's draw loop
	*
	*	Used to determine when to stop playing a note (note has exceeded its duration)
	*
	*	Must be registered in the sketch by calling "this.registerDraw(<RiriNote>)"
	*	Replace <RiriNote> with the name of your instance
	*/
	public void draw() {
		// Stop playing the note if we have exceeded the duration
		if (duration > 0) {
			if (playing && milsPassed >= endTime) {
				stop();
			}
		}
	}

	/*
	*	play() - Start playing the note
	*/
	public void play() {
		/*if (duration <= 0) {
			println("Note not played, duration must be greater than 0.");
			return;
		}*/
		if (!playing) {
			mb.sendNoteOn(channel, pitch, velocity);
			playing = true;
			startTime = milsPassed;
			endTime = startTime + duration;
			println("playing " + pitch);
		}
		else {
			println("Note not played, already playing!");
		}
	}

	/*
	*	stop() - Stop playing a note
	*/
	public void stop() {
		if (playing) {
			mb.sendNoteOff(channel, pitch, velocity);
			playing = false;
			startTime = 0;
			endTime = 0;
			println("stopping " + pitch);
		}
		else {
			println("Note not stopped, already stopped!");
		}
	}

	/*
	*	Getters/Setters
	*
	*	Getters take no parameters, returns the value of the property
	*	Setters take one parameter, the new value of the property
	*/
	public int channel() {
		return channel;
	}

	public void channel(int c) {
		channel = c;
	}

	public int pitch() {
		return pitch;
	}

	public void pitch(int p) {
		pitch = p;
	}

	public int velocity() {
		return velocity;
	}

	public void velocity(int v) {
		velocity = v;
	}

	public int duration() {
		return duration;
	}

	public void duration(int d) {
		duration = d;
	}

}