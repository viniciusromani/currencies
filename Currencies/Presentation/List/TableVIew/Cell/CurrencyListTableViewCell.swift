import UIKit

class CurrencyListTableViewCell: UITableViewCell {
    private let countryImage = UIImageView()
    private let countryInitials = UILabel()
    let currency = UITextField()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.buildViews()
    }
    
    private func buildViews() {
        self.addSubviews()
        self.formatViews()
        self.addConstraintsToSubviews()
    }
    
    private func addSubviews() {
        self.contentView.addSubviews([self.countryImage,
                                      self.countryInitials,
                                      self.currency])
    }
    
    private func formatViews() {
        self.backgroundColor = .white
        
        self.countryImage.image = R.image.icFlagPlaceholder()
        self.countryImage.layer.cornerRadius = 50 / 2
        self.countryImage.layer.borderWidth = 1
        self.countryImage.layer.borderColor = UIColor.darkGray.cgColor
        self.countryImage.clipsToBounds = true
        self.countryImage.contentMode = .scaleAspectFill
        
        self.countryInitials.text = "-"
        self.countryInitials.textColor = .black
        self.countryInitials.font = UIFont.boldSystemFont(ofSize: 16)
        
        self.currency.text = "-"
        self.currency.textColor = .black
        self.currency.font = UIFont.systemFont(ofSize: 22)
        self.currency.textAlignment = .right
        self.currency.keyboardType = .numberPad
    }
    
    private func addConstraintsToSubviews() {
        countryImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(15).priority(999)
            make.width.height.equalTo(50)
        }
        
        countryInitials.snp.makeConstraints { make in
            make.left.equalTo(self.countryImage.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
        
        currency.snp.makeConstraints { make in
            make.left.equalTo(self.countryInitials.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(12)
        }
    }
}

extension CurrencyListTableViewCell {
    func setCurrency(with viewModel: CurrenciesViewModel.CurrencyViewModel) {
        self.countryImage.image = viewModel.icon
        self.countryInitials.text = viewModel.countryInitials
        self.currency.text = viewModel.currency
    }
}
