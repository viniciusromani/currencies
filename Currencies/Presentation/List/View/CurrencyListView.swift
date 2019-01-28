import UIKit
import SnapKit

class CurrencyListView: UIView, LoadableView {
    
    var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    let tableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        self.buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViews() {
        self.addSubviews()
        self.formatViews()
        self.addConstraintsToSubviews()
    }
    
    private func addSubviews() {
        self.addSubview(self.tableView)
    }
    
    private func formatViews() {
        self.backgroundColor = .white
        
        self.activityIndicator.color = .black
    }
    
    private func addConstraintsToSubviews() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CurrencyListView {
    func goToLoading() {
        self.layoutIfNeeded()
        self.showLoading(at: self)
    }
    
    func removeLoading() {
        self.hideLoading()
    }
}
