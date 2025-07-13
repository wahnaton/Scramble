import Foundation
import Combine

@MainActor
final class AdController: ObservableObject {
    @Published var showAds: Bool = true

    private var cancellable = Set<AnyCancellable>()

    init(purchaseManager: PurchaseManager) {
        // Reactively bind to adsRemoved
        purchaseManager.objectWillChange
            .sink { [weak self] in
                self?.showAds = !purchaseManager.adsRemoved
            }
            .store(in: &cancellable)
    }
}
