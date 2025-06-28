import SwiftUI

struct VerticalScrollLevel: View {
    let letters: [String]
    let word: String
    @State private var shake: Bool = false
    @State private var selectedLetterIndex = Int.random(in: 0..<26)
    @State private var selectedWord: String = ""
    
    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()

            VStack {
                Spacer()
                VStack {
                    Text("Scroll!")
                        .font(.system(size: 55, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 5)
                    
                    BoxBoardView(word: selectedWord) {
                        VerticalPicker(letters: letters, selectedLetterIndex: $selectedLetterIndex)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.purple)
                                    .ignoresSafeArea()
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
            }
            .onAppear { selectedWord = word }
        }
    }
}

struct VerticalPicker: View {
    let letters: [String]
    @Binding var selectedLetterIndex: Int
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(0..<letters.count, id: \.self) { i in
                    Text(letters[i])
                        .frame(width: 65, height: 65)
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundStyle(.white)
                        .id(i)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(
            id: Binding(
                get: { selectedLetterIndex },
                set: { newValue in
                    if let v = newValue { selectedLetterIndex = v }
                }
            ),
            anchor: .center
        )
        .sensoryFeedback(.selection, trigger: selectedLetterIndex)
        .frame(width: 65, alignment: .leading)
    }
}

#Preview {
    VerticalScrollLevel(
        letters: Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map(String.init),
        word: "APPLE"
    )
}
