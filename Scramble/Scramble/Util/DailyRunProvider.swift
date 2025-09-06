import Foundation
import CryptoKit

/// Provides deterministic daily content and basic one-run-per-day gating.
struct DailyRunProvider {
    static let shared = DailyRunProvider()

    // TODO: In the future, fetch this from a backend so users cannot precompute.
    private let staticSalt = "9B0F7F7A-DA12-4D8C-9F0E-8D8E0DAILY-SALT-PLACEHOLDER"

    private let playedKey = "daily_last_started_key"

    func todayKey(date: Date = Date()) -> String {
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let y = comps.year ?? 1970
        let m = comps.month ?? 1
        let d = comps.day ?? 1
        return String(format: "%04d-%02d-%02d", y, m, d)
    }

    // Current day's completion flag is stored under `playedKey` as the date string.

    // Mark the daily as completed for the given date (used at run end).
    func markCompletedToday(date: Date = Date()) {
        UserDefaults.standard.set(todayKey(date: date), forKey: playedKey)
    }

    /// Return three deterministic words for the given date.
    func dailyWords(for date: Date = Date()) -> [String] {
        let key = todayKey(date: date)
        let base = staticSalt + "|" + key

        func index(suffix: String) -> Int {
            let input = base + "|" + suffix
            let hash = SHA256.hash(data: Data(input.utf8))
            // Take first 8 bytes as UInt64 and map to index
            let value = hash.withUnsafeBytes { rawPtr -> UInt64 in
                let bytes = rawPtr.bindMemory(to: UInt8.self)
                return bytes.prefix(8).enumerated().reduce(0 as UInt64) { acc, elem in
                    let (i, b) = elem
                    return acc | (UInt64(b) << (UInt64(i) * 8))
                }
            }
            let count = max(1, WordBank.words.count)
            return Int(value % UInt64(count))
        }

        // Derive 3 indices with different suffixes
        let i1 = index(suffix: "L1")
        var i2 = index(suffix: "L2")
        var i3 = index(suffix: "L3")
        // Nudge to reduce accidental duplicates
        if i2 == i1 { i2 = (i2 + 17) % WordBank.words.count }
        if i3 == i1 || i3 == i2 { i3 = (i3 + 29) % WordBank.words.count }

        return [WordBank.words[i1], WordBank.words[i2], WordBank.words[i3]].map { $0.uppercased() }
    }
}
