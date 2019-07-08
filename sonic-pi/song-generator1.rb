t = Time.now.to_i
use_random_seed t
beats_per_measure = choose([4, 8])
hdir = "C:\\Users\\Chris Palmer\\Desktop\\all-samples\\french-horn"
cdir = "C:\\Users\\Chris Palmer\\Desktop\\all-samples\\cello"
#hdir = "C:\\Users\\Chris Palmer\\Desktop\\all-samples\\saxophone"
#cdir = "C:\\Users\\Chris Palmer\\Desktop\\all-samples\\bassoon"
fdir = "C:\\Users\\Chris Palmer\\Desktop\\all-samples\\clarinet"
# 4 = 16th notes, 3 might be triplets, 2 is 8th
subdivision = choose([1, 2, 3, 4])
max_tempo = 70.0
tempo = rrand(10, max_tempo)
use_bpm tempo
chord_voice = choose([:dark_ambience, :dtri, :dull_bell, :fm, :growl, :piano, :pluck, :prophet, :supersaw, :tech_saws, :zawa])
bass_synth = choose([:dsaw, :fm, :mod_saw, :subpulse, :tb303])
key = choose([:c, :cs, :d, :eb, :e, :f, :fs, :g, :ab, :a, :bb, :b])
mode = choose([:major, :minor])

BassDrumSamples = [:bd_ada, :bd_pure, :bd_808, :bd_zum, :bd_gas, :bd_sone, :bd_haus, :bd_zome, :bd_boom, :bd_klub, :bd_fat, :bd_tek, :bd_mehackit, :drum_heavy_kick, :drum_bass_soft, :drum_bass_hard, :elec_soft_kick, :elec_hollow_kick]
SnareDrumSamples =[:sn_dub, :sn_dolf, :sn_zome, :sn_generic, :drum_snare_hard, :drum_snare_soft, :elec_snare, :elec_lo_snare, :elec_hi_snare, :elec_mid_snare, :elec_filt_snare]
MidDrumSamples = [:drum_tom_mid_soft, :drum_tom_mid_hard, :drum_tom_lo_soft, :drum_tom_lo_hard, :drum_tom_hi_soft, :drum_tom_hi_hard, :drum_cowbell, :elec_fuzz_tom, :elec_bong, :elec_twang, :elec_wood, :elec_bell, :elec_flip, :elec_tick, :elec_plip]
HighDrumSamples = [:elec_triangle, :elec_pop, :elec_beep, :elec_blip, :elec_blip2, :elec_ping, :elec_twip, :elec_blup]
CrashDrumSamples = [:drum_splash_soft, :drum_splash_hard, :drum_cymbal_soft, :drum_cymbal_hard, :elec_cymbal, :elec_chime]
HHDrumSamples = [:drum_cymbal_closed, :drum_cymbal_pedal]

# todo: sort glitchy, mehackit, misc, percussive, tabla
ampMultiplier = 5.0

define :make_kick do |beats|
  drum_bass = choose(BassDrumSamples)
  result = []
  beats *= subdivision
  beats.times do |i|
    #result.push(choose([drum_bass]+[nil]*i))
    result.push(choose([[cdir, rrand_i(0, 10000)]]+[nil]*i))
  end
  return result
end

define :make_snare do |beats|
  drum_snare = choose(SnareDrumSamples)
  result = []
  beats *= subdivision
  beats.times do |i|
    #result.push(choose([drum_snare]+[nil]*(i-beats/2).abs))
    result.push(choose([[hdir, rrand_i(0, 10000)]]+[nil]*(i-beats/2).abs))
  end
  return result
end

define :make_hh do |beats|
  drum_hh = choose(HHDrumSamples)
  result = []
  beats *= subdivision
  beats.times do |i|
    #result.push(choose(HHDrumSamples+HighDrumSamples+[nil]*4))
    result.push(choose([[fdir, rrand_i(0, 10000)]]*4+[nil]*4))
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

define :make_chords do |phrase_length|
  chord_probabilities = [1]*25 + [2]*8 + [3]*5 + [4]*25 + [5]*25 + [6]*10 + [7]*2
  return chord_degree choose(chord_probabilities), key, mode, rrand_i(3, 5)
end


phrase_length = 8
repeat_number = tempo > max_tempo/2.0 ? tempo > max_tempo*0.75 ? 16 : 8 : 4

kick_list = []
snare_list = []
hh_list = []
melody_list = []
chord_list = []

sections = rrand_i(2, 6)

sections = 3
sections.times do |i|
  kick_list.push(make_kick(phrase_length))
  snare_list.push(make_snare(phrase_length))
  hh_list.push(make_hh(phrase_length))
  melody_list.push(make_melody(phrase_length))
  chord_list.push(make_chords(repeat_number))
end

song = []

rrand_i(32, 64).times do |i|
  song += [rrand_i(0, sections-1)] * repeat_number
end

song = [0]*2*repeat_number + [1]*repeat_number + [0]*2*repeat_number + [1]*repeat_number + [2]*repeat_number + [1]*2*repeat_number

puts tempo
puts subdivision
puts beats_per_measure
puts key
puts mode

bass_amp = rrand(0.0, tempo/max_tempo)

live_loop :drum_loop do
  # todo: correct to drum and bass
  with_fx :reverb, mix: 0.7 do
    song.each do |sect|
      kick = kick_list[sect]
      snare = snare_list[sect]
      hh = hh_list[sect]
      cue :one, sect: sect
      (phrase_length*subdivision).times do |i|
        if not rest? kick[i]
          #sample kick[i], amp: tempo/max_tempo*ampMultiplier, pan: rrand(-1, 1)
          sample kick[i], amp: rrand(0.1, (tempo/max_tempo))*ampMultiplier, pan: rrand(-1, 1)
        end
        if not rest? snare[i]
          #sample snare[i], amp: rrand((tempo/max_tempo)*0.3*ampMultiplier, (tempo/max_tempo)*0.5), pan: rrand(-1, 1)
          sample snare[i], amp: rrand(0.1, (tempo/max_tempo))*ampMultiplier, pan: rrand(-1, 1)
        end
        if not rest? hh[i]
          #sample hh[i], amp: rrand(0, (tempo/max_tempo)*0.4)*ampMultiplier, pan: rrand(-1, 1)
          sample hh[i], amp: rrand(0.1, (tempo/max_tempo))*ampMultiplier, pan: rrand(-1, 1)
        end
        # bass
        if kick[i]
          current_note = choose(chord_list[sect])
          with_octave -3 do
            with_synth :sine do
              #play current_note, amp: tempo/100.0, release: 1.0/(beats_per_measure*subdivision)*1.0
            end
          end
          with_octave -2 do
            with_synth bass_synth do
              #play current_note, amp: bass_amp, release: 1.0/(beats_per_measure*subdivision)*1.0
            end
          end
        end
        sleep 1.0/(beats_per_measure*subdivision)
      end
    end
  end
  stop
end

melody_attack = 0
melody_decay = rrand(0, 0.5)
melody_sustain = rrand(0, 0.5)
melody_release = rrand(0, 0.5)

chord_attk = rrand(0, 1)
chord_amp = rrand(0.0, ((max_tempo-tempo)/max_tempo))
puts "chord_amp"
puts chord_amp
puts chord_voice
chord_cutoff = rrand(80, 130)
chord_sustain = 1
live_loop :chord_loop do
  #puts chord_voice
  with_fx :reverb do
    with_synth chord_voice do
      values = sync :one
      #puts chord_list[values[:sect]]
      with_octave choose([-1, 0]) do
        #play chord_invert(chord_list[values[:sect]], rrand_i(0, 3)), attack: chord_attk, amp: chord_amp, cutoff: chord_cutoff, sustain: chord_sustain
      end
    end
  end
end

melody_scale = scale(key, mode, num_octaves: 2)
current_note = rrand_i(0, melody_scale.length-1)
"
live_loop :melody_loop do
  stop
  values = sync :one
  puts chord_list[values[:sect]]
  target_note = choose(chord_list[values[:sect]])
  melody_note_list = []
  melody_rhythm_list = []
  remaining_measure = beats_per_measure
  (phrase_length*subdivision).times do |i|
    note_length = choose([1, 1.0/subdivision, 1.0/(subdivision*2), 1.0/(subdivision*4), 1.0/(subdivision*8)])
                  if target_note > melody_scale[current_note]
                    current_note += choose([1, 2])
                  elsif target_note < melody_scale[current_note]
                    current_note -= choose([1, 2])
                  else
                    current_note += choose([-2, -1, 0, 1, 2])
                  end
                  
                  if remaining_measure > note_length
                    melody_note_list.push(melody_scale[current_note])
                    melody_rhythm_list.push(note_length)
                  else
                    melody_note_list.push(melody_scale[current_note])
                    melody_rhythm_list.push(remaining_measure)
                  end
                  end
                  #puts melody_note_list
                  #puts melody_rhythm_list
                  
                  (phrase_length*subdivision).times do |i|
                    with_synth :fm do
                      #play melody_note_list[i], sustain: melody_rhythm_list[i]*0.9, attack: rrand(0.0, 0.2), amp: rrand(0.4, 0.6)
                    end
                    sleep melody_rhythm_list[i]
                  end
                  end
                  end
                  
                  "

