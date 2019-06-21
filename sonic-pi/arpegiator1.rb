use_bpm 30

glitch_sounds = [:glitch_perc1, :glitch_perc2, :glitch_perc3, :glitch_perc4, :glitch_perc5, :glitch_robot1, :glitch_robot2]
live_loop :a do
  with_fx :bitcrusher, sample_rate: 4000 do
    sync :one
    #sample :bd_mehackit, amp: rrand(0.5, 0.7)
    sleep 0.25
    #sample :drum_splash_soft
    sleep 0.25
    #sample :sn_dub, amp: rrand(0.3, 0.7)
    sleep 0.25
    sleep 0.25
  end
end
live_loop :drone do
  cue :one
  with_synth :subpulse do
    #play :c2, cutoff:90, amp: 0.2, release: 0.9, decay: 0.9
  end
  sleep 1
end

live_loop :b do
  #with_fx :octaver, super_amp: 0 do
  #sample :bd_fat, amp: 1, pan: -1
  #end
  sleep 1.0/12
end

live_loop :c do
  #sample :bd_fat, amp: 1, pan: 1
  sleep 1.0/7
end

live_loop :d do
  with_fx :gverb, amp: 0.6 do
    with_fx :bitcrusher, sample_rate: rrand_i(100, 10000) do
      #sample choose(glitch_sounds+[nil]*60), amp: rrand(0.2, 0.5)
      sleep 1.0/4
    end
  end
end

live_loop :e do
  sync :one
  with_synth :growl do
    with_fx :gverb do
      with_fx :echo do
        #play choose(chord(:c3, :M7, num_octaves: 4)), attack: rrand(1, 2), release: rrand(1, 2), pan: rrand(-1, 1), amp: rrand(0.1, 0.1)
        #synth :dull_bell, note: choose(scale(:c3, :whole_tone, num_octaves: 4)), amp: 0.1
        sleep 8
      end
    end
  end
end

live_loop :f do
  with_synth :fm do
    with_fx :reverb do
      with_fx :echo, phase: 0.1875 do
        with_fx :tanh, krunch: rrand(0, 10), krunch_slide:1 do
          #play choose(scale(:c2, :major_pentatonic, num_octaves: 3)), release: 0.125, amp: rrand(0.1, 0.3), divisor: 2, pan: rrand(-1, 1)
        end
      end
      #synth :gnoise, release: 0.125, cutoff: rrand(60, 131), amp: rrand(0.1, 0.2)
      #sample :drum_cymbal_closed, amp: 0.2
    end
  end
  sleep 0.125
end

live_loop :g do
  #with_fx :slicer do
  sync :one
  #sample :loop_safari, beat_stretch: 4, amp: 1
  #sample :loop_industrial, beat_stretch: 2
  #sample :loop_drone_g_97, beat_stretch: 2
  sleep 2
  #sample :loop_tabla, beat_stretch: 2
  #sample :loop_electric, beat_stretch: 2
  sleep 2
  #end
end
