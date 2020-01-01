require 'midilib'

class BlogComposition
  include MIDI

  def initialize
    @sequence = Sequence.new
    @track = create_track
  end

  def perform
    write_to_track
    write_to_midi_file
  end

  private

  def create_track
    track = Track.new(@sequence)
    @sequence.tracks << track
    track
  end

  def write_to_track
    pitches = [69, 71, 73, 76, 78]
    channel = 0
    velocity = 60
    delta_start_time = 0
    delta_end_time = 240

    pitches.each do |pitch|
      @track.events << NoteOn.new(channel, pitch, velocity, delta_start_time)
      @track.events << NoteOff.new(channel, pitch, velocity, delta_end_time)
    end
  end

  def write_to_midi_file
    file_name = "./midi/#{Time.now}.mid"
    File.open(file_name, 'wb') { |file| @sequence.write(file) }
  end
end

BlogComposition.new.perform
