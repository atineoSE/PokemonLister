//
//  PokemonListCoordinating.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation

protocol PokemonListCoordinating: AnyObject {
    func pokemonListViewController(_ pokemonListViewController: PokemonListViewController, didSelectPokemonWithName name:String)
}

extension Coordinator: PokemonListCoordinating {
    func pokemonListViewController(_ pokemonListViewController: PokemonListViewController, didSelectPokemonWithName name: String) {
        guard let pokemonDetailViewController = mainStoryboard.instantiateViewController(withIdentifier: PokemonDetailViewController.identifier) as? PokemonDetailViewController else { return }
        let fetchPokemonDetailsUseCase = FetchPokemonDetailsUseCase(persistenceController: persistenceController, delegate: pokemonDetailViewController)
        pokemonDetailViewController.fetchPokemonDetailsUseCase = fetchPokemonDetailsUseCase
        pokemonDetailViewController.pokemonName = name
        pokemonListViewController.show(pokemonDetailViewController, sender: nil)
    }
}
