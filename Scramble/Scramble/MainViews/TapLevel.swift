import SwiftUI

/// Level where the player advances the centre letter by tapping a box
struct TapLevel: View {
    // MARK: - State
    @State private var shake: Bool = false
    @State private var isFlipping = false
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
            
            VStack(spacing: 24) {
                Spacer()
                Text("Tap!")
                    .font(.system(size: 55, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 5)
                
                BoxBoardView(word: selectedWord) {
                    Text(letters[selectedLetterIndex])
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundStyle(.white)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.purple))
                }
                
                Image(systemName: "frying.pan.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundStyle(Color.black.opacity(0.7))
                    .rotationEffect(.degrees(isFlipping ? 25 : 0), anchor: .trailing)
                    .offset(y: isFlipping ? -25 : 0)
                    .onTapGesture {
                        selectedLetterIndex = (selectedLetterIndex + 1) % letters.count
                        
                        withAnimation(.easeInOut(duration: 0.1)) { isFlipping = true }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeInOut(duration: 0.1)) { isFlipping = false }
                        }
                    }
                Spacer()

                CheckLetterButton(
                    selectedWord: $selectedWord,
                    letters: letters,
                    selectedLetterIndex: $selectedLetterIndex,
                    shake: $shake
                )
            }
            .padding(.top, 20)
            .onAppear {
                selectedWord = wordList.randomElement() ?? "ERROR"
            }
        }
    }
}

#Preview {
    TapLevel()
        .environmentObject(GameState())
}
