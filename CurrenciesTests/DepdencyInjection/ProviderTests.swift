import Nimble
import XCTest
@testable import Currencies

class ProviderTests: XCTestCase {
    private let listProvider = CurrencyListProvider(currenciesRepository: CurrenciesRepository(dataSource: ApiCurrenciesDataSource(manager: AlamofireRequestManager(), router: ServiceRouter())))
    
    func testPresenterInjection() {
        let presenter = self.listProvider.presenter()
        expect(presenter).toNot(beNil())
        expect(presenter).to(beAKindOf(CurrencyListPresenter.self))
    }
}
