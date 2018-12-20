use_bpm 80

use_synth :piano
use_synth_defaults amp: 2
live_loop :chord do
  sleep 0.5
  play chord(:A2, :m7)
  sleep 1
  play chord(:D2, :dom7)
  sleep 1
  play chord(:G2, :M7)
  sleep 1.5
end

use_synth :blade
use_synth_defaults release: 0, amp: 0.5
i = 0
live_loop :solo do
  n = [1.0/4, 1.0/4, 1.0/2, 1.0/2, 1.0/8, 1.0/8, 1].choose
  with_swing 0.01 do
    with_fx :reverb, mix: 0.6 do
      with_fx :distortion, distort: 0.75, mix: 0.6, amp: 0.75 do
        i += [0, 1, -1, 2, -2].choose
        play scale(:g2, :major, num_octaves: 3)[i], amp: rrand(0.5, 1), sustain:n, vibrato_rate: 6, vibrato_depth: 0.75, cutoff: 95
      end
    end
  end
  sleep n
end

use_synth :sine
use_synth_defaults amp: 0.2
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
  with_swing 1 do
    sample :drum_cymbal_soft, amp: 0.5 if (bools 1, 0, 0, 0, 1, 0, 0, 1).tick
  end
  sleep 0.125
end

live_loop :snareBoi do
  n = [1.0/8, 1.0/4, 1.0/2, 1, 2].choose
  sleep 0.5
  sample :drum_snare_soft
  sleep 0.5
  
end
