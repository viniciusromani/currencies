import Foundation

struct CurrencyListPresenter {
    
    var view: CurrencyListViewProtocol?
    
    private let retrieveCurrenciesUseCase: RetrieveCurrenciesUseCase
    
    init(retrieveCurrenciesUseCase: RetrieveCurrenciesUseCase) {
        self.retrieveCurrenciesUseCase = retrieveCurrenciesUseCase
    }
    
    func retrieveCurrencies() {
        self.retrieveCurrenciesUseCase.execute { incomingModel, error in
            guard let model = incomingModel,
                  error == nil else {
                    // throw error
                    return
            }
            
            let viewModels = model.currencies.compactMap { CurrenciesViewModel.CurrencyViewModel(mapping: $0) }
            let viewModel = CurrenciesViewModel(currencies: viewModels)
            self.view?.successfullyGotCurrencies(viewModel)
        }
    }
}
