import UIKit

protocol CurrencyListTableViewDataSourceDelegate {
    func willUpdateCurrency()
    func isUpdating(_ viewModel: CurrenciesViewModel.CurrencyViewModel, to string: String)
}

protocol CurrencyListTableViewDataSourceViewDelegate {
    func willUpdateCurrency(at cell: UITableViewCell)
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
        tableView.delegate = self
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
        cell.viewDelegate = self
        cell.delegate = self.delegate
        return cell
    }
}

extension CurrencyListTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.moveRowToTop(at: indexPath)
    }
}

extension CurrencyListTableViewDataSource: CurrencyListTableViewDataSourceViewDelegate {
    func willUpdateCurrency(at cell: UITableViewCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        self.moveRowToTop(at: indexPath)
    }
}

extension CurrencyListTableViewDataSource {
    func setCurrencies(with viewModel: CurrenciesViewModel) {
        self.viewModel = viewModel
        self.tableView.reloadData()
    }
    
    private func moveRowToTop(at indexPath: IndexPath) {
        let firstIndexPath = IndexPath(row: 0, section: 0)
        self.tableView.moveRow(at: indexPath, to: firstIndexPath)
        self.tableView.scrollToRow(at: firstIndexPath, at: .top, animated: true)
    }
}
