import Nimble
import XCTest
@testable import Currencies

class ApiCurrenciesDataSourceTests: XCTestCase {
    private let dataSource = ApiCurrenciesDataSource(manager: AlamofireRequestManager(), router: ServiceRouter())
    
    func testRetrieveRates() {
        waitUntil(timeout: 10) { done in
            self.dataSource.retrieve { entity, error in
                if entity == nil {
                    expect(error).toNot(beNil())
                    done()
                } else if error == nil {
                    expect(entity).toNot(beNil())
                    expect(entity?.currencies.count).to(beGreaterThan(0))
                    done()
                }
            }
        }
    }
}
