import Foundation
import XCTest

protocol TestableEntity where Self: XCTestCase {
    var localJSON: String { get set }
    var jsonData: Data { get }
}

extension TestableEntity {
    var jsonData: Data {
        get {
            guard let path = Bundle(for: type(of: self)).url(forResource: localJSON, withExtension: "json") else {
                XCTFail("\(localJSON).json not found")
                fatalError("\(localJSON).json not found")
            }
            
            do {
                return try Data(contentsOf: path)
            } catch {
                XCTFail("\(localJSON).json not found")
                fatalError("\(localJSON).json could not be opened")
            }
        }
    }
}
