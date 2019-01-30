import Nimble
import XCTest
@testable import Currencies

class LoadableViewTests: XCTestCase {
    
    private class LoadableUIView: UIView, LoadableView {
        var activityIndicator = UIActivityIndicatorView(style: .gray)
    }
    private let loadable = LoadableUIView()
    
    override func setUp() {
        self.loadable.hideLoading()
    }
    
    func testActivityIndicator() {
        expect(self.loadable.activityIndicator.style).to(equal(.gray))
    }
    
    func testShowLoading() {
        self.loadable.showLoading(at: self.loadable)
        
        expect(self.loadable.subviews.count).to(equal(1))
        expect(self.loadable.subviews.first?.subviews.count).to(equal(1))
        
        let indicatorView = self.loadable.subviews.first?.subviews.first
        expect(indicatorView).to(beAKindOf(UIActivityIndicatorView.self))
    }
    
    func testHideLoading() {
        self.loadable.showLoading(at: self.loadable)
        self.loadable.hideLoading()
        
        expect(self.loadable.subviews.count).to(equal(0))
        
        let indicatorView = self.loadable.subviews.first?.subviews.first
        expect(indicatorView).to(beNil())
    }
}
