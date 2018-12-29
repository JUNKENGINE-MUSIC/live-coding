use_bpm 60
bass  = [1, 1, 0, 0, 1, 0, 0, 0]
snare = [0, 0, 0, 0, 1, 0, 0, 0]
hh    = [1, 0, 1, 0, 1, 0, 1, 0]
bassSample = :bd_klub
snareSample = :sn_dub
hhSample = :drum_cymbal_closed
randomSamples = [hhSample, snareSample, bassSample, :glitch_bass_g, :elec_fuzz_tom]
i = 0
count = ring(0, 1, 2, 3, 4, 5, 6, 7)
live_loop :a do
  puts(count[i])
  if bass[count[i]] == 1 then
    sample bassSample
    sample :bd_haus
    sample :bd_boom
    sample :bass_hit_c
  end
  with_fx :reverb, mix: 0.5, room: 0.75 do
    with_fx :bitcrusher, sample_rate: 10000 do
      if snare[count[i]] == 1 then
        sample snareSample
        sample :elec_lo_snare
      end
      if hh[count[i]] == 1 then
        sample hhSample
      end
      sample choose(randomSamples+[nil]*5)
      i+=1
    end
  end
  sleep 1.0/4
end

