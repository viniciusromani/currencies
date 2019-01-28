import Foundation

protocol CurrenciesDataSource {
    func retrieve(_ completion: @escaping ((CurrenciesEntity?, Error?) -> Void))
}
