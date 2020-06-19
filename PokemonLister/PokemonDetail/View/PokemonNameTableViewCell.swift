//
//  PokemonNameTableViewCell.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class PokemonNameTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
}

extension PokemonNameTableViewCell : PokemonDetailRowConfigurable {
    func configure(with row: PokemonDetailRowType) {
        if case .name(let name) = row {
            nameLabel.text = name
        }
    }
}
