import Nimble
import XCTest
@testable import Currencies

class NetworkingTests: XCTestCase {
    private let endpoint = ServiceRouter()
    private let alamofire = AlamofireRequestManager()
    
    func testEndpoint() {
        let basePath = self.endpoint.route.basePath
        expect(basePath).to(equal("revolut.duckdns.org"))
        let scheme = self.endpoint.route.scheme
        expect(scheme).to(equal(Scheme.https))
        let route = self.endpoint.route
        expect(route).to(beAKindOf(ServiceRoute.self))
        let url = self.endpoint.route.url()
        expect(url).to(equal(URL(string: "https://revolut.duckdns.org")))
    }
    
    func testAlamofireCall() {
        let url = URL(string: "http://httpbin.org/get")!
        
        waitUntil(timeout: 10) { done in
            self.alamofire.request(.get, from: url) { value, error, response in
                done()
            }
        }
    }
}
