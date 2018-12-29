use_bpm 60
bass  = [1, 1, 0, 0, 1, 0, 0, 0]
snare = [0, 0, 0, 0, 1, 0, 0, 0]
hh    = [1, 0, 1, 0, 1, 0, 1, 0]
bassSample = :bd_klub
snareSample = :sn_dub
hhSample = :drum_cymbal_closed
randomSamples = [hhSample, snareSample, bassSample, :elec_fuzz_tom]
glitchSamples = [:glitch_perc1, :glitch_perc2, :glitch_perc3, :glitch_perc4, :glitch_perc5, :glitch_robot1, :glitch_robot2]
bitCrushSample = 8000
i = 0
count = ring(0, 1, 2, 3, 4, 5, 6, 7)
live_loop :a do
  cue :one
  for i in 0..7 do
      with_fx :reverb, mix: 0.5, room: 0.75 do
        if bass[count[i]] == 1 then
          sample bassSample
          sample :bd_haus
          sample :bd_boom
          sample :bass_hit_c
          with_fx :distortion, distort: 0.6 do
            with_fx :bitcrusher, sample_rate: bitCrushSample do
              sample :bd_haus
            end
          end
        end
        with_fx :bitcrusher, sample_rate: bitCrushSample do
          if snare[count[i]] == 1 then
            sample snareSample
            sample :elec_lo_snare
          end
          if hh[count[i]] == 1 then
            sample hhSample
          end
          sample choose(randomSamples*4+[nil]*10+glitchSamples)
          i+=1
        end
      end
      sleep 1.0/4
    end
  end
  
  