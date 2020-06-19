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
    private let networkController: NetworkController
    private weak var delegate: FetchPokemonListUseCaseDelegate?
    private var nextUrl: URL?
    private var canContinueFetching: Bool = true
    
    init(networkController: NetworkController, delegate: FetchPokemonListUseCaseDelegate) {
        self.networkController = networkController
        self.delegate = delegate
    }
    
    func fetchPokemonList() {
        guard canContinueFetching else { return }
        
        let fetchURL = nextUrl ?? PokemonAPI.pokemonURL
        networkController.get(url: fetchURL) { [weak self] (result: Result<PokemonList,Error>) in
            if let pokemonList = try? result.get() {
                let pokemonItemList = pokemonList.results
                if let next = pokemonList.next {
                    self?.nextUrl = next
                } else {
                    self?.nextUrl = nil
                    self?.canContinueFetching = false
                }
                
                DispatchQueue.main.async {
                    let pokemonList = pokemonItemList.compactMap { $0.pokemonSummaryViewModel }
                    self?.delegate?.didRetrieve(pokemonList: pokemonList)
                }
            }
        }
    }
}
