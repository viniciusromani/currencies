import Foundation

struct CurrencyListProvider {
    init() {
        
    }
    
    func presenter() -> CurrencyListPresenter {
        return CurrencyListPresenter()
    }
}
