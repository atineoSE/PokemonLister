//
//  PokemonDetailViewController.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, Refreshable {
    
    static let identifier = "PokemonDetail"
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: PokemonDetailDataSource?
    var fetchPokemonDetailsUseCase: FetchPokemonDetailsUseCase?
    var pokemonName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //registerCellType()
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        navigationItem.title = pokemonName
        
        setupRefreshControl()
        refresh()
    }
    
    @objc
    func refresh() {
        guard let pokemonName = pokemonName else { return }
        beginRefreshing()
        fetchPokemonDetailsUseCase?.fetchPokemon(with: pokemonName)
    }
    
    private func updateUI(with pokemon: PokemonViewModel) {
        dataSource = PokemonDetailDataSource(pokemon: pokemon)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
}

// MARK: UITableViewDelegate
extension PokemonDetailViewController: UITableViewDelegate {
    
}


// MARK: FetchPokemonListUseCaseDelegate
extension PokemonDetailViewController: FetchPokemonDetailsUseCaseDelegate {
    func didRetrieve(pokemon: PokemonViewModel) {
        endRefreshing()
        updateUI(with: pokemon)
    }
}
