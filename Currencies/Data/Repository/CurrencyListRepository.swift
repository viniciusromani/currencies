import Foundation

struct CurrenciesRepository {
    private let dataSource: CurrenciesDataSource
    
    init(dataSource: CurrenciesDataSource) {
        self.dataSource = dataSource
    }
    
    func retrieve(_ completion: @escaping ((CurrenciesEntity?, Error?) -> Void)) {
        self.dataSource.retrieve(completion)
    }
}
