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
    let persistenceController: PersistenceController
    
    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    init() {
        let urlSession = URLSession(configuration: .default)
        let networkController = NetworkController(session: urlSession)
        persistenceController = PersistenceController(networkController: networkController)
    }

    func configure(_ pokemonListViewController: PokemonListViewController) {
        let fetchPokemonListUseCase = FetchPokemonListUseCase(persistenceController: persistenceController, delegate: pokemonListViewController)
        pokemonListViewController.fetchPokemonListUseCase = fetchPokemonListUseCase
        pokemonListViewController.coordinator = self
    }
}
