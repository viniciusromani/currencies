import Nimble
import XCTest
@testable import Currencies

class CurrenciesEntityParseTests: XCTestCase {
    
    private var _localJSON = ""
    private let decoder = JSONDecoder()
    
    func testSuccessParsing() {
        self.localJSON = "Rates"
        
        expect { try self.decoder.decode(CurrenciesEntity.self, from: self.jsonData) }.toNot(throwError())
        
        let entity = try? self.decoder.decode(CurrenciesEntity.self, from: self.jsonData)
        
        expect(entity?.currencies).toNot(beEmpty())
        expect(entity?.currencies.count).to(equal(32))
        
        let currencies = entity?.currencies
        expect(currencies?[15].countryInitials).toNot(beEmpty())
        expect(currencies?[15].currency).to(beGreaterThan(0))
    }
    
    func testNoKeysParsing() {
        self.localJSON = "NoKeys"
        
        expect { try self.decoder.decode(CurrenciesEntity.self, from: self.jsonData) }.to(throwError())
        let entity = try? self.decoder.decode(CurrenciesEntity.self, from: self.jsonData)
        expect(entity).to(beNil())
    }
    
    func testNoRatesParsing() {
        self.localJSON = "NoRates"
        
        expect { try self.decoder.decode(CurrenciesEntity.self, from: self.jsonData) }.to(throwError())
        let entity = try? self.decoder.decode(CurrenciesEntity.self, from: self.jsonData)
        expect(entity).to(beNil())
    }
}

extension CurrenciesEntityParseTests: TestableEntity {
    var localJSON: String {
        get { return _localJSON }
        set { _localJSON = newValue }
    }
}
