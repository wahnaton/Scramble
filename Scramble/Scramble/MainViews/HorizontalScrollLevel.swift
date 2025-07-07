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
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                Text("Swipe!")
                    .font(.system(size: 55))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
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

                Rectangle()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(Color.clear)
                                
                CheckLetterButton(
                    selectedWord: $selectedWord,
                    letters: letters,
                    selectedLetterIndex: $selectedLetterIndex,
                    shake: $shake
                )
                
                Spacer()
                BannerAdView()
                    .frame(height: 50)
                    .padding([.horizontal, .bottom])
            }
            .onAppear {
                selectedWord = word
                selectedLetterIndex = Int.random(in: 0..<letters.count)
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
    }
}

#Preview {
    HorizontalScrollLevel(
        letters: Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map(String.init),
        word: "APPLE"
    )
}
