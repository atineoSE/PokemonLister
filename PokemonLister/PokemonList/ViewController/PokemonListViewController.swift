//
//  PokemonListViewController.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController, Refreshable {
    @IBOutlet weak var tableView: UITableView!
    
    var fetchPokemonListUseCase: FetchPokemonListUseCase?
    let dataSource: PokemonListDataSource  = PokemonListDataSource()
    weak var coordinator: PokemonListCoordinating?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCellType()
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        setupRefreshControl()
        refresh()
    }
    
    private func registerCellType() {
        let identifier = String(describing: PokemonTableViewCell.self)
        let nib = UINib.init(nibName: identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }

    @objc
    func refresh() {
        beginRefreshing()
        fetchPokemonListUseCase?.fetchPokemonList()
    }
    
    private func updateUI(with pokemonList: [PokemonSummaryViewModel]) {
        dataSource.add(pokemonList)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }

}

// MARK: UITableViewDelegate
extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemonName = dataSource.pokemonViewModel(at: indexPath).name
        coordinator?.pokemonListViewController(self, didSelectPokemonWithName: selectedPokemonName)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        fetchPokemonListUseCase?.fetchPokemonList()
    }
}


// MARK: FetchPokemonListUseCaseDelegate
extension PokemonListViewController: FetchPokemonListUseCaseDelegate {
    func didRetrieve(pokemonList: [PokemonSummaryViewModel]) {
        tableView.separatorStyle = .singleLine
        endRefreshing()
        updateUI(with: pokemonList)
    }
}
