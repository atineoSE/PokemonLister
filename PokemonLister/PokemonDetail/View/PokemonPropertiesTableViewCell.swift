//
//  PokemonPropertiesTableViewCell.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

// MARK: Protocols
protocol PokemonPropertiesTableViewCellDelegate {
    func pokemonPropertiesCellDidToggleCollapseState(_ cell: PokemonPropertiesTableViewCell)
}

// MARK: Cell
class PokemonPropertiesTableViewCell: UITableViewCell {
    @IBOutlet weak var propertyNameLabel: UILabel!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var firtstColumnStackView: UIStackView!
    @IBOutlet weak var secondColumnStackView: UIStackView!
    
    var delegate: PokemonPropertiesTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func didTapShowButton(_ sender: UIButton) {
        delegate?.pokemonPropertiesCellDidToggleCollapseState(self)
    }
    
    private func updateUI(with properties: [String], isCollapsed: Bool) {
        
        // configure show more/less button
        if properties.count > 5 {
            showButton.isHidden = false
            let title = isCollapsed ? "- show more" : "- show less"
            showButton.setTitle(title, for: .normal)
        } else {
            showButton.isHidden = true
        }
        
        // clear previous dynamic content
        for view in firtstColumnStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        for view in secondColumnStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        // add dynamic content
        var placeOnFirstColumn = true
        let limit = isCollapsed ? min(5, properties.count) : properties.count
        for item in properties[0..<limit] {
            let label = UILabel(frame: CGRect.zero)
            label.text = item
            label.font = UIFont.systemFont(ofSize: 15.0)
            label.sizeToFit()
            placeOnFirstColumn ? firtstColumnStackView.addArrangedSubview(label) : secondColumnStackView.addArrangedSubview(label)
            placeOnFirstColumn.toggle()
        }
    }

}

// MARK: PokemonDetailRowConfigurable
extension PokemonPropertiesTableViewCell: PokemonDetailRowConfigurable {
    func configure(with row: PokemonDetailRowType) {
        if case .properties(let (propertiesViewModel, isCollapsed)) = row {
            propertyNameLabel.text = propertiesViewModel.title
            updateUI(with: propertiesViewModel.properties, isCollapsed: isCollapsed)
        }
    }
}

