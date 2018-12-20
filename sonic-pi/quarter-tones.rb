a = [60, 60.5, 61, 61.5, 62, 62.5, 63, 63.5, 64, 64.5, 65, 65.5, 66, 66.5, 67, 67.5, 68, 68.5, 69, 69.5, 70, 70.5, 71, 71.5, 72]
live_loop :a do
  b = choose([1, 1.0/2, 1.0/4, 1.0/8])
  play choose(a), sustain:b, release: 0
  sleep b
end

live_loop :b do
  play :c2, attack:1, release:3
  sample :drum_bass_soft
  sleep 4
end

# play_pattern_timed a, 1, release: 0