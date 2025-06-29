import SwiftUI
import UniformTypeIdentifiers

private let horizontalPadding: CGFloat = 64
private let verticalPadding: CGFloat = 22
private let mainSpacing: CGFloat = 40

struct FinishedView: View {
    @EnvironmentObject private var game: GameState
    
    private var formattedTime: String {
        String(format: "%.2f s", game.elapsedTime)
    }
    
    private var shareText: String {
        "I finished Scramble in \(formattedTime)! Can you beat me? #ScrambleApp 🐣"
    }
    
    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            
            Spacer()
            
            VStack(spacing: mainSpacing) {
                Text("Scramble")
                    .font(.system(size: 72, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 5)
                
                Text(formattedTime)
                    .font(.system(size: 72, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .yellow.opacity(0.9), radius: 6, x: 0, y: 3)
                
                VStack(spacing: verticalPadding) {
                    ForEach(Array(zip(["🥇", "🥈", "🥉"], game.highScoreStore.highScores.prefix(3))), id: \.0) { medal, score in
                        Text(String(format: "%@ %.2f", medal, score))
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white.opacity(0.9))
                    }
                }
                
                ShareLink(item: shareText) {
                    Label("Share", systemImage: "square.and.arrow.up")
                        .font(.title.bold())
                        .padding(.horizontal, horizontalPadding)
                        .padding(.vertical, verticalPadding)
                        .foregroundStyle(.white)
                        .background(
                            Capsule().fill(Color.orange)
                        )
                        .shadow(radius: 4, y: 3)
                }
                
                Button {
                    game.startRun()
                } label: {
                    Text("Play Again")
                        .font(.title.bold())
                        .padding(.horizontal, horizontalPadding)
                        .padding(.vertical, verticalPadding)
                        .foregroundStyle(.white)
                        .background(
                            Capsule().fill(Color.green)
                        )
                        .shadow(radius: 4, y: 3)
                }
            }
        }
    }
}

#Preview {
    let gs = GameState()
    gs.elapsedTime = 42.7
    return FinishedView()
        .environmentObject(gs)
}
