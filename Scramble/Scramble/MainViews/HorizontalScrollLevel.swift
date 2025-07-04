import SwiftUI
import AudioToolbox

struct HorizontalScrollLevel: View {
    let letters: [String]
    let word: String
    @State private var shake: Bool = false
    @State private var selectedLetterIndex: Int = 0
    @State private var selectedWord: String = ""

    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            
            VStack {
                BannerAdView()
                    .frame(height: 50)
                    .padding([.horizontal, .top])
                
                Spacer()
                
                Text("Swipe!")
                    .font(.system(size: 55, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 5)
                
                BoxBoardView(word: selectedWord) {
                    HorizontalPicker(letters: letters, selectedLetterIndex: $selectedLetterIndex)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.purple)
                            .ignoresSafeArea()
                    )
                }
                
                Spacer()

                Rectangle()
                    .frame(width: 150, height: 150)
                    .foregroundStyle(Color.clear)
                
                Spacer()
                
                CheckLetterButton(
                    selectedWord: $selectedWord,
                    letters: letters,
                    selectedLetterIndex: $selectedLetterIndex,
                    shake: $shake
                )
                
                Spacer()
            }
            .onAppear {
                selectedLetterIndex = Int.random(in: 0..<letters.count)
                selectedWord = word
            }
        }
    }
}

struct HorizontalPicker: View {
    let letters: [String]
    @Binding var selectedLetterIndex: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
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
    HorizontalScrollLevel(
        letters: Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map(String.init),
        word: "APPLE"
    )
}
