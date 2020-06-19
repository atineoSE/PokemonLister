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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
}
