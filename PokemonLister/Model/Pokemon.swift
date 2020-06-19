//
//  Pokemon.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import UIKit

struct Item: Decodable {
    let name: String
    let url: URL
}

struct PokemonList: Decodable {
    let results: [Item]
}

extension Item {
    var id: String? {
        let urlAsString = url.absoluteString
        guard let id = urlAsString.split(separator: "/").last else {
            return nil
        }
        return String(id)
    }
    
    var pokemonSummaryViewModel: PokemonSummaryViewModel? {
        guard url.absoluteString.contains("pokemon") else { return nil }
        
        let image = UIImage.mainImage(pokemonId: id)
        return PokemonSummaryViewModel(image: image, name: name)
    }
}

struct Pokemon: Decodable {
    struct PokemonType: Decodable {
        let type: Item
    }
    struct PokemonAbility: Decodable {
        let ability: Item
    }
    struct PokemonMove: Decodable {
        let move: Item
    }
    
    let name: String
    let height: Int
    let weight: Int
    let baseExperience: Int
    let types: [PokemonType]
    let abilities: [PokemonAbility]
    let moves: [PokemonMove]
}

extension Pokemon {
    var viewModel: PokemonViewModel {
        let characteristics = ["Base experience: \(baseExperience)",
                                "Weight: \(weight)",
                                "Height: \(height)"]
        
        return PokemonViewModel(name: name,
                                images: [],
                                characteristics: characteristics,
                                abilities: abilities.map { $0.ability.name },
                                moves: moves.map { $0.move.name },
                                types: types.map { $0.type.name })
    }
}

struct PokemonViewModel {
    let name: String
    let images: [UIImage]
    let characteristics: [String]
    let abilities: [String]
    let moves: [String]
    let types: [String]
}
