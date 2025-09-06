import SwiftUI

struct DailyGameView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var game = GameState()
    @State private var hasStarted = false

    private let words: [String]

    init(date: Date = Date()) {
        self.words = DailyRunProvider.shared.dailyWords(for: date)
    }

    var body: some View {
        ZStack {
            switch game.level {
            case .title:
                // Only dismiss after we've actually started the run once.
                if hasStarted {
                    Color.clear.onAppear { dismiss() }
                } else {
                    Color.clear
                }
            case .one:
                VerticalScrollLevel(letters: WordBank.letters, word: words[0]).environmentObject(game)
            case .two:
                TapLevel(letters: WordBank.letters, word: words[1]).environmentObject(game)
            case .three:
                HorizontalScrollLevel(letters: WordBank.letters, word: words[2]).environmentObject(game)
            case .finished:
                FinishedView().environmentObject(game)
            }
        }
        .animation(animationForCurrentLevel, value: game.level)
        .transition(.slide)
        .onAppear {
            game.mode = .daily
            game.startRun()
            hasStarted = true
        }
    }

    private var animationForCurrentLevel: Animation {
        switch game.level {
        case .title: return .easeIn(duration: 0.35)
        case .one: return .interactiveSpring(response: 0.6, dampingFraction: 0.75)
        case .two: return .spring(response: 0.5, dampingFraction: 0.6)
        case .three: return .linear(duration: 0.25)
        case .finished: return .easeOut(duration: 0.6)
        }
    }
}
