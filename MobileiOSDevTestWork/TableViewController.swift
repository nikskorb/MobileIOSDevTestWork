//
//  DealsTableViewController.swift
//  MobileiOSDevTestWork
//
//  Created by Larry Livingston on 07.06.2023.
//

import UIKit

enum SortField: String, CaseIterable {
    case dateModifier
    case price
    case amount
    case instrumentName
    case side
}

enum SortDirection {
    case ascending
    case descending
}

class TableViewController: UITableViewController {
    private var server = Server()
    private var model: [Deal] = []
    private var srtedDeals: [Deal] = []

    private var sortField: SortField = .dateModifier
    private var sortDirection: SortDirection = .ascending
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(DealCell.self, forCellReuseIdentifier: DealCell.identifier)
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: HeaderCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self

        reload()
    }
    
    private func reload() {
        server.subscribeToDeals { [weak self] deals in
            self?.appendDealsAndSortModel(deals)
        }
    }
    private func appendDealsAndSortModel(_ newDeals: [Deal]) {
        model.append(contentsOf: newDeals)
        sort()
    }
    
    
    func changeSort(field: SortField, direction: SortDirection) {
        sortField = field
        sortDirection = direction
        srtedDeals = []
        tableView.reloadData()
        sort()
    }

    func sort() {
        DispatchQueue.global().async { [model, field = sortField, direction = sortDirection] in
            
            let sortedModel: [Deal] = {
                switch field {
                case .dateModifier:
                    return model.sorted { deal1, deal2 in
                        return direction == .ascending ? deal1.dateModifier < deal2.dateModifier : deal1.dateModifier > deal2.dateModifier
                    }
                case .price:
                    return model.sorted { deal1, deal2 in
                        return direction == .ascending ? deal1.price < deal2.price : deal1.price > deal2.price
                    }
                case .amount:
                    return model.sorted { deal1, deal2 in
                        return direction == .ascending ? deal1.amount < deal2.amount : deal1.amount > deal2.amount
                    }
                case .instrumentName:
                    return model.sorted { deal1, deal2 in
                        return direction == .ascending ? deal1.instrumentName < deal2.instrumentName : deal1.instrumentName > deal2.instrumentName
                    }
                case .side:
                    return model.sorted { deal1, deal2 in
                        return direction == .ascending ? deal1.side < deal2.side : deal1.side > deal2.side
                    }
                }
            }()
            
            DispatchQueue.main.async {
                if self.srtedDeals.count <= sortedModel.count {
                    self.srtedDeals = sortedModel
//                    print("Model: \(self.model.count)")
//                    print("Srted: \(self.srtedDeals.count)")
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return srtedDeals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DealCell.identifier, for: indexPath) as! DealCell
        cell.configure(srtedDeals[indexPath.row])
        return cell
    }
        
    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderCell.identifier) as? HeaderCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
}
    
extension Deal.Side: Comparable {
    static func < (lhs: Deal.Side, rhs: Deal.Side) -> Bool {
        if lhs == .sell {
            return true
        } else { return false }
    }
}
