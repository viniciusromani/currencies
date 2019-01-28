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
        switch entity.countryInitials {
        case "AUD": self.iconResource = R.image.icAustralia
        case "BGN": self.iconResource = R.image.icBulgaria
        case "BRL": self.iconResource = R.image.icBrazil
        case "CAD": self.iconResource = R.image.icCanada
        case "CHF": self.iconResource = R.image.icSwiss
        case "CNY": self.iconResource = R.image.icChina
        case "CZK": self.iconResource = R.image.icCzech
        case "DKK": self.iconResource = R.image.icDenmark
        case "GBP": self.iconResource = R.image.icUnitedKingdom
        case "HKD": self.iconResource = R.image.icHongKong
        case "HRK": self.iconResource = R.image.icCroatia
        case "HUF": self.iconResource = R.image.icHungary
        case "IDR": self.iconResource = R.image.icIndonesia
        case "ILS": self.iconResource = R.image.icIsrael
        case "INR": self.iconResource = R.image.icIndia
        case "ISK": self.iconResource = R.image.icIceland
        case "JPY": self.iconResource = R.image.icJapan
        case "KRW": self.iconResource = R.image.icSouthKorea
        case "MXN": self.iconResource = R.image.icMexico
        case "MYR": self.iconResource = R.image.icMalaysia
        case "NOK": self.iconResource = R.image.icNorway
        case "NZD": self.iconResource = R.image.icNewZealand
        case "PHP": self.iconResource = R.image.icPhilippines
        case "PLN": self.iconResource = R.image.icPoland
        case "RON": self.iconResource = R.image.icRomania
        case "RUB": self.iconResource = R.image.icRussia
        case "SEK": self.iconResource = R.image.icSweden
        case "SGD": self.iconResource = R.image.icSingapore
        case "THB": self.iconResource = R.image.icThai
        case "TRY": self.iconResource = R.image.icTurkey
        case "USD": self.iconResource = R.image.icUSA
        case "ZAR": self.iconResource = R.image.icSouthAfrica
        default: self.iconResource = R.image.icFlagPlaceholder
        }
        
        self.countryInitials = entity.countryInitials
        self.currency = entity.currency
    }
}
