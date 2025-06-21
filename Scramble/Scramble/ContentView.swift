import SwiftUI

struct ContentView: View {
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
                                            .frame(maxWidth: .infinity)
                                            .foregroundStyle(.white)
                                            .background(RoundedRectangle(cornerRadius: 5)
                                                .fill(Color.green))
                                                .ignoresSafeArea()
                                            .tag(i)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .frame(width: boxSize, height: boxSize)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.white)
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
                                    .foregroundStyle(Color.green)
                                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20).stroke(Color.yellow, lineWidth: 5)
                                    )
                            }
                        }
                    }
                    Button("Check Letter") {
                        if selectedWord.isEmpty { return }
                        let correctLetter = String(selectedWord[selectedWord.index(selectedWord.startIndex, offsetBy: 2)])
                        if letters[selectedLetterIndex] == correctLetter {
                            matchResult = "✅ Correct!"
                        } else {
                            matchResult = "❌ Try again"
                        }
                    }
                    .buttonStyle(.borderedProminent)

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

#Preview {
    ContentView()
}
