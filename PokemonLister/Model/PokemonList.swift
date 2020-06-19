//
//  PokemonList.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import UIKit

struct PokemonList: Decodable {
    struct PokemonItem: Decodable {
        let name: String
        let url: URL
    }
    
    let results: [PokemonItem]
}

extension PokemonList.PokemonItem {
    var pokemonId: String? {
        let urlAsString = url.absoluteString
        guard let id = urlAsString.split(separator: "/").last else {
            return nil
        }
        return String(id)
    }
    
    var summaryViewModel: PokemonSummaryViewModel {
        let image = UIImage.mainImage(pokemonId: pokemonId)
        return PokemonSummaryViewModel(image: image, name: name)
    }
}
