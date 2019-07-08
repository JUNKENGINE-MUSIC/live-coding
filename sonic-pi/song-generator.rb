t = Time.now.to_i
use_random_seed t
beats_per_measure = choose([4, 8])
# 4 = 16th notes, 3 might be triplets, 2 is 8th
subdivision = choose([1, 2, 3, 4])
tempo = rrand(30, 180)
use_bpm tempo
bass_synth = choose([:blade, :dark_ambience, :dsaw, :fm, :mod_saw, :subpulse, :tb303])
key = choose([:c, :cs, :d, :eb, :e, :f, :fs, :g, :ab, :a, :bb, :b])
mode = choose([:major_pentatonic, :minor_pentatonic])
BassDrumSamples = [:bd_ada, :bd_pure, :bd_808, :bd_zum, :bd_gas, :bd_sone, :bd_haus, :bd_zome, :bd_boom, :bd_klub, :bd_fat, :bd_tek, :bd_mehackit, :drum_heavy_kick, :drum_bass_soft, :drum_bass_hard, :elec_soft_kick, :elec_hollow_kick]
SnareDrumSamples =[:sn_dub, :sn_dolf, :sn_zome, :sn_generic, :drum_snare_hard, :drum_snare_soft, :elec_snare, :elec_lo_snare, :elec_hi_snare, :elec_mid_snare, :elec_filt_snare]
MidDrumSamples = [:drum_tom_mid_soft, :drum_tom_mid_hard, :drum_tom_lo_soft, :drum_tom_lo_hard, :drum_tom_hi_soft, :drum_tom_hi_hard, :drum_cowbell, :elec_fuzz_tom, :elec_bong, :elec_twang, :elec_wood, :elec_bell, :elec_flip, :elec_tick, :elec_plip]
HighDrumSamples = [:elec_triangle, :elec_pop, :elec_beep, :elec_blip, :elec_blip2, :elec_ping, :elec_twip, :elec_blup]
CrashDrumSamples = [:drum_splash_soft, :drum_splash_hard, :drum_cymbal_soft, :drum_cymbal_hard, :elec_cymbal, :elec_chime]
HHDrumSamples = [:drum_cymbal_closed, :drum_cymbal_pedal]

# todo: sort glitchy, mehackit, misc, percussive, tabla

define :make_kick do |beats|
  drum_bass = choose(BassDrumSamples)
  result = []
  beats *= subdivision
  beats.times do |i|
    result.push(choose([drum_bass]+[nil]*i))
  end
  return result
end

define :make_snare do |beats|
  drum_snare = choose(SnareDrumSamples)
  result = []
  beats *= subdivision
  beats.times do |i|
    result.push(choose([drum_snare]+[nil]*(i-beats/2).abs))
  end
  return result
end

define :make_hh do |beats|
  drum_hh = choose(HHDrumSamples)
  result = []
  beats *= subdivision
  beats.times do |i|
    result.push(choose(HHDrumSamples+HighDrumSamples+[nil]*4))
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

kick_list = []
snare_list = []
hh_list = []
melody_list = []

sections = rrand_i(2, 6)

sections.times do |i|
  kick_list.push(make_kick(phrase_length))
  snare_list.push(make_snare(phrase_length))
  hh_list.push(make_hh(phrase_length))
  melody_list.push(make_melody(phrase_length))
end

song = []

rrand_i(32, 128).times do |i|
  song.push(rrand_i(0, sections-1))
end

live_loop :drum_loop do
  # todo: correct to drum and bass
  with_fx :reverb do
    song.each do |sect|
      kick = kick_list[sect]
      snare = snare_list[sect]
      hh = hh_list[sect]
      cue :one
      (phrase_length*subdivision).times do |i|
        sample kick[i], pan: rrand(-1, 1)
        sample snare[i], amp: rrand(0.3, 0.7), pan: rrand(-1, 1)
        sample hh[i], amp: rrand(0, 0.5), pan: rrand(-1, 1)
        
        # bass
        if kick[i]
          current_note = choose(scale(note(key, octave: 1), mode))
          with_synth :sine do
            play current_note, amp: 0.6, release: 1.0/(beats_per_measure*subdivision)*1.0
          end
          with_synth bass_synth do
            play current_note, amp: 0.2, release: 1.0/(beats_per_measure*subdivision)*1.0
          end
        end
        sleep 1.0/(beats_per_measure*subdivision)
      end
    end
  end
  puts song
  puts sections
  stop
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

