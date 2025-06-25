import SwiftUI

final class GameState: ObservableObject {
    enum Level: CaseIterable { case title, one, finished }

    @Published var level: Level = .title
    @Published private(set) var startTime: Date?
    @Published var elapsedTime: TimeInterval = 0

    func startRun() {
        startTime = Date()
        elapsedTime = 0
        level = .one
    }
    
    private func stopRun() {
        if let start = startTime {
            elapsedTime = Date().timeIntervalSince(start)
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
}
