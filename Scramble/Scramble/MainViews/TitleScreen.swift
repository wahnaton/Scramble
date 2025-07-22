import SwiftUI

struct TitleScreen: View {
    @EnvironmentObject private var game: GameState
    @EnvironmentObject private var purchaseManager: PurchaseManager
    @EnvironmentObject private var adController: AdController
    @AppStorage("hasSeenRules") private var hasSeenRules = false
    @State private var showSettings = false
    @State private var showRules = false

    var body: some View {
        ZStack {
            Color.cyan.ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Scramble")
                    .font(.system(size: 72))
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 5)
                Image("nugget")
                    .resizable()
                    .frame(width: 300, height: 300)

                Button(action: onPlayTapped) {
                    Text("Play")
                        .font(.title.bold())
                        .frame(width: 300, height: 60)
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2)
                        .background(
                            Capsule().fill(Color.green)
                        )
                }
                .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 3)
                .padding(.top)

                Button(action: { showSettings = true }) {
                    Text("Settings")
                        .font(.title.bold())
                        .frame(width: 300, height: 60)
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2)
                        .background(
                            Capsule().fill(Color.orange)
                        )
                }
                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 3)
                .padding(.top)
                .sheet(isPresented: $showSettings){
                    SettingsSheet(showSettingsSheet: $showSettings)
                }
                
                if adController.showAds {
                    Button {
                        Task {
                            await purchaseManager.buyRemoveAds()
                        }
                    } label: {
                        Text("Remove Ads")
                            .font(.title.bold())
                            .frame(width: 300, height: 60)
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.3), radius: 2)
                            .background(
                                Capsule().fill(Color.purple)
                            )
                    }
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 3)
                    .padding(.top)
                }
                
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showRules, onDismiss: {
            game.startRun()
        }) {
            RulesView()
        }
    }
    
    private func onPlayTapped() {
        if !hasSeenRules {
            showRules = true
            hasSeenRules = true
        } else {
            game.startRun()
        }
    }
}

#Preview {
    TitleScreen()
}
