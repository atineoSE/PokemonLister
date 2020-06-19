//
//  PokemonPropertiesTableViewCell.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class PokemonPropertiesTableViewCell: UITableViewCell {
    @IBOutlet weak var propertiesStackView: UIStackView!
    @IBOutlet weak var propertyNameLabel: UILabel!
}

extension PokemonPropertiesTableViewCell: PokemonDetailRowConfigurable {
    func configure(with row: PokemonDetailRowType) {
        if case .properties(let (title, items)) = row {
            propertyNameLabel.text = title
            for item in items {
                let label = PaddedLabel(frame: CGRect.zero)
                label.text = item
                label.sizeToFit()
                propertiesStackView.addArrangedSubview(label)
            }
        }
    }
}

