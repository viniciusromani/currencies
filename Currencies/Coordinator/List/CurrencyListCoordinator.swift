import Foundation
import UIKit

class CurrencyListCoordinator: Coordinator {
    
    private let navigationCoordination: NavigationCoordination
    private let currencyListProvider: CurrencyListProvider
    
    init(navigationCoordination: NavigationCoordination,
         currencyListProvider: CurrencyListProvider) {
        self.navigationCoordination = navigationCoordination
        self.currencyListProvider = currencyListProvider
    }
    
    func start() {
        let presenter = self.currencyListProvider.presenter()
        let currencyListViewController = CurrencyListViewController(presenter: presenter, delegate: self)
        currencyListViewController.presenter.view = currencyListViewController
        self.navigationCoordination.setStack([currencyListViewController])
    }
}

extension CurrencyListCoordinator: CurrencyListViewDelegate {
    
}
