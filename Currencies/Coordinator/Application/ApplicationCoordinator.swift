import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    
    private let window: UIWindow
    private let navigationCoordination: NavigationCoordination
    private let currencyListProvider: CurrencyListProvider
    
    init(window: UIWindow,
         navigationCoordination: NavigationCoordination,
         currencyListProvider: CurrencyListProvider) {
        self.window = window
        self.navigationCoordination = navigationCoordination
        self.currencyListProvider = currencyListProvider
    }
    
    func start() {
        let listCoordinator = CurrencyListCoordinator(navigationCoordination: self.navigationCoordination,
                                                      currencyListProvider: self.currencyListProvider)
        listCoordinator.start()
        
        self.window.rootViewController = self.navigationCoordination.navigationController
        self.window.makeKeyAndVisible()
    }
}
