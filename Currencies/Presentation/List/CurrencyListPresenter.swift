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
            
            print("sucesso ")
        }
    }
}
