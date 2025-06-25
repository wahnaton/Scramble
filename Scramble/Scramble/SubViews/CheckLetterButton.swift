import SwiftUI

struct CheckLetterButton: View {
    @EnvironmentObject private var game: GameState
    
    @Binding var selectedWord: String
    let letters: [String]
    @Binding var selectedLetterIndex: Int
    @Binding var shake: Bool
    
    var body: some View {
        Button("Check Letter") {
            guard !selectedWord.isEmpty else { return }
            let correctLetter = String(
                selectedWord[selectedWord.index(selectedWord.startIndex, offsetBy: 2)]
            )
            if letters[selectedLetterIndex] == correctLetter {
                game.completeCurrentLevel()
            } else {
                withAnimation(.default) { shake.toggle() }
            }
        }
        .buttonStyle(.borderedProminent)
        .modifier(ShakeEffect(animatableData: CGFloat(shake ? 1 : 0)))
    }
}
