import UIKit

protocol CurrencyListViewDelegate {
    
}

protocol CurrencyListViewProtocol {
    
}

class CurrencyListViewController: UIViewController {
    
    var currencyListView: CurrencyListView!
    var presenter: CurrencyListPresenter
    let delegate: CurrencyListViewDelegate

    init(presenter: CurrencyListPresenter,
         delegate: CurrencyListViewDelegate) {
        self.presenter = presenter
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.currencyListView = CurrencyListView()
        
        self.view = self.currencyListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension CurrencyListViewController: CurrencyListViewProtocol {
    
}
