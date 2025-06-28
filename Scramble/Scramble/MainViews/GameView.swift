import SwiftUI

struct GameView: View {
    @StateObject private var game = GameState()

    var body: some View {
        ZStack {
            switch game.level {
            case .title: TitleScreen().environmentObject(game)
            case .one: VerticalScrollLevel().environmentObject(game)
            case .two: TapLevel().environmentObject(game)
            case .three: HorizontalScrollLevel().environmentObject(game)
            case .finished: FinishedView().environmentObject(game)
            }
        }
        .animation(animationForCurrentLevel, value: game.level)
        .transition(.slide)
    }
    /// Chooses an animation that fits the current level’s theme.
    private var animationForCurrentLevel: Animation {
        switch game.level {
        case .title:
            // A gentle fade‑in for the title screen
            return .easeIn(duration: 0.35)
        case .one:
            // Snappy spring for the vertical scrolling level
            return .interactiveSpring(response: 0.6, dampingFraction: 0.75)
        case .two:
            // A playful bouncy spring for tap interactions
            return .spring(response: 0.5, dampingFraction: 0.6)
        case .three:
            // Quick linear motion for horizontal scrolling
            return .linear(duration: 0.25)
        case .finished:
            // Smooth ease‑out for the wrap‑up screen
            return .easeOut(duration: 0.6)
        }
    }
}
