//
//  PokemonTableViewCell.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

// MARK: Cell
class PokemonTableViewCell: UITableViewCell {
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
}

// MARK: PokemonListRowConfigurable
extension PokemonTableViewCell: PokemonListRowConfigurable {
    func configure(with row: PokemonListRowType) {
        if case .summary(let summaryViewModel) = row {
            pokemonImageView.image = summaryViewModel.image
            pokemonNameLabel.text = summaryViewModel.name
        }
    }
}
