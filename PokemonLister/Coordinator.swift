//
//  Coordinator.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import UIKit

class Coordinator {
    let networkController: NetworkController
    
    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    init() {
        let urlSession = URLSession(configuration: .default)
        self.networkController = NetworkController(session: urlSession)
    }

    func configure(_ pokemonListViewController: PokemonListViewController) {
        let fetchPokemonListUseCase = FetchPokemonListUseCase(networkController: networkController, delegate: pokemonListViewController)
        pokemonListViewController.fetchPokemonListUseCase = fetchPokemonListUseCase
        pokemonListViewController.coordinator = self
    }
}
