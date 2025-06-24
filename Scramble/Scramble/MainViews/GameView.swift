import SwiftUI

// 2. Top-level view ----------------------------------------------------------
struct GameView: View {
    @StateObject private var game = GameState()

    var body: some View {
        ZStack {
            switch game.level {
            case .title: TitleScreen().environmentObject(game)
            case .one:  VerticalMatch().environmentObject(game)
            case .finished: FinishedView().environmentObject(game)
            }
        }
        .animation(.easeInOut, value: game.level)
        .transition(.slide)
    }
}
