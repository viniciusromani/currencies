import Swinject

class DependencyInjection {
    
    private static let container: Container = {
        let container = Container()
        return container
    }()
    
    static func configure() -> Container {
        self.injectCoordinators(on: self.container)
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
    
    private static func injectProviders(on container: Container) {
        container.register(CurrencyListProvider.self) { _ in
            return CurrencyListProvider()
        }
    }
}
