import Foundation

struct CurrencyListProvider {
    
    private let currenciesRepository: CurrenciesRepository
    
    init(currenciesRepository: CurrenciesRepository) {
        self.currenciesRepository = currenciesRepository
    }
    
    func presenter() -> CurrencyListPresenter {
        return CurrencyListPresenter(retrieveCurrenciesUseCase: self.getRetrieveCurrenciesUseCase(),
                                     updateCurrenciesForTypedValueUseCase: self.getUpdateCurrenciesForTypedValueUseCase())
    }
    
    private func getRetrieveCurrenciesUseCase() -> RetrieveCurrenciesUseCase {
        return RetrieveCurrenciesUseCase(repository: self.currenciesRepository)
    }
    
    private func getUpdateCurrenciesForTypedValueUseCase() -> UpdateCurrenciesForTypedValueUseCase {
        return UpdateCurrenciesForTypedValueUseCase()
    }
}
