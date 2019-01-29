import Nimble
import XCTest
@testable import Currencies

class CurrenciesModelParseTests: XCTestCase {
    
    func testModelParse() {
        let entity1 = CurrenciesEntity.CurrencyEntity(countryInitials: "AUD", currency: 1.6178)
        let entity2 = CurrenciesEntity.CurrencyEntity(countryInitials: "BGN", currency: 1.9576)
        let entity3 = CurrenciesEntity.CurrencyEntity(countryInitials: "BRL", currency: 4.7961)
        let entity = CurrenciesEntity(currencies: [entity1, entity2, entity3])
        
        let models = entity.currencies.compactMap { CurrenciesModel.CurrencyModel(mapping: $0) }
        models.enumerated().forEach { (index, model) in
            expect(model.countryInitials).to(equal(entity.currencies[index].countryInitials))
            expect(model.currencyProportion).to(equal(entity.currencies[index].currency))
            expect(model.currencyToDisplay).to(equal(entity.currencies[index].currency))
        }
        
        expect(models[0].iconResource.name).to(equal(R.image.icAustralia.name))
        expect(models[1].iconResource.name).to(equal(R.image.icBulgaria.name))
        expect(models[2].iconResource.name).to(equal(R.image.icBrazil.name))
    }
    
    func testViewModelParse() {
        let viewModel1 = CurrenciesViewModel.CurrencyViewModel(icon: R.image.icAustralia(),
                                                               countryInitials: "AUD",
                                                               currencyProportion: 1.6178,
                                                               currencyToDisplay: "2.098")
        let viewModel2 = CurrenciesViewModel.CurrencyViewModel(icon: R.image.icBulgaria(),
                                                               countryInitials: "BGN",
                                                               currencyProportion: 1.9576,
                                                               currencyToDisplay: "13.2091")
        let viewModel3 = CurrenciesViewModel.CurrencyViewModel(icon: R.image.icBrazil(),
                                                               countryInitials: "BRL",
                                                               currencyProportion: 4.7961,
                                                               currencyToDisplay: "2901.2")
        let viewModel = CurrenciesViewModel(currencies: [viewModel1, viewModel2, viewModel3])
        
        let models = viewModel.currencies.compactMap { CurrenciesModel.CurrencyModel(mapping: $0) }
        models.enumerated().forEach { (index, model) in
            expect(model.countryInitials).to(equal(viewModel.currencies[index].countryInitials))
            expect(model.currencyProportion).to(equal(viewModel.currencies[index].currencyProportion))
            let displayDouble = Double(viewModel.currencies[index].currencyToDisplay) ?? 0
            expect(model.currencyToDisplay).to(equal(displayDouble))
        }
        
        expect(models[0].iconResource.name).to(equal(R.image.icAustralia.name))
        expect(models[1].iconResource.name).to(equal(R.image.icBulgaria.name))
        expect(models[2].iconResource.name).to(equal(R.image.icBrazil.name))
    }
}
