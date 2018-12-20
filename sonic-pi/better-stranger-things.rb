use_bpm 80
noteList = [:C3, :E3, :G3, :B3, :C4, :B3, :G3, :E3].ring
use_synth :prophet
i = 0
stopTime = 32

live_loop :arp do
  i += 1
  if i >= stopTime
    play_chord chord(:c, :M7), sustain: 4
    play :c2, sustain: 4
    stop
  end
  play_pattern_timed noteList, 0.25, cutoff: 50 + i*2
end

live_loop :chordBoi do
  use_synth :tb303
  use_synth_defaults res: 0.5, amp: 0.25, release: 2
  if i >= stopTime
    stop
  end
  if i < 8
    sleep 16
  else
    play :c2, sustain: 3
    sleep 6
    play :d2, sustain: 4
    sleep 2
    play :e2, sustain: 4
    sleep 8
  end
end


live_loop :kick do
  if i >= stopTime
    sample :drum_bass_hard
    sleep 0.25
    sample :drum_bass_hard
    stop
  end
  sample :drum_bass_hard
  sleep 0.25
  sample :drum_bass_hard
  if i < 17
    sleep 0.75
  else
    sleep 0.25
    sample :drum_snare_hard
    sleep 0.5
  end
end

live_loop :hh do
  if i >= stopTime
    sample :drum_cymbal_open
    stop
  end
  if i < 16
    sleep 4
  else
    sample :drum_cymbal_closed, release: 0.2
    sleep 0.25
  end
end


