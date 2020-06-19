//
//  PokemonAPI.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation

struct PokemonAPI {
    static var baseURL = URL(string:"https://pokeapi.co/api/v2/")!
    static var pokemonURL = PokemonAPI.baseURL.appendingPathComponent("pokemon")
}
