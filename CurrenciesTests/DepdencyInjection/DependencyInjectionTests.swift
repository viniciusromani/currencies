import Nimble
import XCTest
@testable import Currencies

class DependencyInjectionTests: XCTestCase {
    
    private let container = DependencyInjection.configure()
    
    func testCoordinatorsInjection() {
        let window = container.resolve(UIWindow.self)
        expect(window).toNot(beNil())
        
        let navigationController = container.resolve(UINavigationController.self)
        expect(navigationController).toNot(beNil())
        expect(navigationController?.navigationBar.barStyle).to(equal(.default))
        if #available(iOS 11.0, *) {
            expect(navigationController?.navigationBar.prefersLargeTitles).to(beTrue())
        }
        
        let navigationCoordinator = container.resolve(NavigationCoordination.self)
        expect(navigationCoordinator).toNot(beNil())
        let resolvedNavigationController = navigationCoordinator?.navigationController
        expect(resolvedNavigationController).toNot(beNil())
        
        let applicationCoordinator = container.resolve(ApplicationCoordinator.self)
        expect(applicationCoordinator).toNot(beNil())
    }
    
    func testAlamofireManagerInjection() {
        let alamofire = container.resolve(AlamofireRequestManager.self)
        expect(alamofire).toNot(beNil())
    }
    
    func testDataSourceInjection() {
        let currenciesDataSource = container.resolve(CurrenciesDataSource.self)
        expect(currenciesDataSource).toNot(beNil())
        expect(currenciesDataSource).to(beAKindOf(ApiCurrenciesDataSource.self))
    }
    
    func testRepositoryInjection() {
        let repository = container.resolve(CurrenciesRepository.self)
        expect(repository).toNot(beNil())
    }
    
    func testProvidersInjection() {
        let listProvider = container.resolve(CurrencyListProvider.self)
        expect(listProvider).toNot(beNil())
    }
}
