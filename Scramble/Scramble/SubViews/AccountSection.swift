import SwiftUI

struct AccountSection: View {
    @ObservedObject var parentViewModel = SettingsViewModel()
    @EnvironmentObject var purchaseManager: PurchaseManager

    @State var showRules = false

    var body: some View {
        Section(header:
            Text("Account")
                .fontWeight(.medium)
                .foregroundStyle(Color.white)
                .shadow(radius: 4)
        ) {
            SettingsSheetButton(
                title: "Restore Purchases",
                iconName: "arrow.clockwise",
                action: {
                    Task {
                        await purchaseManager.restorePurchases()
                    }
                },
                accessibilityIdentifier: "RestorePurchasesButton"
            )
        }
    }
}
