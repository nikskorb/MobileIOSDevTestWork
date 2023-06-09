//
//  Reusable.swift
//  MobileiOSDevTestWork
//
//  Created by Larry Livingston on 07.06.2023.
//

import UIKit
protocol Reusable {
    static var identifier: String {
        get
    }
}

extension Reusable {
    static var identifier: String {
        String(describing: Self.self)
    }
}

extension DealCell: Reusable {
    
}

extension HeaderCell: Reusable {
    
}
