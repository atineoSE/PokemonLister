//
//  PokemonDetailViewController.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController, Refreshable {
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: PokemonDetailDataSource?
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
        beginRefreshing()
        
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



