use_bpm 82
use_synth :piano
use_synth_defaults hard: 0.1, vel: 0.2
live_loop :pianer do
  with_fx :gverb do
    play :d1, release: 10
    sleep 2
    play_pattern_timed [:g4, :a4, :fs4, :e4, :d4, :d5], 1
    sleep 4
    play_pattern_timed [:a4, :fs4, :e4], 1
    play :d4, release:4
    sleep 3
    sleep 8
  end
end

live_loop :piana2 do
  with_fx :reverb do
    sleep 15
    play :g3, release: 4
    play :a3, release: 4
    play :d4, release: 4
    sleep 3
    play :d1, release: 30
    play :d2, release: 30
  end
end

use_synth :sine
use_synth_defaults attack: 2, release: 2, cutoff: 90
live_loop :pad do
  sleep 21
  play :b3, sustain: 4
  play :fs3, sustain: 4
  sleep 6
end
