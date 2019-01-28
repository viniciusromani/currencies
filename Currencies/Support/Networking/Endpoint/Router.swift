import Foundation

protocol Router {
    var route: Route { get }
}

extension Router {
    func url(for path: String) -> URL {
        guard let url = URL(string: path, relativeTo: self.route.url())?.absoluteURL else {
            fatalError("Invalid URL")
        }
        
        return url
    }
}

struct ServiceRouter: Router {
    internal let route: Route
    
    init() {
        self.route = ServiceRoute()
    }
}
