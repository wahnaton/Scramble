import SwiftUI
import GoogleMobileAds

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        MobileAds.shared.start(completionHandler: { _ in })
        return true
    }
}


@main
struct ScrambleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let request = Request()
            _ = BannerAdLoader(adUnitID: "ca-app-pub-3940256099942544/2934735716", request: request)
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
