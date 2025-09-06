import SwiftUI

struct CloseToMenuButton: View {
    @EnvironmentObject private var game: GameState
    // No confirmation — immediately exit to menu in all modes

    var body: some View {
        Button(action: { game.quitToTitle() }) {
            Image(systemName: "xmark")
                .font(.headline.weight(.heavy))
                .foregroundStyle(Color.purple)
                .frame(width: 44, height: 44)
                .background(Circle().fill(Color.white))
                .overlay(
                    Circle().stroke(Color.yellow, lineWidth: 3)
                )
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 3)
                .padding()
        }
        .accessibilityLabel("Back to Menu")
    }
}

#Preview {
    ZStack(alignment: .topLeading) {
        Color.cyan.ignoresSafeArea()
        CloseToMenuButton().environmentObject(GameState())
    }
}
