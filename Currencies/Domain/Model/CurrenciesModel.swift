import Foundation
import Rswift

struct CurrenciesModel {
    struct CurrencyModel {
        let iconResource: ImageResource
        let countryInitials: String
        let currency: Double
    }
    
    let currencies: [CurrencyModel]
}

extension CurrenciesModel.CurrencyModel {
    init(mapping entity: CurrenciesEntity.CurrencyEntity) {
        self.iconResource = R.image.icAustralia
        self.countryInitials = entity.countryInitials
        self.currency = entity.currency
    }
}
