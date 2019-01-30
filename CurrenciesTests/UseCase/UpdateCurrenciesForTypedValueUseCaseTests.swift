import Nimble
import XCTest
@testable import Currencies

class UpdateCurrenciesForTypedValueUseCaseTests: XCTestCase {
    private let useCase = UpdateCurrenciesForTypedValueUseCase()
    private var current = CurrenciesViewModel(currencies: [])
    private var currency1 = CurrenciesViewModel.CurrencyViewModel(icon: nil,
                                                                  countryInitials: "BGN",
                                                                  currencyProportion: 1.9576,
                                                                  currencyToDisplay: "1.9576")
    private var currency2 = CurrenciesViewModel.CurrencyViewModel(icon: nil,
                                                                  countryInitials: "BRL",
                                                                  currencyProportion: 4.7961,
                                                                  currencyToDisplay: "4.7961")
    private let updatedCurrency = CurrenciesViewModel.CurrencyViewModel(icon: nil,
                                                                        countryInitials: "BRL",
                                                                        currencyProportion: 4.7969,
                                                                        currencyToDisplay: "4.7969")
    
    override func setUp() {
        self.current = CurrenciesViewModel(currencies: [self.currency1, self.currency2])
    }
    
    override func tearDown() {
        self.current = CurrenciesViewModel(currencies: [])
    }
    
    func testExecuteRemovingOneDecimal() {
        let params = UpdateCurrenciesForTypedValueUseCase.Params(currentCurrencies: self.current,
                                                                 updatedCurrency: self.updatedCurrency,
                                                                 typedValue: "4.796")
        let model = self.useCase.execute(with: params)
        expect(model).toNot(beNil())
        expect(model?.currencies.count).to(equal(2))
        
        let first = model?.currencies.first
        expect(first?.countryInitials).to(equal("BRL"))
        expect(first?.currencyProportion).to(equal(self.updatedCurrency.currencyProportion))
        expect(first?.currencyToDisplay).to(equal(4.796))
        expect(first?.iconResource.name).to(equal(R.image.icBrazil.name))
        
        let last = model?.currencies.last
        expect(last?.countryInitials).to(equal("BGN"))
        expect(last?.currencyProportion).to(equal(self.currency1.currencyProportion))
        expect(last?.currencyToDisplay).to(equal(1.9572))
        expect(last?.iconResource.name).to(equal(R.image.icBulgaria.name))
    }
    
    func testExecuteRemovingTwoDecimals() {
        let params = UpdateCurrenciesForTypedValueUseCase.Params(currentCurrencies: self.current,
                                                                 updatedCurrency: self.updatedCurrency,
                                                                 typedValue: "4.79")
        let model = self.useCase.execute(with: params)
        expect(model).toNot(beNil())
        expect(model?.currencies.count).to(equal(2))
        
        let first = model?.currencies.first
        expect(first?.countryInitials).to(equal("BRL"))
        expect(first?.currencyProportion).to(equal(self.updatedCurrency.currencyProportion))
        expect(first?.currencyToDisplay).to(equal(4.79))
        expect(first?.iconResource.name).to(equal(R.image.icBrazil.name))
        
        let last = model?.currencies.last
        expect(last?.countryInitials).to(equal("BGN"))
        expect(last?.currencyProportion).to(equal(self.currency1.currencyProportion))
        expect(last?.currencyToDisplay).to(equal(1.9548))
        expect(last?.iconResource.name).to(equal(R.image.icBulgaria.name))
    }
    
    func testExecuteNoTypedValue() {
        let params = UpdateCurrenciesForTypedValueUseCase.Params(currentCurrencies: self.current,
                                                                 updatedCurrency: self.updatedCurrency,
                                                                 typedValue: "")
        let model = self.useCase.execute(with: params)
        expect(model).toNot(beNil())
        expect(model?.currencies.count).to(equal(2))
        
        let first = model?.currencies.first
        expect(first?.countryInitials).to(equal("BRL"))
        expect(first?.currencyProportion).to(equal(self.updatedCurrency.currencyProportion))
        expect(first?.currencyToDisplay).to(equal(0))
        expect(first?.iconResource.name).to(equal(R.image.icBrazil.name))
        
        let last = model?.currencies.last
        expect(last?.countryInitials).to(equal("BGN"))
        expect(last?.currencyProportion).to(equal(self.currency1.currencyProportion))
        expect(last?.currencyToDisplay).to(equal(0))
        expect(last?.iconResource.name).to(equal(R.image.icBulgaria.name))
    }
}
