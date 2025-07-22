import StoreKit
import UIKit

@MainActor
struct RatingRequester {
    private static let firstLaunchKey = "firstLaunchDate"
    private static let sessionCountKey = "sessionCount"
    private static let eventsKey = "significantEvents"
    private static let lastPromptedVersionKey = "lastPromptedVersion"

    static var firstLaunchDate: Date {
        if let d = UserDefaults.standard.object(forKey: firstLaunchKey) as? Date {
            return d
        }
        let now = Date()
        UserDefaults.standard.set(now, forKey: firstLaunchKey)
        return now
    }

    static var sessions: Int {
        get { UserDefaults.standard.integer(forKey: sessionCountKey) }
        set { UserDefaults.standard.set(newValue, forKey: sessionCountKey) }
    }

    static var events: Int {
        get { UserDefaults.standard.integer(forKey: eventsKey) }
        set { UserDefaults.standard.set(newValue, forKey: eventsKey) }
    }

    static var lastPromptedVersion: String? {
        get { UserDefaults.standard.string(forKey: lastPromptedVersionKey) }
        set { UserDefaults.standard.set(newValue, forKey: lastPromptedVersionKey) }
    }

    static func incrementSession() {
        sessions += 1
    }

    static func recordEvent() {
        events += 1
    }

    static var shouldRequestRating: Bool {
        let daysSinceLaunch = Date().timeIntervalSince(firstLaunchDate) / 86400
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String

        return daysSinceLaunch >= 7 &&
               sessions >= 3 &&
               events >= 5 &&
               lastPromptedVersion != currentVersion
    }

    static func requestRatingIfNeeded() {
        guard shouldRequestRating else { return }
        lastPromptedVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        if let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive }) {
            AppStore.requestReview(in: windowScene)
        }
    }
}
