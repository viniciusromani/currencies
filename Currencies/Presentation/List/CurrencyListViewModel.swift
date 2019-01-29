import UIKit

struct CurrenciesViewModel {
    struct CurrencyViewModel {
        let icon: UIImage?
        let countryInitials: String
        let currencyProportion: Double
        let currencyToDisplay: String
    }
    
    var currencies: [CurrencyViewModel]
}

extension CurrenciesViewModel.CurrencyViewModel {
    init(mapping model: CurrenciesModel.CurrencyModel) {
        self.icon = UIImage(named: model.iconResource.name)
        self.countryInitials = model.countryInitials
        self.currencyProportion = model.currencyProportion
        self.currencyToDisplay = "\(model.currencyToDisplay)"
    }
}

