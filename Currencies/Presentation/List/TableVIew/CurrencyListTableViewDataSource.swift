import UIKit

protocol CurrencyListTableViewDataSourceDelegate {
    
}

class CurrencyListTableViewDataSource: NSObject {
    private let tableView: UITableView
    private var viewModel: CurrenciesViewModel?
    private let delegate: CurrencyListTableViewDataSourceDelegate
    
    init(tableView: UITableView,
         delegate: CurrencyListTableViewDataSourceDelegate) {
        self.tableView = tableView
        self.delegate = delegate
        
        super.init()
        
        tableView.registerCell(UITableViewCell.self)
        tableView.registerCell(CurrencyListTableViewCell.self)
        
        tableView.dataSource = self
    }
}

extension CurrencyListTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModelSize = self.viewModel?.currencies.count else {
            return 0
        }
        return viewModelSize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = self.viewModel else {
            return UITableViewCell()
        }
        
        let currency = viewModel.currencies[indexPath.row]
        let cell = tableView.dequeueReusableCell(at: indexPath) as CurrencyListTableViewCell
        cell.setCurrency(with: currency)
        return cell
    }
}

extension CurrencyListTableViewDataSource {
    func setCurrencies(with viewModel: CurrenciesViewModel) {
        self.viewModel = viewModel
        self.tableView.reloadData()
    }
}
