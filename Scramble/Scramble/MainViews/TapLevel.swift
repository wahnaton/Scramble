import SwiftUI

/// Level where the player advances the centre letter by tapping a box
struct TapLevel: View {
    let letters: [String]
    let word: String
    
    // MARK: - State
    @State private var shake: Bool = false
    @State private var isFlipping = false
    @State private var selectedLetterIndex = 0
    @State private var selectedWord: String = ""
    @EnvironmentObject private var adController: AdController
    
    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            
            VStack {
                Spacer()
                Spacer()
                Spacer()
                Spacer()

                Text("Tap the egg!")
                    .font(.system(size: 55))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 5)
                
                BoxBoardView(word: selectedWord) {
                    Text(letters[selectedLetterIndex])
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundStyle(.white)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.purple))
                }

                Image("plain")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(Color.white)
                    .shadow(color: .black.opacity(0.1), radius: 0.5)
                    .offset(y: isFlipping ? 0 : 25)
                    .onTapGesture {
                        selectedLetterIndex = (selectedLetterIndex + 1) % letters.count
                        
                        withAnimation(.easeInOut(duration: 0.1)) { isFlipping = true }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeInOut(duration: 0.1)) { isFlipping = false }
                        }
                    }
                    .sensoryFeedback(.selection, trigger: selectedLetterIndex)

                Spacer()
                
                CheckLetterButton(
                    selectedWord: $selectedWord,
                    letters: letters,
                    selectedLetterIndex: $selectedLetterIndex,
                    shake: $shake
                )
                
                Spacer()
                
                if adController.showAds {
                    BannerAdView()
                        .frame(height: 50)
                        .padding([.horizontal, .bottom])
                }
                
            }
            .onAppear {
                selectedWord = word
                selectedLetterIndex = Int.random(in: 0..<26)
            }
        }
    }
}

#Preview {
    TapLevel(
        letters: Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map(String.init),
        word: "APPLE"
    )
    .environmentObject(GameState())
}
