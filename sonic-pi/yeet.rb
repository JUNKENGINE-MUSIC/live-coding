sample :slow_ambient, sustain: 8, decay: 8, release: 4

use_bpm 120

in_thread do
  loop do
    stop
    cue :tick
    sleep 0.25
  end
end

use_synth :blade
use_synth_defaults attack: 2, release: 2

with_fx :reverb do
  live_loop :a do
    sync :tick
    play choose([:c1, :d1, :e1, :fs1, :gs1, :bb1]), amp: 0.0
    sleep choose([2, 4, 8])
  end
  
  with_fx :bitcrusher do
    live_loop :b do
      sync :tick
      play choose([:c3, :d3, :e3, :fs3, :gs3, :bb3]), amp: 0.0
      sleep choose([2, 4, 16])
    end
  end
  
  live_loop :c do
    sync :tick
    play choose([:c4, :d4, :e4, :fs4, :gs4, :bb4]), attack: 6, release: 6, amp: 0.0
    sleep choose([8, 16])
  end
  
  live_loop :d do
    sync :tick
    sync :one
    sample :bd_haus, amp: 0.5
    sleep 1
  end
  
  live_loop :e do
    cue :one
    with_fx :bitcrusher, sample_rate:2000 do
      sample :loop_amen, beat_stretch: 8, amp: 0.00
    end
    sleep 8
  end
  live_loop :f, sync: :one  do
    sync :tick
    sample :loop_industrial, beat_stretch: 16, amp: 0.0
    sleep 16
  end
  
  live_loop :g, sync: :one do
    sync :one
    sample :glitch_perc1, beat_stretch:2, amp: 0.0
    sample :bd_ada, amp: 0.0
    sample :bd_mehackit, amp: 0.0
  end
  
  live_loop :h, sync: :one do
    sync :tick
    sample :guit_em9, beat_stretch:16, amp:0.0
    sleep 16
  end
  
  live_loop :i, sync: :one do
    sync :one
    sample :loop_weirdo, beat_stretch:16, amp: 0.0
    sleep 16
  end
  
  live_loop :j, sync: :one do
    sync :one
    sample :ambi_choir, beat_stretch:8, amp: 0.0
    sleep 16
  end
  
  
end