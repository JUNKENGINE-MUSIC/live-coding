with_fx :reverb, mix: 0.5 do
  live_loop :oceans do
    with_fx :rhpf, cutoff:rrand(0, 130) do
      s = synth [:bnoise, :cnoise, :gnoise].choose, amp: rrand(0.5, 1), attack: 0, sustain: 0.0, release: 0.2, pan: rrand(-1, 1), pan_slide: rrand(1, 5)
      control s, pan: rrand(-1, 1), cutoff: 110
      sleep rrand(0.125, 1)
    end
  end
end


#use_synth :fm
#set_sched_ahead_time! 0.005
#live_loop :midi_piano do
#  note, velocity = sync "/midi/akm320/0/1/note_on"
#  play note: note, amp: velocity / 127.0
#end
