use_synth :sine
use_synth_defaults

live_loop :lowboi do
  play scale(:c2, :aeolian).choose, attack: 5, release: 10
  sleep 11
end

live_loop :midboi do
  play scale(:e3, :aeolian).choose, attack: 5, release: 5
  sleep 13
end

live_loop :highboi do
  play scale(:gs4, :aeolian).choose, attack: 2, release: 8
  sleep 15
end
with_fx :reverb, mix: 0.5 do
  live_loop :oceans do
    s = synth [:bnoise, :cnoise, :gnoise].choose, amp: rrand(0.5, 1.5), attack: rrand(0, 4), sustain: rrand(0, 2), release: rrand(1, 5), cutoff_slide: rrand(0, 5), cutoff: rrand(60, 100), pan: rrand(-1, 1), pan_slide: rrand(1, 5), amp: rrand(0.5, 1)
    control s, pan: rrand(-1, 1), cutoff: rrand(60, 110)
    sleep rrand(2, 4)
  end
end