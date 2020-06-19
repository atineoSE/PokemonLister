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
        return PokemonViewModel(name: name)
    }
}

struct PokemonViewModel {
    let name: String
}
