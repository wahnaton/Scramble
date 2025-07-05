import SwiftUI

struct RulesView: View {
    /// Game rules displayed to the user.
    private let rules: [String] = [
        "Build words using different actions!",
        "Tap \"Check\" to see if you guessed correctly",
        "Level 1: Scroll the middle (purple) box up or down to pick a letter",
        "Level 2: Tap the egg to pick a  etter",
        "Level 3: Swipe the middle (purple) box left or right to pick a letter",
        "Finish as fast as you can!"
    ]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            VStack {
                Spacer()
                Text("How to Play")
                    .font(.largeTitle.bold())
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(rules, id: \.self) { rule in
                        HStack(alignment: .center) {
                            Text("•")
                                .font(.largeTitle)
                                .foregroundStyle(.yellow)
                                .accessibilityHidden(true)

                            Text(rule)
                                .font(.title3.weight(.medium))
                                .fontDesign(.rounded)
                                .foregroundStyle(.white)
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
                        }
                        .accessibilityElement(children: .combine)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
                                
                Button("Close") {
                    dismiss()
                }
                .font(.title2.bold())
                .frame(width: 150, height: 60)
                .foregroundStyle(.white)
                .background(Capsule().fill(Color.purple))
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 3)
                .padding(.top)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    RulesView()
}
