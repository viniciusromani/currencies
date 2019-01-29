import Foundation

struct UpdateCurrenciesForTypedValueUseCase: SyncUseCase {
    struct Params {
        let currentCurrencies: CurrenciesViewModel
        let updatedCurrency: CurrenciesViewModel.CurrencyViewModel
        let typedValue: String
    }
    typealias Model = CurrenciesModel?
    
    func execute(with params: UpdateCurrenciesForTypedValueUseCase.Params?) -> CurrenciesModel? {
        let unwrapped = self.unwrappParams(params)
        
        let beingUpdatedModel = CurrenciesModel.CurrencyModel(mapping: unwrapped.updatedCurrency)
        let value = Double(unwrapped.typedValue) ?? 0
        let updatedCurrencyModel = CurrenciesModel.CurrencyModel(iconResource: beingUpdatedModel.iconResource,
                                                                 countryInitials: beingUpdatedModel.countryInitials,
                                                                 currencyProportion: beingUpdatedModel.currencyProportion,
                                                                 currencyToDisplay: value)
        var updated: [CurrenciesModel.CurrencyModel] = [updatedCurrencyModel]
        
        unwrapped.currentCurrencies.currencies.forEach { currencyViewModel in
            let model = CurrenciesModel.CurrencyModel(mapping: currencyViewModel)
            if model.countryInitials != unwrapped.updatedCurrency.countryInitials {
                let updatedModelCurrency = (value * model.currencyProportion) / beingUpdatedModel.currencyProportion
                let rounded = Double(round(10000 * updatedModelCurrency) / 10000)
                
                let updatedModel = CurrenciesModel.CurrencyModel(iconResource: model.iconResource,
                                                                 countryInitials: model.countryInitials,
                                                                 currencyProportion: model.currencyProportion,
                                                                 currencyToDisplay: rounded)
                updated.append(updatedModel)
            }
        }
        
        let currenciesModel = CurrenciesModel(currencies: updated)
        return currenciesModel
    }
}
