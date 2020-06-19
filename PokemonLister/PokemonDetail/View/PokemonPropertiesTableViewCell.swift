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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setNeedsLayout()
    }
    
}

extension PokemonPropertiesTableViewCell: PokemonDetailRowConfigurable {
    func configure(with row: PokemonDetailRowType) {
        if case .properties(let (title, items)) = row {
            propertyNameLabel.text = title
            
            // clear previous content
            for view in propertiesStackView.arrangedSubviews {
                view.removeFromSuperview()
            }

            // add dynamic content
            for item in items {
                let label = UILabel(frame: CGRect.zero)
                label.text = item
                label.font = UIFont.systemFont(ofSize: 15.0)
                label.sizeToFit()
                propertiesStackView.addArrangedSubview(label)
            }
        }
    }
}

