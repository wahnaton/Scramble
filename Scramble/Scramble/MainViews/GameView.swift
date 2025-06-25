import SwiftUI

struct GameView: View {
    @StateObject private var game = GameState()

    var body: some View {
        ZStack {
            switch game.level {
            case .title: TitleScreen().environmentObject(game)
            case .one:  VerticalScrollLevel().environmentObject(game)
            case .finished: FinishedView().environmentObject(game)
            }
        }
        .animation(.easeInOut, value: game.level)
        .transition(.slide)
    }
}
