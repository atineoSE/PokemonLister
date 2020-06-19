//
//  TableViewRows.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import UIKit

protocol RowType {
    var cellType: UITableViewCell.Type { get }
    var identifier: String { get }
}

extension RowType {
    var identifier: String {
        return String(describing: self.cellType)
    }
}
protocol RowTypeSourcing {
    static var rowTypes: [RowType] { get }
}
