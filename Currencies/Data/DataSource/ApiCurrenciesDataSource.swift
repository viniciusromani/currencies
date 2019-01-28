import Foundation

struct ApiCurrenciesDataSource: CurrenciesDataSource {
    private let manager: AlamofireRequestManager
    private let router: ServiceRouter
    
    init(manager: AlamofireRequestManager,
         router: ServiceRouter) {
        self.manager = manager
        self.router = router
    }
    
    func retrieve(_ completion: @escaping ((CurrenciesEntity?, Error?) -> Void)) {
        let path = "latest?base=EUR"
        let url = self.router.url(for: path)
        
        self.manager.request(.get, from: url) { result, error, _ in
            guard error == nil,
                  let value = result else {
                    completion(nil, error)
                    return
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                let decoder = JSONDecoder()
                let entity = try decoder.decode(CurrenciesEntity.self, from: data)
                completion(entity, nil)
            } catch {
                let error = NSError(domain: "ApiCurrenciesDataSource",
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: R.string.localizable.apiCurrencies_error0()])
                completion(nil, error)
            }
        }
    }
}
