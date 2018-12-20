use_bpm 90

use_synth :sine
use_synth_defaults attack: 4, release: 4
live_loop :a do
  play_pattern_timed [:d2, :g2, :c2, :c2], 4, attack: 2, release: 2
  sleep 1
end
live_loop :b do
  play_pattern_timed [:c3, :b2, :g2, :g2], 4, attack: 2, release: 2
  sleep 2
end
live_loop :c do
  play_pattern_timed [:a3, :d3, :b3, :b3], 4, attack: 2, release: 2
  sleep 3
end
live_loop :d do
  play_pattern_timed [:f4, :f4, :e4, :e4], 4, attack: 2, release: 2
  sleep 4
end
live_loop :e do
  play_pattern_timed [:d5, :g5, :c5, :c5], 4, attack: 2, release: 2
  sleep 5
end

