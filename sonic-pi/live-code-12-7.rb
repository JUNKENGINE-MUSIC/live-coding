in_thread do
  loop do
    cue :tick
    sleep 0.25
  end
end

live_loop :a do
  sync :tick
  #sample :loop_perc2, beat_stretch: 4
  sleep 4
end

live_loop :bNew do
  sync :tick
  #sample :loop_amen, beat_stretch: 2
  sleep 2
end

live_loop :c do
  sync :tick
  cue :one
  sleep 4
  #sample :loop_weirdo, beat_stretch: 4
end

live_loop :d do
  sample :vinyl_hiss, beat_stretch: 4, amp: 0.0
  sleep 4
end

live_loop :e do
  sync :one
  with_fx :slicer, phase: 0.25 do
    sample :bass_thick_c, amp: 0
  end
end

a = true
live_loop :f do
  sync :one
  if a then
    with_fx :slicer, phase: 0.25 do
      #sample :loop_amen_full, beat_stretch: 8
    end
  else
    with_fx :slicer, phase: 0.125 do
      #sample :loop_amen_full, beat_stretch: 8
    end
  end
  a = ! a
end

live_loop :g do
  sync :one
  #sample :bd_haus
  sleep 2
  #sample :bd_haus
end

live_loop :haunted do
  sample :perc_bell, rate: rrand(-1.5, 1.5), amp: 0.0
  sleep rrand(0.1, 2)
end

sleep 16
sample :misc_burp