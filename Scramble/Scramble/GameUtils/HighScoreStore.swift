import SwiftUI

final class HighScoreStore: ObservableObject {
    @AppStorage("bestTime") private var bestTime: Double = .greatestFiniteMagnitude
    
    var highScore: TimeInterval { bestTime }
    
    func record(_ runTime: TimeInterval) {
        guard runTime < bestTime else { return }
        bestTime = runTime
    }
}
