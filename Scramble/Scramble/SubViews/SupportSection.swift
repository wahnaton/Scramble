import SwiftUI

struct SupportSection: View {
    @ObservedObject var parentViewModel = SettingsViewModel()

    @State var showRules = false

    var body: some View {
        Section(header:
            Text("Support")
                .fontWeight(.medium)
                .foregroundStyle(Color.white)
                .shadow(radius: 4)
        ) {
            SettingsSheetButton(
                title: "Rules",
                iconName: "list.bullet.rectangle",
                action: { showRules = true },
                accessibilityIdentifier: "ImageGuidelines"
            )
            .fullScreenCover(isPresented: $showRules) {
                RulesView()
            }
            
            SettingsSheetButton(
                title: "Contact",
                iconName: "envelope",
                action: { parentViewModel.sendEmail() },
                accessibilityIdentifier: "ContactButton"
            )
            SettingsSheetButton(
                title: "Privacy",
                iconName: "lock.shield",
                action: { parentViewModel.openWebsite("https://www.playscramblegame.com/privacy") },
                accessibilityIdentifier: "PrivacyWebsite"
            )
            SettingsSheetButton(
                title: "Terms & Conditions",
                iconName: "scroll",
                action: { parentViewModel.openWebsite("https://www.playscramblegame.com/terms") },
                accessibilityIdentifier: "TermsWebsite"
            )
            
            ShareLink(item: URL(string: "https://apps.apple.com/app/XXXXXXXXXX")!) {
                SettingsButtonTextFormat(title: "Share the app", iconName: "square.and.arrow.up")
            }
        }
    }
}

#Preview {
    SettingsSheet(showSettingsSheet: .constant(true))
}
