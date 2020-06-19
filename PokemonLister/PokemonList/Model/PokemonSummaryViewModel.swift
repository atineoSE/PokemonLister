//
//  PokemonSummaryViewModel.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import UIKit

struct PokemonSummaryViewModel {
    let image: UIImage
    let name: String
}

extension PokemonSummaryViewModel {
    static var dummyViewModel: PokemonSummaryViewModel {
        return PokemonSummaryViewModel(image: UIImage.unknownPokemonImage, name: "name")
    }
}
