# Welcome to Sonic Pi v3.1

for i in 1..4 do
    sample :bd_haus
    sleep 1
  end
  
  for i in 2..4 do
      for j in 1..i**2 do
          sample :bd_haus
          sleep 1.0/i**2
        end
      end
      for i in 1..4 do
          with_fx :band_eq do
            sample :loop_industrial, beat_stretch:6
            with_fx :bitcrusher , sample_rate:20000 do
              sample :bd_haus, beat_stretch:3
              sample :loop_amen, beat_stretch: 6, amp: 1
              sleep 6
            end
          end
          
        end
        