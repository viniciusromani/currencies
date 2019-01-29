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
        let updatedCurrencyModel = CurrenciesModel.CurrencyModel(mapping: unwrapped.updatedCurrency)
        var updated: [CurrenciesModel.CurrencyModel] = [updatedCurrencyModel]
        let value = Double(unwrapped.typedValue) ?? 0
        
        unwrapped.currentCurrencies.currencies.forEach { currencyViewModel in
            let model = CurrenciesModel.CurrencyModel(mapping: currencyViewModel)
            if model.countryInitials != unwrapped.updatedCurrency.countryInitials {
                let updatedModelCurrency = (value * model.currencyProportion) / updatedCurrencyModel.currencyProportion
                let rounded = Double(round(10000 * updatedModelCurrency) / 10000)
                let proportion = rounded == 0 ? model.currencyProportion: rounded
                
                let updatedModel = CurrenciesModel.CurrencyModel(iconResource: model.iconResource,
                                                                 countryInitials: model.countryInitials,
                                                                 currencyProportion: proportion,
                                                                 currencyToDisplay: rounded)
                updated.append(updatedModel)
            }
        }
        
        let currenciesModel = CurrenciesModel(currencies: updated)
        return currenciesModel
    }
}
