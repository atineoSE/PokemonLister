//
//  PokemonList.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation


struct PokemonList: Decodable {
    struct PokemonItem: Decodable {
        let name: String
        let url: URL
    }
    
    let results: [PokemonItem]
}
