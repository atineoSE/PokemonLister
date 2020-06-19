//
//  UIImage.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static private func unknownPokemonImage() -> UIImage {
        let imageUrl = Bundle.main.url(forResource: "0", withExtension: "png", subdirectory: "Images", localization: nil)!
        let imageData = try! Data(contentsOf: imageUrl)
        return UIImage(data: imageData)!
    }
    
    static func mainImage(pokemonId: String?) -> UIImage {
        guard let pokemonId = pokemonId else { return UIImage.unknownPokemonImage() }
        
        guard let mainImageUrl = Bundle.main.url(forResource: pokemonId, withExtension: "png", subdirectory: "Images", localization: nil),
        let imageData = try? Data(contentsOf: mainImageUrl),
        let image = UIImage(data: imageData) else {
            return UIImage.unknownPokemonImage()
        }
        
        return image
    }
}
