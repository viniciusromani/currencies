import Foundation

struct CurrenciesEntity {
    struct CurrencyEntity {
        let countryInitials: String
        let currency: Double
    }
    
    let currencies: [CurrencyEntity]
}

extension CurrenciesEntity.CurrencyEntity: Decodable {
    init(from decoder: Decoder) throws {
        self.countryInitials = ""
        self.currency = 0
    }
}
