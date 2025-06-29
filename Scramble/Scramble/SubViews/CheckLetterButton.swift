import SwiftUI

struct CheckLetterButton: View {
    @EnvironmentObject private var game: GameState
    
    @Binding var selectedWord: String
    let letters: [String]
    @Binding var selectedLetterIndex: Int
    @Binding var shake: Bool
    
    var body: some View {
        Button(action: {
            guard !selectedWord.isEmpty else { return }
            let correctLetter = String(
                selectedWord[selectedWord.index(selectedWord.startIndex, offsetBy: 2)]
            )
            if letters[selectedLetterIndex] == correctLetter {
                game.completeCurrentLevel()
            } else {
                withAnimation(.default) { shake.toggle() }
            }
        }) {
            Text("Check")
                .font(.title.bold())
                .padding(.horizontal, 64)
                .padding(.vertical, 22)
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.3), radius: 2)
                .background(
                    Capsule().fill(Color.yellow)
                )
                .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 3)
        }
        .modifier(ShakeEffect(animatableData: CGFloat(shake ? 1 : 0)))
    }
}

// MARK: - Simple shake effect
struct ShakeEffect: GeometryEffect {
    var animatableData: CGFloat
    var amplitude: CGFloat = 10
    var shakesPerUnit: Int = 3
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let translation = amplitude * sin(animatableData * .pi * CGFloat(shakesPerUnit))
        return ProjectionTransform(CGAffineTransform(translationX: translation, y: 0))
    }
}
