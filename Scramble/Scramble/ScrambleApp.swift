import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        MobileAds.shared.start(completionHandler: { _ in })

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { _ in
                    self.loadBannerAd()
                }
            } else {
                self.loadBannerAd()
            }
        }

        return true
    }

    private func loadBannerAd() {
        let request = Request()
        _ = BannerAdLoader(
            adUnitID: "ca-app-pub-3940256099942544/2934735716",
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
