import SwiftUI

struct TitleScreen: View {
    @EnvironmentObject private var game: GameState

    var body: some View {
        ZStack {
            // Background
            Color.cyan.ignoresSafeArea()
            
            // Foreground content
            VStack(spacing: 48) {
                // Bubble‑style title
                Text("Scramble")
                    .font(.system(size: 72, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 5)
                
                // Play button
                Button(action: onPlayTapped) {
                    Text("Play")
                        .font(.title.bold())
                        .padding(.horizontal, 64)
                        .padding(.vertical, 22)
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2)
                        .background(
                            Capsule().fill(Color.yellow)
                        )
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 3)
                }
            }
        }
    }
    
    // MARK: - Actions
    private func onPlayTapped() {
        game.startRun()       // start the game timer
        game.completeCurrentLevel()    // jump to the first level
    }
}

#Preview {
    TitleScreen()
}
