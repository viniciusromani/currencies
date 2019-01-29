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

struct ErrorViewModel {
    struct Action {
        let title: String
        let style: UIAlertAction.Style
        let handler: ((UIAlertAction) -> Void)
    }
    
    let title: String
    let message: String
    let okAction: Action
}

extension ErrorViewModel.Action {
    init() {
        self.title = R.string.localizable.errorAlertButton_title()
        self.style = .default
        self.handler = { _ in }
    }
}

extension ErrorViewModel {
    init() {
        self.title = R.string.localizable.errorAlert_title()
        self.message = R.string.localizable.errorAlert_message()
        self.okAction = ErrorViewModel.Action()
    }
}
