import SwiftUI

final class HighScoreStore: ObservableObject {
    /// CSV‑encoded list of the three best (lowest) times, oldest format‑agnostic.
    @AppStorage("topTimes") private var topTimesCSV: String = ""

    /// Parsed top‑three times, sorted ascending (best first).
    private var topTimes: [Double] {
        get { topTimesCSV.split(separator: ",").compactMap { Double($0) } }
        set { topTimesCSV = newValue.map { String($0) }.joined(separator: ",") }
    }

    var highScore: TimeInterval { topTimes.first ?? .greatestFiniteMagnitude }
    var highScores: [TimeInterval] { topTimes }

    func record(_ runTime: TimeInterval) {
        var times = topTimes
        times.append(runTime)
        times.sort()
        if times.count > 3 { times = Array(times.prefix(3)) }
        topTimes = times
    }
}
