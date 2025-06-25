import SwiftUI

struct TitleScreen: View {
    @EnvironmentObject private var game: GameState

    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            
            VStack(spacing: 48) {
                Text("Scramble")
                    .font(.system(size: 72, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 5)
                
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
    
    private func onPlayTapped() {
        game.startRun()
    }
}

#Preview {
    TitleScreen()
}
