use_synth :hollow
live_loop :bass do
  with_fx :reverb, mix: 0.7 do
    play :C2, attack: 5, release: 5, amp: 1
    sleep 5
  end
end

live_loop :bass2 do
  with_fx :reverb, mix: 0.7 do
    play :G2, attack: 5, release: 5, amp: 1
    sleep 10
  end
end

use_synth :sine
use_synth_defaults attack: 0, sustain: 0, release: 2

live_loop :chords do
  with_fx:reverb, mix: 0.7 do
    play_chord chord(:G3, :M7)
    sleep 10
  end
end

live_loop :chords2 do
  with_fx :reverb, mix: 0.7 do
    play_chord chord(:C3, :M7)
    sleep 3
  end
end

live_loop :chords3 do
  with_fx :reverb, mix: 0.7 do
    play_pattern_timed [:g4, :b4, :c4], 1
    sleep 5
  end
end

live_loop :chords4 do
  with_fx :reverb, mix: 0.7 do
    play_pattern_timed [:g4, :b4, :c4], 1
    sleep 3
  end
end