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
                Spacer()
                Text("Scroll!")
                    .font(.system(size: 55, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 5)
                
                BoxBoardView(word: selectedWord) {
                    Picker("", selection: $selectedLetterIndex) {
                        ForEach(0..<letters.count, id: \.self) { i in
                            Text(letters[i])
                                .font(.largeTitle)
                                .bold()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .foregroundStyle(.white)
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
                Spacer()
            }
            .onAppear { selectedWord = wordList.randomElement() ?? "ERROR" }
        }
    }
}

#Preview {
    VerticalScrollLevel()
}
