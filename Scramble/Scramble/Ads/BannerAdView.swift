import SwiftUI
import GoogleMobileAds

struct BannerAdView: UIViewControllerRepresentable {

    private let adUnitID: String = "ca-app-pub-3940256099942544/2934735716"

    func makeUIViewController(context: Context) -> UIViewController {
        let bannerViewController = UIViewController()
        let bannerView = BannerView(adSize: AdSizeBanner)

        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = bannerViewController
        bannerView.delegate = context.coordinator

        bannerViewController.view.addSubview(bannerView)
        bannerView.load(GoogleMobileAds.Request())

        return bannerViewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, BannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            print("BannerAdView: bannerViewDidReceiveAd")
        }

        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            print("BannerAdView: didFailToReceiveAdWithError: \(error.localizedDescription)")
        }

        func bannerViewDidRecordImpression(_ bannerView: BannerView) {
            print("BannerAdView: bannerViewDidRecordImpression")
        }

        func bannerViewWillPresentScreen(_ bannerView: BannerView) {
            print("BannerAdView: bannerViewWillPresentScreen")
        }

        func bannerViewDidDismissScreen(_ bannerView: BannerView) {
            print("BannerAdView: bannerViewDidDismissScreen")
        }
    }
}
