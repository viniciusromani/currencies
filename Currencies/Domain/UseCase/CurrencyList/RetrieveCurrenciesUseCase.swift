import Foundation

struct RetrieveCurrenciesUseCase: AssyncUseCase {
    typealias Params = Void
    typealias Model = ((CurrenciesModel?, Error?) -> Void)
    
    private let repository: CurrenciesRepository
    
    init(repository: CurrenciesRepository) {
        self.repository = repository
    }
    
    func execute(with params: Void? = nil, completion: @escaping ((CurrenciesModel?, Error?) -> Void)) {
        self.repository.retrieve { entities, error in
            let models = entities?.currencies.map { CurrenciesModel.CurrencyModel(mapping: $0) }
            let model = CurrenciesModel(currencies: models ?? [])
            completion(model, error)
        }
    }
}
