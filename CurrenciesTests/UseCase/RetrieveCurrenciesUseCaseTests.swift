import Nimble
import XCTest
@testable import Currencies

class RetrieveCurrenciesUseCaseTests: XCTestCase {
    private let useCase = RetrieveCurrenciesUseCase(repository: CurrenciesRepository(dataSource: ApiCurrenciesDataSource(manager: AlamofireRequestManager(), router: ServiceRouter())))
    
    func testExecute() {
        waitUntil(timeout: 10) { done in
            self.useCase.execute { model, error in
                done()
            }
        }
    }
}
