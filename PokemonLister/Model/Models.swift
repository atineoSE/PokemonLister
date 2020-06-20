//
//  Pokemon.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import UIKit

struct Item: Codable {
    let name: String
    let url: URL
}

struct PokemonList: Codable {
    let results: [Item]
    let next: URL?
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

struct Pokemon: Codable {
    struct PokemonType: Codable {
        let type: Item
    }
    struct PokemonAbility: Codable {
        let ability: Item
    }
    struct PokemonMove: Codable {
        let move: Item
    }
    let id: Int
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
        let characteristicsViewModel = PropertiesViewModel(title: "Characteristics",
                                                  properties: ["Base experience: \(baseExperience)",
                                                                "Weight: \(weight)",
                                                                "Height: \(height)"])
        
        let abilitiesViewModel = PropertiesViewModel(title: "Abilities",
                                                  properties: abilities.map { $0.ability.name })
        let movesViewModel = PropertiesViewModel(title: "Moves",
                                                  properties: moves.map { $0.move.name })
        let typesViewModel = PropertiesViewModel(title: "Types",
                                                  properties: types.map { $0.type.name })
        
        return PokemonViewModel(name: name,
                                images: UIImage.allImages(pokemonId: id),
                                characteristics: characteristicsViewModel,
                                abilities: abilitiesViewModel,
                                moves: movesViewModel,
                                types: typesViewModel)
    }
}

struct PokemonViewModel {
    let name: String
    let images: [UIImage]
    let characteristics: PropertiesViewModel
    let abilities: PropertiesViewModel
    let moves: PropertiesViewModel
    let types: PropertiesViewModel
}

struct PropertiesViewModel {
    let title: String
    let properties: [String]
}

extension PropertiesViewModel {
    static var dummyViewModel: PropertiesViewModel {
        return PropertiesViewModel(title: "", properties: [])
    }
}
