import SwiftUI

struct TitleScreen: View {
    @EnvironmentObject private var game: GameState
    @State private var showRules = false

    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            
            VStack {
                BannerAdView()
                    .frame(height: 50)
                    .padding(.horizontal)
                
                Text("Scramble")
                    .font(.system(size: 72))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 5)
                Image("triplets2")
                    .resizable()
                    .scaledToFit()

                Button(action: onPlayTapped) {
                    Text("Play")
                        .font(.title.bold())
                        .frame(width: 300, height: 75)
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2)
                        .background(
                            Capsule().fill(Color.yellow)
                        )
                }
                .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 3)
                .padding(.top)

                Button(action: { showRules = true }) {
                    Text("Rules")
                        .font(.title.bold())
                        .frame(width: 300, height: 75)
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2)
                        .background(
                            Capsule().fill(Color.purple)
                        )
                }
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 3)
                .padding(.top)
                .fullScreenCover(isPresented: $showRules) {
                    RulesView()
                }
                
                Spacer()
            }
        }
    }
    
    private func onPlayTapped() {
        game.startRun()
    }
}

#Preview {
    TitleScreen()
}
