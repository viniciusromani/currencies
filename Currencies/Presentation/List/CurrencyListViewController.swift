import UIKit

protocol CurrencyListViewDelegate {
    
}

protocol CurrencyListViewProtocol {
    func successfullyGotCurrencies(_ viewModel: CurrenciesViewModel)
    func reloadForCurrencyUpdate(_ viewModel: CurrenciesViewModel)
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
        
        self.prepareNavigationItem()
//        self.setDismissKeyboard()
        
        self.currencyListView.goToLoading()
        self.presenter.retrieveCurrencies()
    }
    
    private func prepareNavigationItem() {
        self.navigationItem.title = R.string.localizable.currencyListViewController_title()
        
//        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onRefresh))
//        self.navigationItem.rightBarButtonItem = refreshButton
    }
    
//    private func setDismissKeyboard() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(onNavigationTap))
//        self.navigationController?.view.addGestureRecognizer(tap)
//    }
//    
//    @objc func onRefresh() {
//        self.presenter.retrieveCurrencies()
//    }
//    
//    @objc func onNavigationTap() {
//        self.presenter.userHasFinishedUpdatingCell()
//        self.navigationItem.rightBarButtonItem?.isEnabled = true
//        self.currencyListView.resignFirstResponder()
//    }
}

extension CurrencyListViewController: CurrencyListViewProtocol {
    func successfullyGotCurrencies(_ viewModel: CurrenciesViewModel) {
        self.currencyListView.removeLoading()
        self.dataSource.setCurrencies(with: viewModel)
        
        self.presenter.updateCurrenciesFromService()
    }
    
    func reloadForCurrencyUpdate(_ viewModel: CurrenciesViewModel) {
        self.dataSource.reloadForCurrencyUpdate(with: viewModel)
    }
    
    func errorGettingCurrencies() {
        
    }
}

extension CurrencyListViewController: CurrencyListTableViewDataSourceDelegate {
    func willUpdateCurrency() {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.presenter.willUpdateCurrencyOnCell()
    }
    
    func isUpdating(_ viewModel: CurrenciesViewModel.CurrencyViewModel, to string: String) {
        self.presenter.isUpdatingViewModel(viewModel, to: string)
    }
}
