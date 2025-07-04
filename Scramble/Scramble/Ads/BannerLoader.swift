import GoogleMobileAds

final class BannerAdLoader {
    private let banner: BannerView

    init(adUnitID: String, request: Request) {
        banner = BannerView(adSize: AdSizeBanner)
        banner.adUnitID = adUnitID
        // Do not assign rootViewController or add to any view hierarchy
        banner.load(request)
    }
}
