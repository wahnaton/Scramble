import SwiftUI

struct BoxBoardView<LetterSelectionView: View>: View {

    let word: String        // must be length 5; otherwise blanks will appear
    
    /// Builder that supplies the view rendered in the centre box.
    @ViewBuilder let letterSelectionView: () -> LetterSelectionView
    
    private let boxSize: CGFloat = 65
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 10) {
                ForEach(0..<5) { idx in
                    if idx == 2 {
                        centreBox
                    } else {
                        letterBox(for: idx)
                    }
                }
            }
            
            Spacer()
        }
    }
        
    /// Box supplied by the caller.
    private var centreBox: some View {
        letterSelectionView()
            .frame(width: boxSize, height: boxSize)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.yellow, lineWidth: 5)
            )
    }
    
    /// Fixed letter box for indices other than 2.
    /// Falls back to an empty string if `word` is not five characters.
    private func letterBox(for index: Int) -> some View {
        let letter: String = {
            guard word.count == 5 else { return "" }
            let i = word.index(word.startIndex, offsetBy: index)
            return String(word[i])
        }()
        
        return Text(letter)
            .font(.largeTitle).bold()
            .frame(width: boxSize, height: boxSize)
            .foregroundStyle(Color.purple)
            .background(
                RoundedRectangle(cornerRadius: 20).fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.yellow, lineWidth: 5)
            )
    }
}

#Preview {
    BoxBoardView(word: "HELLO") {
        Text("?") // demo centre slot
            .font(.largeTitle.bold())
            .foregroundStyle(.white)
            .background(Color.purple)
    }
}
