import Foundation

struct CurrenciesModel {
    struct CurrencyModel {
        let countryInitials: String
        let currency: Double
    }
    
    let currencies: [CurrencyModel]
}

extension CurrenciesModel.CurrencyModel {
    init(mapping entity: CurrenciesEntity.CurrencyEntity) {
        self.countryInitials = entity.countryInitials
        self.currency = entity.currency
    }
}
