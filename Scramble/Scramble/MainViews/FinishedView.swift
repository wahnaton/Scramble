import SwiftUI
import UniformTypeIdentifiers

private let buttonMinWidth: CGFloat = 100
private let verticalPadding: CGFloat = 14
private let shareHorizontalPadding: CGFloat = 28
private let copyHorizontalPadding: CGFloat = 24
private let playAgainHorizontalPadding: CGFloat = 64
private let playAgainVerticalPadding: CGFloat = 22
private let topPadding: CGFloat = 20
private let mainSpacing: CGFloat = 40
private let hStackSpacing: CGFloat = 24

struct FinishedView: View {
    @EnvironmentObject private var game: GameState
    @State private var isCopied = false
    
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
                    .font(.system(size: 88, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .yellow.opacity(0.9), radius: 6, x: 0, y: 3)
                VStack(spacing: verticalPadding) {
                    ForEach(Array(zip(["🏅", "🥈", "🥉"], game.highScoreStore.highScores.prefix(3))), id: \.0) { medal, score in
                        Text(String(format: "%@ %.2f", medal, score))
                            .font(.largeTitle.bold())
                            .foregroundStyle(.white.opacity(0.9))
                    }
                }
                
                HStack(spacing: hStackSpacing) {
                    ShareLink(item: shareText) {
                        Label("Share", systemImage: "square.and.arrow.up")
                            .font(.title2.bold())
                            .frame(minWidth: buttonMinWidth)
                            .padding(.horizontal, shareHorizontalPadding)
                            .padding(.vertical, verticalPadding)
                            .foregroundStyle(.white)
                            .background(
                                Capsule().fill(Color.pink)
                            )
                            .shadow(radius: 3, y: 2)
                    }
                    
                    Button {
                        UIPasteboard.general.setValue(shareText, forPasteboardType: UTType.plainText.identifier)
                        withAnimation { isCopied = true }
                        // Hide confirmation after 2 s
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation { isCopied = false }
                        }
                    } label: {
                        Label(isCopied ? "Copied!" : "Copy", systemImage: "doc.on.doc")
                            .font(.title3.bold())
                            .frame(minWidth: buttonMinWidth)
                            .padding(.horizontal, copyHorizontalPadding)
                            .padding(.vertical, verticalPadding)
                            .foregroundStyle(.white)
                            .background(
                                Capsule().fill(Color.orange)
                            )
                            .shadow(radius: 3, y: 2)
                    }
                }
                
                Button {
                    game.startRun()
                } label: {
                    Text("Play Again")
                        .font(.title.bold())
                        .padding(.horizontal, playAgainHorizontalPadding)
                        .padding(.vertical, playAgainVerticalPadding)
                        .foregroundStyle(.white)
                        .background(
                            Capsule().fill(Color.green)
                        )
                        .shadow(radius: 4, y: 3)
                }
                .padding(.top, topPadding)
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
