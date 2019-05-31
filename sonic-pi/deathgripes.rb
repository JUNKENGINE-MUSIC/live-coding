use_bpm 30

glitch_sounds = [:glitch_perc1, :glitch_perc2, :glitch_perc3, :glitch_perc4, :glitch_perc5, :glitch_robot1, :glitch_robot2]
live_loop :a do
  with_fx :bitcrusher, sample_rate: 4000 do
    #sample :bd_mehackit
    sleep 0.5
    #sample :sn_dub
    sleep 0.5
  end
end

live_loop :b do
  #with_fx :octaver, super_amp: 0 do
  #sample :tabla_ghe4, amp: 1
  #end
  sleep 1.0/12
end

live_loop :c do
  #sample :tabla_ghe8, amp: 1
  sleep 1.0/7
end

live_loop :d do
  with_fx :gverb, amp: 0.6 do
    with_fx :bitcrusher, sample_rate: rrand_i(100, 10000) do
      #sample choose(glitch_sounds+[nil]*60), amp: 1
      sleep 1.0/10
    end
  end
end

live_loop :e do
  with_synth :growl do
    with_fx :gverb do
      with_fx :echo do
        
        #play choose(scale(:c2, :whole_tone, num_octaves: 4)), attack: rrand(1, 6), release: rrand(1, 8), pan: rrand(-1, 1)
        #synth :dull_bell, note: choose(scale(:c3, :whole_tone, num_octaves: 4))
        sleep rrand(1, 4)
      end
    end
  end
end

live_loop :f do
  with_synth :fm do
    with_fx :reverb do
      with_fx :echo, phase: 0.1875 do
        with_fx :tanh, krunch: rrand(0, 10), krunch_slide:1 do
          play choose(scale(:c2, :minor_pentatonic, num_octaves: 3)), release: 0.125, amp: 0.7, divisor: 2, pan: rrand(-1, 1)
        end
      end
      synth :gnoise, amp: 0.3, release: 0.125, cutoff: rrand(60, 131)
    end
  end
  sleep 0.125
end

live_loop :g do
  stop
  #with_fx :slicer do
  
  sample :loop_safari, beat_stretch: 4, amp: 1
  sample :loop_industrial, beat_stretch: 2
  sample :loop_drone_g_97, beat_stretch: 2
  sleep 2
  sample :loop_tabla, beat_stretch: 2
  sample :loop_electric, beat_stretch: 2
  sleep 2
  #end
end

