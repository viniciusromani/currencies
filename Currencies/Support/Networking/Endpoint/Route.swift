import Foundation

protocol Route {
    var scheme: Scheme { get }
    var basePath: String { get }
}

extension Route {
    func url() -> URL {
        let path = self.basePath
        let components = [self.scheme.rawValue, "://", path]
        let urlString = components.joined()
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        return url
    }
}

struct ServiceRoute {
    internal let basePath: String
    
    init(basePath: String = "revolut.duckdns.org") {
        self.basePath = basePath
    }
}

extension ServiceRoute: Route {
    var scheme: Scheme {
        return .https
    }
}
