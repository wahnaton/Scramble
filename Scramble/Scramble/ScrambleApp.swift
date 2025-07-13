import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        
        MobileAds.shared.start()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            ATTrackingManager.requestTrackingAuthorization { _ in
                self.loadBannerAd()
            }
        }

        return true
    }

    private func loadBannerAd() {
        DispatchQueue.main.async {
            let request = Request()
            _ = BannerAdLoader(
                adUnitID: Bundle.main.object(forInfoDictionaryKey: "GADApplicationIdentifier") as? String ?? "",
                request: request
            )
        }
    }
}


@main
struct ScrambleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject private var purchaseManager: PurchaseManager
    @StateObject private var adController: AdController

    init() {
        let manager = PurchaseManager()
        _purchaseManager = StateObject(wrappedValue: manager)
        _adController = StateObject(wrappedValue: AdController(purchaseManager: manager))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(purchaseManager)
                .environmentObject(adController)
        }
    }
}
