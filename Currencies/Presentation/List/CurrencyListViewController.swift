import UIKit

protocol CurrencyListViewDelegate {
    
}

protocol CurrencyListViewProtocol {
    func successfullyGotCurrencies(_ viewModel: CurrenciesViewModel)
    func errorGettingCurrencies()
}

class CurrencyListViewController: UIViewController {
    
    var currencyListView: CurrencyListView!
    var presenter: CurrencyListPresenter
    let delegate: CurrencyListViewDelegate
    lazy var dataSource = CurrencyListTableViewDataSource(tableView: self.currencyListView.tableView,
                                                          delegate: self)

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
        
        self.navigationItem.title = R.string.localizable.currencyListViewController_title()
        
        self.currencyListView.goToLoading()
        self.presenter.retrieveCurrencies()
    }
}

extension CurrencyListViewController: CurrencyListViewProtocol {
    func successfullyGotCurrencies(_ viewModel: CurrenciesViewModel) {
        self.currencyListView.removeLoading()
        self.dataSource.setCurrencies(with: viewModel)
    }
    
    func errorGettingCurrencies() {
        
    }
}

extension CurrencyListViewController: CurrencyListTableViewDataSourceDelegate {
    
}
