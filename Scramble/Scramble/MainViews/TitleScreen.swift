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
    @State private var showDailyResult = false

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
                    Button(action: { showDailyResult = true }) {
                        HStack(spacing: 10) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2.weight(.bold))
                                .foregroundStyle(.white)
                            Text("View Daily Result")
                                .font(.title.bold())
                                .foregroundStyle(.white)
                        }
                        .frame(width: 300, height: 60)
                        .background(Capsule().fill(Color.blue))
                    }
                    .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 3)
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

                // (Settings and Remove Ads moved to top‑right icon buttons)
                
                Spacer()
            }
        }
        // Lightweight top‑right icons for Settings and Remove Ads
        .overlay(alignment: .topTrailing) {
            HStack(spacing: 12) {
                if adController.showAds {
                    Button {
                        Task { await purchaseManager.buyRemoveAds() }
                    } label: {
                        Image(systemName: "storefront")
                            .font(.headline.weight(.bold))
                            .foregroundStyle(Color.purple)
                            .frame(width: 36, height: 36)
                            .background(Circle().fill(Color.white))
                            .overlay(Circle().stroke(Color.yellow, lineWidth: 3))
                            .shadow(color: .black.opacity(0.2), radius: 3, y: 2)
                    }
                    .accessibilityLabel("Remove Ads")
                }

                Button { showSettings = true } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.headline.weight(.bold))
                        .foregroundStyle(Color.purple)
                        .frame(width: 36, height: 36)
                        .background(Circle().fill(Color.white))
                        .overlay(Circle().stroke(Color.yellow, lineWidth: 3))
                        .shadow(color: .black.opacity(0.2), radius: 3, y: 2)
                }
                .accessibilityLabel("Settings")
            }
            .padding(.trailing)
            .padding(.top, 8)
        }
        .fullScreenCover(isPresented: $showRules, onDismiss: { game.startRun() }) { RulesView() }
        .fullScreenCover(isPresented: $showDaily) { DailyLauncherView() }
        .sheet(isPresented: $showDailyResult) {
            let dateKey = DailyRunProvider.shared.todayKey()
            DailyResultView(dateKey: dateKey, time: DailyRunProvider.shared.loadResult())
        }
        .sheet(isPresented: $showSettings){
            SettingsSheet(showSettingsSheet: $showSettings)
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

    private func onDailyTapped() { showDaily = true }

    private var hasPlayedDailyToday: Bool {
        lastDailyRunKey == DailyRunProvider.shared.todayKey()
    }
}

#Preview {
    TitleScreen()
}
