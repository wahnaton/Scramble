import SwiftUI

struct TitleScreen: View {
    @EnvironmentObject private var game: GameState
    @EnvironmentObject private var purchaseManager: PurchaseManager
    @EnvironmentObject private var adController: AdController
    @AppStorage("hasSeenRules") private var hasSeenRules = false
    @AppStorage("daily_last_started_key") private var lastDailyRunKey = ""
    @State private var showSettings = false
    @State private var showRules = false
    @State private var showDaily = false

    // No pending action routing needed; endless rules auto-start the game

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

                if hasPlayedDailyToday {
                    Button(action: {}) {
                        Text("Daily Complete")
                            .font(.title.bold())
                            .frame(width: 300, height: 60)
                            .foregroundStyle(.white.opacity(0.7))
                            .background(
                                Capsule().fill(Color.gray.opacity(0.6))
                            )
                    }
                    .disabled(true)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                    .padding(.top, 8)
                } else {
                    Button(action: onDailyTapped) {
                        Text("Daily Run")
                            .font(.title.bold())
                            .frame(width: 300, height: 60)
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.3), radius: 2)
                            .background(
                                Capsule().fill(Color.blue)
                            )
                    }
                    .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 3)
                    .padding(.top, 8)
                }

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
        .fullScreenCover(isPresented: $showRules, onDismiss: { game.startRun() }) { RulesView() }
        .fullScreenCover(isPresented: $showDaily) { DailyLauncherView() }
    }
    
    private func onPlayTapped() {
        if !hasSeenRules {
            showRules = true
            hasSeenRules = true
        } else {
            game.startRun()
        }
    }

    private func onDailyTapped() { showDaily = true }

    private var hasPlayedDailyToday: Bool {
        lastDailyRunKey == DailyRunProvider.shared.todayKey()
    }
}

#Preview {
    TitleScreen()
}
