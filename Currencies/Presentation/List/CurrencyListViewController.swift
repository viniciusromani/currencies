import UIKit

protocol CurrencyListViewDelegate {
    
}

protocol CurrencyListViewProtocol {
    func successfullyGotCurrencies(_ viewModel: CurrenciesViewModel)
    func reloadForCurrencyUpdate(_ viewModel: CurrenciesViewModel)
    func errorGettingCurrencies(_ viewModel: ErrorViewModel)
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
        self.setListenerForKeyboardDismiss()
        
        self.currencyListView.goToLoading()
        self.presenter.retrieveCurrencies()
    }
    
    private func prepareNavigationItem() {
        self.navigationItem.title = R.string.localizable.currencyListViewController_title()
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onRefresh))
        self.navigationItem.rightBarButtonItem = refreshButton
    }
    
    @objc func onRefresh() {
        self.presenter.retrieveCurrencies()
    }
    
    private func setListenerForKeyboardDismiss() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onKeyboardDismiss),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func onKeyboardDismiss() {
        self.presenter.userHasFinishedUpdatingCell()
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
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
    
    func errorGettingCurrencies(_ viewModel: ErrorViewModel) {
        self.currencyListView.removeLoading()
        
        let alert = UIAlertController(title: viewModel.title,
                                      message: viewModel.message,
                                      preferredStyle: .alert)
        let viewModelAction = viewModel.okAction
        let action = UIAlertAction(title: viewModelAction.title,
                                   style: viewModelAction.style,
                                   handler: viewModelAction.handler)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
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
