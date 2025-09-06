import SwiftUI

final class GameState: ObservableObject {
    enum Level: CaseIterable { case title, one, two, three, finished }
    enum Mode { case endless, daily }

    @Published var level: Level = .title
    @Published private(set) var startTime: Date?
    @Published var elapsedTime: TimeInterval = 0
    @Published var mode: Mode = .endless

    private let bestTimeKey = "bestTime"
    let highScoreStore: HighScoreStore

    init(highScoreStore: HighScoreStore = HighScoreStore()) {
        self.highScoreStore = highScoreStore
    }

    func startRun() {
        startTime = Date()
        elapsedTime = 0
        level = .one
    }
    
    /// Abandon the current run and return to the title screen.
    /// Does not record any score/time.
    func quitToTitle() {
        startTime = nil
        elapsedTime = 0
        level = .title
    }

    private func stopRun() {
        guard let start = startTime else { return }

        elapsedTime = Date().timeIntervalSince(start)
        if mode == .endless {
            highScoreStore.record(elapsedTime)
        } else if mode == .daily {
            // Mark daily run as completed once the run finishes.
            DailyRunProvider.shared.markCompletedToday()
        }
    }

    func completeCurrentLevel() {
        guard let idx = Level.allCases.firstIndex(of: level),
              idx + 1 < Level.allCases.count else { return }

        let nextLevel = Level.allCases[idx + 1]

        // If we're about to show the finished screen, stop the timer first.
        if nextLevel == .finished {
            stopRun()
        }

        level = nextLevel
    }

    func bestScore() -> TimeInterval {
        highScoreStore.highScore
    }
}
