//
//  FetchPokemonListUseCase.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation

protocol FetchPokemonListUseCaseDelegate: AnyObject {
    func didRetrieve(pokemonList: [PokemonSummaryViewModel])
}

class FetchPokemonListUseCase {
    private let persistenceController: PersistenceController
    private weak var delegate: FetchPokemonListUseCaseDelegate?
    private var nextUrl: URL?
    private var canContinueFetching: Bool = true
    
    init(persistenceController: PersistenceController, delegate: FetchPokemonListUseCaseDelegate) {
        self.persistenceController = persistenceController
        self.delegate = delegate
    }
    
    func fetchPokemonList() {
        guard canContinueFetching else { return }
        
        let fetchURL = nextUrl ?? PokemonAPI.pokemonURL
        
        persistenceController.fetch(url: fetchURL) { [weak self] (pokemonList: PokemonList?) in
            guard let pokemonList = pokemonList else { return }

            let pokemonItemList = pokemonList.results
            if let next = pokemonList.next {
                self?.nextUrl = next
            } else {
                self?.nextUrl = nil
                self?.canContinueFetching = false
            }
            let pokemonSummaryViewModelList = pokemonItemList.compactMap { $0.pokemonSummaryViewModel }
            DispatchQueue.main.async {
                self?.delegate?.didRetrieve(pokemonList: pokemonSummaryViewModelList)
            }
        }
    }
}
