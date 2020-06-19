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
    var dataSource: PokemonListDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        dataSource = PokemonListDataSource(pokemonList:pokemonList)
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
}

extension PokemonListViewController: UITableViewDelegate {
    
}

extension PokemonListViewController: FetchPokemonListUseCaseDelegate {
    func didRetrieve(pokemonList: [PokemonSummaryViewModel]) {
        tableView.separatorStyle = .singleLine
        endRefreshing()
        updateUI(with: pokemonList)
    }
    
    
}
