t = Time.now.to_i
use_random_seed t
beats_per_measure = 4
# 4 = 16th notes, 3 might be triplets, 2 is 8th
subdivision = 4
tempo = rrand(30, 200)
use_bpm = tempo
key = :c
mode = :major
BassDrumSamples = [:bd_ada, :bd_pure, :bd_808, :bd_zum, :bd_gas, :bd_sone, :bd_haus, :bd_zome, :bd_boom, :bd_klub, :bd_fat, :bd_tek, :bd_mehackit, :drum_heavy_kick, :drum_bass_soft, :drum_bass_hard, :elec_soft_kick, :elec_hollow_kick]
SnareDrumSamples =[:sn_dub, :sn_dolf, :sn_zome, :sn_generic, :drum_snare_hard, :drum_snare_soft, :elec_snare, :elec_lo_snare, :elec_hi_snare, :elec_mid_snare, :elec_filt_snare]
MidDrumSamples = [:drum_tom_mid_soft, :drum_tom_mid_hard, :drum_tom_lo_soft, :drum_tom_lo_hard, :drum_tom_hi_soft, :drum_tom_hi_hard, :drum_cowbell, :elec_fuzz_tom, :elec_bong, :elec_twang, :elec_wood, :elec_bell, :elec_flip, :elec_tick, :elec_plip]
HighDrumSamples = [:elec_triangle, :elec_pop, :elec_beep, :elec_blip, :elec_blip2, :elec_ping, :elec_twip, :elec_blup]
CrashDrumSamples = [:drum_splash_soft, :drum_splash_hard, :drum_cymbal_soft, :drum_cymbal_hard, :elec_cymbal, :elec_chime]
HHDrumSamples = [:drum_cymbal_closed, :drum_cymbal_pedal]

# todo: sort glitchy, mehackit, misc, percussive, tabla
drum_bass = choose(BassDrumSamples)
drum_snare = choose(SnareDrumSamples)
drum_hh = choose(HHDrumSamples)

define :make_kick do |beats|
  result = []
  beats *= subdivision
  beats.times do |i|
    result.push(choose([drum_bass]+[nil]*i))
  end
  return result
end

define :make_snare do |beats|
  result = []
  beats *= subdivision
  beats.times do |i|
    result.push(choose([drum_snare]+[nil]*(i-beats/2).abs))
  end
  return result
end

define :make_hh do |beats|
  result = []
  beats *= subdivision
  beats.times do |i|
    result.push(choose(HHDrumSamples+[nil]))
  end
  return result
end

define :make_melody do |beats|
  result = []
  beats *= subdivision
  beats.times do |i|
    result.push(choose(scale(:c3, :major_pentatonic, num_octaves:2)+[nil]*rrand_i(1,8)))
  end
  return result
end

phrase_length = 8
kick_A = make_kick(phrase_length)
snare_A = make_snare(phrase_length)
hh_A = make_hh(phrase_length)
melody = make_melody(phrase_length)

live_loop :drum_loop do
  cue :one
  (phrase_length*subdivision).times do |i|
    sample kick_A[i], pan: rrand(-1, 1)
    sample snare_A[i], amp: rrand(0, 1), pan: rrand(-1, 1)
    sample hh_A[i], amp: rrand(0, 0.5), pan: rrand(-1, 1)
    sleep 1.0/(beats_per_measure*subdivision)
  end
end

live_loop :bass_loop do
  sync :one
  current_note = :c1
  (phrase_length*subdivision).times do |i|
    if kick_A[i]
      #play current_note, amp: 0.6
      with_synth :subpulse do
        #play current_note, amp: 0.3
      end
    end
    sleep 1.0/(beats_per_measure*subdivision)
  end
end

melody_attack = 0
melody_decay = rrand(0, 0.5)
melody_sustain = rrand(0, 0.5)
melody_release = rrand(0, 0.5)
live_loop :melody_loop do
  sync :one
  with_fx :gverb do
    use_synth :fm
    #play_pattern_timed melody, 1.0/2, amp: rrand(0.1, 0.3), attack: melody_attack, decay: melody_decay, sustain: melody_sustain, release: melody_release
  end
end

puts melody
