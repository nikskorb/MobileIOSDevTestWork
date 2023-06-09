//
//  HeaderCell.swift
//  MobileiOSDevTestWork
//
//  Created by Larry Livingston on 07.06.2023.
//

import UIKit

class HeaderCell: UITableViewHeaderFooterView {
    private let instrumentLabel: UILabel = {
        let label = UILabel()
        label.text = "Instrument"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Amount"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let sideLabel: UILabel = {
        let label = UILabel()
        label.text = "Side"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLabels()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabels()
    }

    private func setupLabels() {
        stackView.addArrangedSubview(instrumentLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(sideLabel)
        
        contentView.addSubview(stackView)
        
        let labelsConstraints = [
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ]

        NSLayoutConstraint.activate(labelsConstraints)
    }
}
