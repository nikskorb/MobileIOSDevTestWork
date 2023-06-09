//
//  DealSell.swift
//  MobileiOSDevTestWork
//
//  Created by Larry Livingston on 07.06.2023.
//

import UIKit
import Foundation

class DealCell: UITableViewCell {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
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
    
    var instrumentNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    var sideLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    private func setupViews() {
        
        stackView.addArrangedSubview(instrumentNameLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(sideLabel)
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(stackView)
        
        let dateLabelConstraint = [
            dateLabel.heightAnchor.constraint(equalToConstant: 90),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ]
        
        let stackViewConstraint = [
            stackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ]
        
        NSLayoutConstraint.activate(dateLabelConstraint)
        NSLayoutConstraint.activate(stackViewConstraint)
        
    }
    
    func configure(_ deal: Deal) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss dd.MM.yyyy"
        
        instrumentNameLabel.text = deal.instrumentName
        while instrumentNameLabel.text?.count ?? 0 < 12 {
            instrumentNameLabel.text = (instrumentNameLabel.text ?? "") + " "
        }
        dateLabel.text = dateFormatter.string(from: deal.dateModifier)
        priceLabel.text = String(format: "%.2f", deal.price)
        amountLabel.text = String(Int(deal.amount))
        sideLabel.text = String(describing: deal.side).capitalized
        if deal.side == Deal.Side.buy {
            sideLabel.textColor = .green
        } else {
            sideLabel.textColor = .red
        }
        
        
    }
}
