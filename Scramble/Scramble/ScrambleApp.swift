
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
        let request = Request()
        _ = BannerAdLoader(
            adUnitID: Bundle.main.object(forInfoDictionaryKey: "GADApplicationIdentifier") as? String ?? "",
            request: request
        )
    }
}


@main
struct ScrambleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate


    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
