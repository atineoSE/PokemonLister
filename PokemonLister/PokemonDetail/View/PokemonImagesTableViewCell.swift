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
    @IBOutlet weak var firstImageView: UIImageView!
    
}

extension PokemonImagesTableViewCell : PokemonDetailRowConfigurable {
    func configure(with row: PokemonDetailRowType) {
        if case .images(let images) = row {
            guard let firstImage = images.first else {
                firstImageView.image = UIImage.unknownPokemonImage
                return
            }
            firstImageView.image = firstImage
            
            images.dropFirst().forEach { image in
                let newImageView = UIImageView(image: image)
                imagesStackView.addArrangedSubview(newImageView)
            }
        }
    }
}
