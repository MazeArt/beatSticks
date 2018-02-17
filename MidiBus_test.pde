import processing.serial.*;
import themidibus.*; //Import the midibus library

MidiBus myBus; // The MidiBus
int value=0;
int channel = 0;
int note_pitch = 38; //36 is C1:Kick , 38 is D1:Snare
int velocity = 127;

void setup() 
{
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
// or for testing you could ...
  //                 Parent  In  Out
  //                     |    |  |
 // myBus = new MidiBus(this, 0, 2); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
//end of MIDI

myBus = new MidiBus(this, 0, "IAC Bus 1"); // "IAC Bus 1" is the Virtual BUS
  
}

void draw() {

  fill(value);
  rect(25, 25, 50, 50);
 
}

void keyPressed() 
{
  if (key == 'a'){ //send a midi_note
    println("pressed a");
    sendMIDI_note(channel,note_pitch,velocity); 
  }
  if (key == 'h'){ //switch to SNARE
  println("pressed h");
  channel = 0;
  note_pitch = 38; //snare
  velocity = 127;
  }
  if (key == 'j'){ //switch to KICK
  println("pressed j");
  channel = 0;
  note_pitch = 36; //kick
  velocity = 127;
  }  
}



//midi Listen to drumstick on triggerIO
void noteOn(Note note) {
  // Receive a noteOn
 
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+note.channel());
  println("Pitch:"+note.pitch());
  println("Velocity:"+note.velocity());
  
  // lee angulo yaw del sensor y velocity del piezo 
  //println("yaw:"+degrees(Euler[0]));
//float yaw= degrees(Euler[0]);
//println("yaw:"+yaw);
//sendMIDIMessage();
}

void sendMIDI_note(int channel, int note_pitch, int velocity) {
  println("sending midi mesage");
//  int channel = 0;
//  int pitch = 38; //36 is C1:Kick , 38 is D1:Snare
//  int velocity = 127;
  Note note = new Note(channel, note_pitch, velocity);

  myBus.sendNoteOn(note); // Send a Midi noteOn
  //delay(200);
  myBus.sendNoteOff(note); // Send a Midi nodeOff
}



 void noteOff(Note note) {
  // Receive a noteOff
  println();
  println("Note Off:");
  //println("--------");
  //println("Channel:"+note.channel());
  //println("Pitch:"+note.pitch());
 // println("Velocity:"+note.velocity()); 
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}