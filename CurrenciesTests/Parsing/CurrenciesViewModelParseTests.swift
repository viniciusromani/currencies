import Nimble
import XCTest
@testable import Currencies

class CurrenciesViewModelParseTests: XCTestCase {
    
    func testViewModelParse() {
        let model1 = CurrenciesModel.CurrencyModel(iconResource: R.image.icAustralia,
                                                   countryInitials: "AUD",
                                                   currencyProportion: 1.6178,
                                                   currencyToDisplay: 2.098)
        let model2 = CurrenciesModel.CurrencyModel(iconResource: R.image.icBulgaria,
                                                   countryInitials: "BGN",
                                                   currencyProportion: 1.9576,
                                                   currencyToDisplay: 13.2091)
        let model3 = CurrenciesModel.CurrencyModel(iconResource: R.image.icBrazil,
                                                   countryInitials: "BRL",
                                                   currencyProportion: 4.7961,
                                                   currencyToDisplay: 2901.2)
        let model = CurrenciesModel(currencies: [model1, model2, model3])
        
        let viewModels = model.currencies.compactMap { CurrenciesViewModel.CurrencyViewModel(mapping: $0) }
        viewModels.enumerated().forEach { (index, viewModel) in
            expect(viewModel.countryInitials).to(equal(model.currencies[index].countryInitials))
            expect(viewModel.currencyProportion).to(equal(model.currencies[index].currencyProportion))
            let displayString = "\(model.currencies[index].currencyToDisplay)"
            expect(viewModel.currencyToDisplay).to(equal(displayString))
        }
        
        expect(viewModels[0].icon).to(equal(R.image.icAustralia()))
        expect(viewModels[1].icon).to(equal(R.image.icBulgaria()))
        expect(viewModels[2].icon).to(equal(R.image.icBrazil()))
    }
}
