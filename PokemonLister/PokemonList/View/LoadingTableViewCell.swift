//
//  LoadingTableViewCell.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 20.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

// MARK: Cell
class LoadingTableViewCell: UITableViewCell {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
}

// MARK: PokemonListRowConfigurable
extension LoadingTableViewCell: PokemonListRowConfigurable {
    func configure(with row: PokemonListRowType) {
        if case .loading = row {
            loadingIndicator.startAnimating()
        }
    }
}
