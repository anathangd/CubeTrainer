# CubeTrainer (iOS)

CubeTrainer is an iOS app designed to help practice and internalize Rubik’s Cube
algorithms, with a focus on CFOP-style solving and deliberate, repeatable training.

This project grew out of my own practice needs and evolved over time as I
experimented with different ways to reinforce pattern recognition and muscle
memory.

## Features
- Algorithm categorization and flash carding
- F2L videos with buttons to drill them from every angle
- Solve timing and step breakdowns
- Record solves and mark CFOP splits from video
- Save times and track improvement
- Full OLL, Full PLL
- OLL and PLL recognition
- Export and import saved data

## Video Step Timing
Open Camera in the step timer on an iPhone or iPad, record a solve, then accept
the recording. Play the video or scrub the timeline, using the frame buttons for
fine adjustments. Mark Start solve, Cross done, F2L done, OLL done, and PLL done
(solved) in order. Undo Marker removes the last mark; tapping a timestamp seeks
back to it. Equal timestamps are allowed for skipped phases.

Auto-Mark From Audio transcribes the recording and looks for the first spoken
"start" followed by four "done" cues. Review the suggested timestamps before
using them; if a cue is missing or out of order, add the markers manually.
The first attempt asks permission to send audio to Apple for speech recognition;
that choice is remembered on the device. If Apple recognition misses cues, retry
with on-device recognition instead. Speech recognition permission is required.

Export Video opens the system share sheet for saving or sharing the original
recording. Use Times transfers the calculated phase durations to the timer's
result screen, where you can add a memo and tap Save Time to log the solve.
Recordings and markers are temporary, so export before leaving review or using
the times if you want to keep the video. Camera and microphone access are
required; recording is unavailable in the simulator.

## Motivation
Most cube training tools focus either on raw speed or static algorithm lists.
This app explores a more practice-oriented approach, emphasizing repetition,
recognition, and gradual improvement.

## Tech
- Swift
- SwiftUI
- Xcode
- AVFoundation (for video playback)
- HTML, CSS, Javascript (for interactive video playback)

## Status
Personal project. Actively iterated on over time and shared here as a snapshot
of that work rather than a polished commercial product.