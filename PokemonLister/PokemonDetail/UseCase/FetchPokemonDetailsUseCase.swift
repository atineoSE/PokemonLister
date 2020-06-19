//
//  FetchPokemonDetailsUseCase.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation

protocol FetchPokemonDetailsUseCaseDelegate {
    func didRetrieve(pokemon: PokemonViewModel)
}

class FetchPokemonDetailsUseCase {
    private let networkController: NetworkController
    private let delegate: FetchPokemonDetailsUseCaseDelegate
    
    init(networkController: NetworkController, delegate: FetchPokemonDetailsUseCaseDelegate) {
        self.networkController = networkController
        self.delegate = delegate
    }
    
    func fetchPokemon(with name: String) {
        let url = PokemonAPI.pokemonURL(for: name)
        networkController.get(url: url) { [weak self] (result: Result<Pokemon, Error>) in
            if let pokemon = try? result.get() {
                print(pokemon)
                DispatchQueue.main.async {
                    self?.delegate.didRetrieve(pokemon: pokemon.viewModel)
                }
            }
        }
    }
}
