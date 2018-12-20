use_bpm 60

use_synth :piano
live_loop :chord do
  play chord(:A2, :m7)
  sleep 1
  play chord(:D2, :dom7)
  sleep 1
  play chord(:G2, :M7)
  sleep 2
end

i = 0
live_loop :solo do
  n = [1.0/4, 1.0/4, 1.0/2, 1.0/2, 1.0/8, 1.0/8, 1.0/16, 1].choose
  i += [0, 1, -1, 2, -2].choose
  play scale(:g3, :major, num_octaves: 3)[i], amp: rrand(0.5, 1)
  sleep n
end

use_synth :sine
use_synth_defaults amp: 0.5
live_loop :bassBoi do
  1.times do
    play chord(:A1, :m7).choose
    sleep 1
  end
  1.times do
    play chord(:D1, :dom7).choose
    sleep 1
  end
  2.times do
    play chord(:G1, :M7).choose
    sleep 1
  end
end

live_loop :kickBois do
  n = [1, 2, 4].choose
  sample :drum_bass_soft, amp: 2
  sleep n
end

live_loop :rideBoi do
  sample :drum_cymbal_soft, amp: rrand(0.1, 0.5)
  sleep 0.6
  sample :drum_cymbal_soft, amp: rrand(0.1, 0.5)
  sleep 0.25
  sample :drum_cymbal_soft, amp: rrand(0.1, 0.5)
  sleep 0.15
end

live_loop :snareBoi do
  n = [1.0/8, 1.0/4, 1.0/2, 1, 2].choose
  sample :drum_snare_soft
  sleep n
end
