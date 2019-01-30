import Nimble
import XCTest
@testable import Currencies

class UseCaseTests: XCTestCase {
    private let useCase = UpdateCurrenciesForTypedValueUseCase()
    
    func testUnwrappParams() {
        let params = UpdateCurrenciesForTypedValueUseCase.Params(currentCurrencies: CurrenciesViewModel(currencies: []), updatedCurrency: CurrenciesViewModel.CurrencyViewModel(icon: nil, countryInitials: "", currencyProportion: 0, currencyToDisplay: ""), typedValue: "")
        
        let unwrapped = self.useCase.unwrappParams(params)
        expect(unwrapped).toNot(beNil())
    }
}
