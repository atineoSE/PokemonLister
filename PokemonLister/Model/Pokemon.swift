//
//  Pokemon.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import UIKit


struct Pokemon: Decodable {
    let name: String
}


struct PokemonViewModel {
    let name: String
}
