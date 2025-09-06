import SwiftUI

/// Presents Rules first (if needed), then launches the DailyGameView without dismissing the cover.
struct DailyLauncherView: View {
    @AppStorage("hasSeenRules") private var hasSeenRules = false
    @State private var showGame = false

    var body: some View {
        Group {
            if showGame || hasSeenRules {
                DailyGameView()
            } else {
                RulesView(onClose: {
                    hasSeenRules = true
                    withAnimation { showGame = true }
                })
            }
        }
        .onAppear {
            if hasSeenRules { showGame = true }
        }
    }
}

