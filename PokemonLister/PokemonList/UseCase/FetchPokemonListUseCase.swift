//
//  FetchPokemonListUseCase.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation

protocol FetchPokemonListUseCaseDelegate {
    func didRetrieve(pokemonList: [PokemonSummaryViewModel])
}

class FetchPokemonListUseCase {
    private let networkController: NetworkController
    private let delegate: FetchPokemonListUseCaseDelegate
    
    init(networkController: NetworkController, delegate: FetchPokemonListUseCaseDelegate) {
        self.networkController = networkController
        self.delegate = delegate
    }
    
    func fetchPokemonList() {
        networkController.get(url: PokemonAPI.pokemonURL) { [weak self] (result: Result<PokemonList,Error>) in
            if let pokemonItemList = try? result.get().results {
                DispatchQueue.main.async {
                    let pokemonList = pokemonItemList.compactMap { $0.pokemonSummaryViewModel }
                    self?.delegate.didRetrieve(pokemonList: pokemonList)
                }
            }
        }
    }
}
