import SwiftUI
import StoreKit

typealias VerifiedTransaction = StoreKit.Transaction

@MainActor
class PurchaseManager: ObservableObject {
    private static let removeAdsID = "com.willance.scramble.remove_ads"

    @AppStorage("adsRemoved", store: .standard) var adsRemoved: Bool = false
    
    init() {
        Task { [weak self] in
            // Sync existing entitlements on launch
            for await result in Transaction.currentEntitlements {
                guard case .verified(let transaction) = result else { continue }
                if transaction.productID == Self.removeAdsID {
                    self?.adsRemoved = true
                    break  // Non‑consumable; one match is enough
                }
            }

            // Listen for future updates while the app is running
            for await update in Transaction.updates {
                guard case .verified(let transaction) = update else { continue }
                if transaction.productID == Self.removeAdsID {
                    self?.adsRemoved = true
                    await transaction.finish()
                }
            }
        }
    }

    func buyRemoveAds() async {
        do {
            let products = try await Product.products(for: [Self.removeAdsID])
            guard let product = products.first else { return }
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                guard case .verified(let transaction) = verification else { return }
                await updateAdsRemovedStatus(transaction: transaction)
                await transaction.finish()
            default:
                break
            }
        } catch {
            print("Purchase failed: \(error)")
        }
    }

    private func updateAdsRemovedStatus(transaction: VerifiedTransaction) async {
        if transaction.productID == Self.removeAdsID {
            adsRemoved = true
        }
    }

    func restorePurchases() async {
        do {
            try await AppStore.sync()
            for await result in Transaction.currentEntitlements {
                if case .verified(let transaction) = result,
                   transaction.productID == Self.removeAdsID {
                    adsRemoved = true
                    break
                }
            }
        } catch {
            print("Restore failed: \(error)")
        }
    }
}
