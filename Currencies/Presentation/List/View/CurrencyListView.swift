import UIKit
import SnapKit

class CurrencyListView: UIView {
    
    let label = UILabel()
    
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
        self.addSubview(self.label)
    }
    
    private func formatViews() {
        self.backgroundColor = .white
        
        self.label.text = "Teste"
        self.label.textColor = .black
        self.label.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func addConstraintsToSubviews() {
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
        }
    }
}
