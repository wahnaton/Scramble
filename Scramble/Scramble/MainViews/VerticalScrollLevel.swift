import SwiftUI

struct VerticalScrollLevel: View {
    @State private var shake: Bool = false
    @State private var selectedLetterIndex = Int.random(in: 0..<26)
    @State private var selectedWord: String = ""
    
    private let letters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map(String.init)
    private let wordList = [
        "APPLE", "BREAD", "CRISP", "DREAM", "ELITE",
        "FRANK", "GRACE", "HONEY", "INPUT", "JELLY"
    ]
    
    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()

            VStack {
                BoxBoardView(word: selectedWord) {
                    Picker("", selection: $selectedLetterIndex) {
                        ForEach(0..<letters.count, id: \.self) { i in
                            Text(letters[i])
                                .font(.title)
                                .bold()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .foregroundStyle(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.purple)
                                )
                                .tag(i)
                        }
                    }
                    .pickerStyle(.wheel)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.purple)
                    )
                }
                
                CheckLetterButton(
                    selectedWord: $selectedWord,
                    letters: letters,
                    selectedLetterIndex: $selectedLetterIndex,
                    shake: $shake
                )
                .padding(.top, 20)
            }
            .onAppear { selectedWord = wordList.randomElement() ?? "ERROR" }
        }
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

#Preview {
    VerticalScrollLevel()
}
