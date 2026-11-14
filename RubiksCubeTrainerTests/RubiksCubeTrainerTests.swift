//
//  RubiksCubeTrainerTests.swift
//  RubiksCubeTrainerTests
//
//  Created by Nathan Davis on 2025-03-20.
//

import Testing
@testable import RubiksCubeTrainer

struct RubiksCubeTrainerTests {

    @Test func videoMarkersProducePhaseDurations() {
        var timeline = SolveVideoTimeline()
        for time in [3.0, 5.0, 12.0, 15.0, 19.0] {
            let marked = timeline.mark(at: time, duration: 20)
            #expect(marked)
        }
        #expect(timeline.phaseDurations == [2, 7, 3, 4])
        #expect(timeline.nextLabel == nil)
        let extraMarker = timeline.mark(at: 20, duration: 20)
        #expect(!extraMarker)
    }

    @Test func videoMarkersRejectInvalidTimesAndSupportUndoAndSkips() {
        var timeline = SolveVideoTimeline()
        let nonfiniteMarker = timeline.mark(at: -.infinity, duration: 20)
        let outOfBoundsMarker = timeline.mark(at: 21, duration: 20)
        let emptyVideoMarker = timeline.mark(at: 0, duration: 0)
        let startMarker = timeline.mark(at: 2, duration: 20)
        let backwardsMarker = timeline.mark(at: 1, duration: 20)
        #expect(!nonfiniteMarker)
        #expect(!outOfBoundsMarker)
        #expect(!emptyVideoMarker)
        #expect(startMarker)
        #expect(!backwardsMarker)
        #expect(timeline.phaseDurations == nil)
        for time in [5.0, 12.0, 12.0, 18.0] {
            let marked = timeline.mark(at: time, duration: 20)
            #expect(marked)
        }
        #expect(timeline.phaseDurations == [3, 7, 0, 6])
        timeline.undo()
        #expect(timeline.nextLabel == "PLL done (solved)")
        let replacementMarker = timeline.mark(at: 19, duration: 20)
        #expect(replacementMarker)
        #expect(timeline.phaseDurations == [3, 7, 0, 7])
    }

    @Test func videoTimestampNavigationFindsDistinctNeighboringMarkers() {
        var timeline = SolveVideoTimeline()
        #expect(timeline.previousTimestamp(before: 10) == nil)
        #expect(timeline.nextTimestamp(after: 0) == nil)
        for time in [2.0, 5.0, 12.0, 12.0, 18.0] {
            let marked = timeline.mark(at: time, duration: 20)
            #expect(marked)
        }
        #expect(timeline.previousTimestamp(before: 2) == nil)
        #expect(timeline.nextTimestamp(after: 18) == nil)
        #expect(timeline.previousTimestamp(before: 10) == 5)
        #expect(timeline.nextTimestamp(after: 10) == 12)
        #expect(timeline.previousTimestamp(before: 12) == 5)
        #expect(timeline.nextTimestamp(after: 12) == 18)
        #expect(timeline.previousTimestamp(before: 12.00001) == 5)
        #expect(timeline.nextTimestamp(after: 11.99999) == 18)
        #expect(timeline.previousTimestamp(before: 20) == 18)
        #expect(timeline.nextTimestamp(after: 0) == 2)
        #expect(timeline.nextTimestamp(after: .nan) == nil)
        #expect(timeline.previousTimestamp(before: .infinity) == nil)
    }

    @Test func videoMarkersRejectZeroLengthSolve() {
        var timeline = SolveVideoTimeline()
        for _ in 0..<4 {
            let marked = timeline.mark(at: 2, duration: 20)
            #expect(marked)
        }
        let zeroLengthMarker = timeline.mark(at: 2, duration: 20)
        #expect(!zeroLengthMarker)
    }

    @Test func speechMarkersUseStartAndFirstFourFollowingDoneCues() {
        let words = [
            SolveVideoSpeechMarkerRecognizer.Word(text: "done", time: 1),
            SolveVideoSpeechMarkerRecognizer.Word(text: "Start!", time: 2),
            SolveVideoSpeechMarkerRecognizer.Word(text: "done.", time: 5),
            SolveVideoSpeechMarkerRecognizer.Word(text: "DONE", time: 9),
            SolveVideoSpeechMarkerRecognizer.Word(text: "done,", time: 12),
            SolveVideoSpeechMarkerRecognizer.Word(text: "done", time: 15),
            SolveVideoSpeechMarkerRecognizer.Word(text: "done", time: 18),
        ]
        #expect(SolveVideoSpeechMarkerRecognizer.proposedTimestamps(from: words) == [2, 5, 9, 12, 15])
    }

    @Test func speechMarkersRequireRecognizedStartAndDoneWords() {
        let words = [
            SolveVideoSpeechMarkerRecognizer.Word(text: "begin", time: 1),
            SolveVideoSpeechMarkerRecognizer.Word(text: "done", time: 2),
            SolveVideoSpeechMarkerRecognizer.Word(text: "starting", time: 3),
        ]
        #expect(SolveVideoSpeechMarkerRecognizer.proposedTimestamps(from: words).isEmpty)
    }

    @Test func timelineAcceptsCompleteValidSpeechMarkers() {
        var timeline = SolveVideoTimeline()
        let validMarkersAccepted = timeline.setTimestamps([1, 3, 5, 7, 9], duration: 10)
        #expect(validMarkersAccepted)
        #expect(timeline.phaseDurations == [2, 2, 2, 2])
        let incompleteMarkersAccepted = timeline.setTimestamps([1, 3, 5], duration: 10)
        #expect(!incompleteMarkersAccepted)
        #expect(timeline.phaseDurations == [2, 2, 2, 2])
        let outOfRangeMarkersAccepted = timeline.setTimestamps([1, 3, 5, 7, 11], duration: 10)
        #expect(!outOfRangeMarkersAccepted)
        #expect(timeline.phaseDurations == [2, 2, 2, 2])
    }

}
