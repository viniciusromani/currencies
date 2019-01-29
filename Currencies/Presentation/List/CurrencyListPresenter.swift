import Foundation

class CurrencyListPresenter {
    
    var view: CurrencyListViewProtocol?
    
    private let retrieveCurrenciesUseCase: RetrieveCurrenciesUseCase
    private var timer = Timer()
    private var timerTick = 0
    private var shouldUpdateCurrencies = true
    
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
            
            guard self.shouldUpdateCurrencies else { return }
            
            let viewModels = model.currencies.compactMap { CurrenciesViewModel.CurrencyViewModel(mapping: $0) }
            let viewModel = CurrenciesViewModel(currencies: viewModels)
            self.view?.successfullyGotCurrencies(viewModel)
        }
    }
    
    func updateCurrenciesFromService() {
        self.timerTick = 0
        
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: #selector(timerTicks),
                                          userInfo: nil,
                                          repeats: true)
        self.timer.fire()
    }
    
    @objc func timerTicks() {
        self.timerTick += 1
        
        if self.timerTick == 2 {
            self.retrieveCurrencies()
            self.timer.invalidate()
        }
    }
    
    func willUpdateCurrencyOnCell() {
        self.shouldUpdateCurrencies = false
    }
    
    func isUpdatingViewModel(_ viewModel: CurrenciesViewModel.CurrencyViewModel, to string: String) {
        
    }
}
