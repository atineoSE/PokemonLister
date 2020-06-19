//
//  FetchPokemonDetailsUseCase.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation

protocol FetchPokemonDetailsUseCaseDelegate: AnyObject {
    func didRetrieve(pokemon: PokemonViewModel)
}

class FetchPokemonDetailsUseCase {
    private let persistenceController: PersistenceController
    private weak var delegate: FetchPokemonDetailsUseCaseDelegate?
    
    init(persistenceController: PersistenceController, delegate: FetchPokemonDetailsUseCaseDelegate) {
        self.persistenceController = persistenceController
        self.delegate = delegate
    }
    
    func fetchPokemon(with name: String) {
        let url = PokemonAPI.pokemonURL(for: name)
        
        persistenceController.fetch(url: url) { [weak self] (pokemon: Pokemon?) in
            guard let pokemon = pokemon else { return }
            DispatchQueue.main.async {
                self?.delegate?.didRetrieve(pokemon: pokemon.viewModel)
            }
        }
    }
}
