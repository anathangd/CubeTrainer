import Foundation

struct SolveVideoTimeline {
    static let labels = ["Start solve", "Cross done", "F2L done", "OLL done", "PLL done (solved)"]
    private(set) var timestamps: [TimeInterval] = []

    var nextLabel: String? {
        timestamps.count < Self.labels.count ? Self.labels[timestamps.count] : nil
    }

    var phaseDurations: [TimeInterval]? {
        guard timestamps.count == Self.labels.count,
              let start = timestamps.first, let end = timestamps.last,
              end > start else { return nil }
        return zip(timestamps.dropFirst(), timestamps).map { end, start in end - start }
    }

    func previousTimestamp(before time: TimeInterval) -> TimeInterval? {
        guard time.isFinite else { return nil }
        return timestamps.last { $0 < time - 0.0001 }
    }

    func nextTimestamp(after time: TimeInterval) -> TimeInterval? {
        guard time.isFinite else { return nil }
        return timestamps.first { $0 > time + 0.0001 }
    }

    func canMark(at time: TimeInterval, duration: TimeInterval) -> Bool {
        nextLabel != nil && time.isFinite && duration.isFinite && duration > 0
            && time >= (timestamps.last ?? 0) && time <= duration
            && (timestamps.count != Self.labels.count - 1 || time > (timestamps.first ?? 0))
    }

    @discardableResult
    mutating func mark(at time: TimeInterval, duration: TimeInterval) -> Bool {
        guard canMark(at: time, duration: duration) else { return false }
        timestamps.append(time)
        return true
    }

    mutating func setTimestamps(_ proposedTimestamps: [TimeInterval], duration: TimeInterval) -> Bool {
        guard proposedTimestamps.count == Self.labels.count else { return false }
        var proposedTimeline = SolveVideoTimeline()
        for timestamp in proposedTimestamps {
            guard proposedTimeline.mark(at: timestamp, duration: duration) else { return false }
        }
        guard proposedTimeline.phaseDurations != nil else { return false }
        timestamps = proposedTimeline.timestamps
        return true
    }

    mutating func undo() {
        if !timestamps.isEmpty { timestamps.removeLast() }
    }
}