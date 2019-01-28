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
                    let error = NSError(domain: "ApiCurrenciesDataSource",
                                        code: 0,
                                        userInfo: [NSLocalizedDescriptionKey: ""])
                    completion(nil, error)
                    return
            }
            
            
        }
    }
}
