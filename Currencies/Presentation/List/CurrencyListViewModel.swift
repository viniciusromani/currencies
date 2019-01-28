import UIKit

struct CurrenciesViewModel {
    struct CurrencyViewModel {
        let icon: UIImage?
        let countryInitials: String
        let currency: String
    }
    
    let currencies: [CurrencyViewModel]
}

extension CurrenciesViewModel.CurrencyViewModel {
    init(mapping model: CurrenciesModel.CurrencyModel) {
        self.icon = UIImage(named: model.iconResource.name)
        self.countryInitials = model.countryInitials
        self.currency = "\(model.currency)"
    }
}

