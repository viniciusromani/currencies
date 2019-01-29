import Foundation

class CurrencyListPresenter {
    
    var view: CurrencyListViewProtocol?
    
    private let retrieveCurrenciesUseCase: RetrieveCurrenciesUseCase
    private let updateCurrenciesForTypedValueUseCase: UpdateCurrenciesForTypedValueUseCase
    
    private var timer = Timer()
    private var timerTick = 0
    private var shouldUpdateCurrencies = true
    private var currenciesViewModel: CurrenciesViewModel?
    
    init(retrieveCurrenciesUseCase: RetrieveCurrenciesUseCase,
         updateCurrenciesForTypedValueUseCase: UpdateCurrenciesForTypedValueUseCase) {
        self.retrieveCurrenciesUseCase = retrieveCurrenciesUseCase
        self.updateCurrenciesForTypedValueUseCase = updateCurrenciesForTypedValueUseCase
    }
    
    func retrieveCurrencies() {
        self.retrieveCurrenciesUseCase.execute { incomingModel, error in
            guard let model = incomingModel,
                  error == nil else {
                    let errorViewModel = ErrorViewModel()
                    self.view?.errorGettingCurrencies(errorViewModel)
                    return
            }
            
            guard self.shouldUpdateCurrencies else { return }
            
            let viewModels = model.currencies.compactMap { CurrenciesViewModel.CurrencyViewModel(mapping: $0) }
            let viewModel = CurrenciesViewModel(currencies: viewModels)
            self.view?.successfullyGotCurrencies(viewModel)
            
            self.currenciesViewModel = viewModel
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
    
    func userHasFinishedUpdatingCell() {
        self.shouldUpdateCurrencies = true
    }
    
    func isUpdatingViewModel(_ viewModel: CurrenciesViewModel.CurrencyViewModel, to string: String) {
        guard let current = self.currenciesViewModel else {
            return
        }
        
        let params = UpdateCurrenciesForTypedValueUseCase.Params(currentCurrencies: current,
                                                                 updatedCurrency: viewModel,
                                                                 typedValue: string)
        let incomingModel = self.updateCurrenciesForTypedValueUseCase.execute(with: params)
        
        guard let model = incomingModel else {
            return
        }
        
        let viewModels = model.currencies.compactMap { CurrenciesViewModel.CurrencyViewModel(mapping: $0) }
        let viewModel = CurrenciesViewModel(currencies: viewModels)
        self.view?.reloadForCurrencyUpdate(viewModel)
        
        self.currenciesViewModel = viewModel
    }
}
