import SwiftUI

struct VerticalMatch: View {
    @EnvironmentObject private var game: GameState
    @State private var shake: Bool = false
    @State private var selectedLetterIndex = Int.random(in: 0..<26)
    private let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map { String($0) }
    private let boxSize: CGFloat = 69
    @State private var selectedWord: String = ""
    private let wordList = ["APPLE", "BREAD", "CRISP", "DREAM", "ELITE", "FRANK", "GRACE", "HONEY", "INPUT", "JELLY"]
    @State private var matchResult: String? = nil

    var body: some View {
        Color.cyan
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Spacer()
                    HStack(spacing: 10) {
                        ForEach(0..<5) { index in
                            if index == 2 {
                                Picker("", selection: $selectedLetterIndex) {
                                    ForEach(0..<letters.count, id: \.self) { i in
                                        Text(letters[i])
                                            .font(.title2)
                                            .bold()
                                            .frame(maxWidth: 100, maxHeight: 100)
                                            .foregroundStyle(.white)
                                            .background(RoundedRectangle(cornerRadius: 5)
                                                .fill(Color.purple))
                                            .tag(i)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .frame(width: boxSize, height: boxSize)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.purple)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.yellow, lineWidth: 5)
                                )
                            } else {
                                let char = selectedWord.isEmpty ? "" : String(selectedWord[selectedWord.index(selectedWord.startIndex, offsetBy: index)])
                                Text(char)
                                    .font(.title3)
                                    .bold()
                                    .frame(width: boxSize, height: boxSize)
                                    .foregroundStyle(Color.purple)
                                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20).stroke(Color.yellow, lineWidth: 5)
                                    )
                            }
                        }
                    }
                    Button("Check Letter") {
                        guard !selectedWord.isEmpty else { return }
                        let correctLetter = String(selectedWord[selectedWord.index(selectedWord.startIndex, offsetBy: 2)])
                        if letters[selectedLetterIndex] == correctLetter {
                            matchResult = "✅ Correct!"
                            game.completeCurrentLevel()          // advance to next level
                        } else {
                            matchResult = "❌ Try again"
                            withAnimation(.default) {           // trigger shake
                                shake.toggle()
                            }
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .modifier(ShakeEffect(animatableData: CGFloat(shake ? 1 : 0)))

                    if let result = matchResult {
                        Text(result)
                            .font(.headline)
                            .foregroundStyle(.white)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .onAppear { selectedWord = wordList.randomElement() ?? "ERROR" }
            )
    
    }
}

// MARK: - Simple shake effect
struct ShakeEffect: GeometryEffect {
    /// Animates between 0 and 1 when `shake` toggles.
    var animatableData: CGFloat

    /// How far to translate on each shake (points)
    var amplitude: CGFloat = 10
    /// Number of shakes per 1.0 of `animatableData`
    var shakesPerUnit: Int = 3

    func effectValue(size: CGSize) -> ProjectionTransform {
        let translation = amplitude * sin(animatableData * .pi * CGFloat(shakesPerUnit))
        return ProjectionTransform(CGAffineTransform(translationX: translation, y: 0))
    }
}

#Preview {
    ContentView()
}
