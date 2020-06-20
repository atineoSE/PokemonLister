//
//  PokemonImagesTableViewCell.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class PokemonImagesTableViewCell: UITableViewCell {
    @IBOutlet weak var imagesStackView: UIStackView!
}

extension PokemonImagesTableViewCell : PokemonDetailRowConfigurable {
    func configure(with row: PokemonDetailRowType) {
        if case .images(let images) = row {
            // clear previous state
            for view in imagesStackView.arrangedSubviews {
                view.removeFromSuperview()
            }
            
            // load images
            for image in images {
                let newImageView = UIImageView(image: image)
                imagesStackView.addArrangedSubview(newImageView)
            }
        }
    }
}
