use_bpm 90

use_synth :sine
use_synth_defaults attack: 4, release: 4
live_loop :a do
  #play choose([:c1, :d1, :e1, :fs1, :gs1, :bb1])
  sleep 12
end

live_loop :b do
  #play choose([:c3, :d3, :e3, :fs3, :gs3, :bb3]), attack:12, release:8
  sleep 15
end

live_loop :c do
  #play choose([:c4, :d4, :e4, :fs4, :gs4, :bb4]), attack:1, release:3
  sleep 18
end

live_loop :d do
  #play_pattern_timed choose([[:c4, :e4], [:fs4, :bb4]]), 0.5, attack: 0, release: 0.5
  sleep 2
end

live_loop :e do
  #play_pattern_timed choose([[:c4, :e4], [:fs4, :bb4]]), 0.5, attack: 0, release: 0.5
  sleep rrand(1, 4)
end

live_loop :beat do
  with_fx :reverb do
    sample :bd_808, amp: 2
    sample :bd_boom , amp: 0
    sample :glitch_bass_g, amp: 0
    sleep 4
  end
end

live_loop :noize do
  use_synth :bnoise
  #play :c, attack: 8, release: 16, cutoff: 80, amp: 0.7
  sleep 16
end

live_loop :haunted do
  #sample :perc_bell, rate: rrand(-1.5, 1.5), amp: 0.5
  sleep rrand(0.1, 2)
end