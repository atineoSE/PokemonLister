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
    static var unknownPokemonImage: UIImage {
        let imageUrl = Bundle.main.url(forResource: "0", withExtension: "png", subdirectory: "Images", localization: nil)!
        let imageData = try! Data(contentsOf: imageUrl)
        return UIImage(data: imageData)!
    }
    
    static func mainImage(pokemonId: String?) -> UIImage {
        guard let pokemonId = pokemonId else { return UIImage.unknownPokemonImage }
        
        guard let mainImageUrl = Bundle.main.url(forResource: pokemonId, withExtension: "png", subdirectory: "Images", localization: nil),
        let imageData = try? Data(contentsOf: mainImageUrl),
        let image = UIImage(data: imageData) else {
            return UIImage.unknownPokemonImage
        }
        
        return image
    }
    
    static func allImages(pokemonId: Int) -> [UIImage] {
        // Note: this is O(N) with the number of images.
        // If having too many images, another approach is recommended (e.g. subfolders by id)
        guard let urls = Bundle.main.urls(forResourcesWithExtension: "png", subdirectory: "Images") else { return [UIImage.unknownPokemonImage] }
        
        let pokemonUrls = urls.filter { url in
            guard let filename = url.pathComponents.last else { return false }
            return filename.starts(with: "\(pokemonId).") || filename.starts(with: "\(pokemonId)-")
        }

        return pokemonUrls.compactMap({ try? Data(contentsOf: $0)}).compactMap({ UIImage(data: $0) })
    }
}
