import Nimble
import XCTest
@testable import Currencies

class CurrenciesRepositoryTests: XCTestCase {
    private let repository = CurrenciesRepository(dataSource: ApiCurrenciesDataSource(manager: AlamofireRequestManager(), router: ServiceRouter()))
    
    func testRetrieveRates() {
        waitUntil(timeout: 10) { done in
            self.repository.retrieve { entity, error in
                done()
            }
        }
    }
}
