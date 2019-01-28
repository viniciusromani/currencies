import Swinject

class DependencyInjection {
    
    private static let container = Container()
    
    static func configure() -> Container {
        self.injectCoordinators(on: self.container)
        self.injectAlamofireManager(on: self.container)
        self.injectDataSource(on: self.container)
        self.injectRepository(on: self.container)
        self.injectProviders(on: self.container)
        return self.container
    }
}

extension DependencyInjection {
    private static func injectCoordinators(on container: Container) {
        container.register(UIWindow.self) { _ in
            return UIWindow(frame: UIScreen.main.bounds)
        }
        
        container.register(UINavigationController.self) { _ in
            return UINavigationController()
        }
        
        container.register(NavigationCoordination.self) { resolver in
            return NavigationCoordination(navigationController: resolver.resolve(UINavigationController.self)!)
        }
        
        container.register(ApplicationCoordinator.self) { resolver in
            return ApplicationCoordinator(window: resolver.resolve(UIWindow.self)!,
                                          navigationCoordination: resolver.resolve(NavigationCoordination.self)!,
                                          currencyListProvider: resolver.resolve(CurrencyListProvider.self)!)
        }
    }
    
    private static func injectAlamofireManager(on container: Container) {
        container.register(AlamofireRequestManager.self) { _ in
            return AlamofireRequestManager()
        }
    }
    
    private static func injectDataSource(on container: Container) {
        container.register(CurrenciesDataSource.self) { resolver in
            return ApiCurrenciesDataSource(manager: resolver.resolve(AlamofireRequestManager.self)!,
                                           router: ServiceRouter())
        }
    }
    
    private static func injectRepository(on container: Container) {
        container.register(CurrenciesRepository.self) { resolver in
            return CurrenciesRepository(dataSource: resolver.resolve(CurrenciesDataSource.self)!)
        }
    }
    
    private static func injectProviders(on container: Container) {
        container.register(CurrencyListProvider.self) { resolver in
            return CurrencyListProvider(currenciesRepository: resolver.resolve(CurrenciesRepository.self)!)
        }
    }
}
