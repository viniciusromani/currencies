import Foundation

struct CurrenciesEntity {
    struct CurrencyEntity {
        var countryInitials: String
        var currency: Double
    }
    
    let currencies: [CurrencyEntity]
}

extension CurrenciesEntity: Decodable {
    private enum CodingKeys: String, CodingKey {
        case rates
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let ratesDictionary = try container.decode([String: Double].self, forKey: .rates)
        self.currencies = ratesDictionary.keys.compactMap { CurrencyEntity(countryInitials: $0,
                                                                           currency: ratesDictionary[$0] ?? 0) }
    }
}
