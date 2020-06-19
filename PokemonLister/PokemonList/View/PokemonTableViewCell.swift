//
//  PokemonTableViewCell.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with pokemonSummaryViewModel: PokemonSummaryViewModel) {
        pokemonImageView.image = pokemonSummaryViewModel.image
        pokemonNameLabel.text = pokemonSummaryViewModel.name
    }
}
