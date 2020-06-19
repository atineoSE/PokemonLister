//
//  PokemonListDataSource.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import UIKit

// MARK: DataSource
class PokemonListDataSource: NSObject {
    private var organizer: DataOrganizer
    
    override init() {
        organizer = DataOrganizer()
    }
    
    func add(_ pokemonList: [PokemonSummaryViewModel]) {
        organizer.append(page: pokemonList)
    }
    
    func pokemonViewModel(at indexPath: IndexPath) -> PokemonSummaryViewModel {
        return organizer[indexPath.row]
    }

}

// MARK: UITableViewDataSource
extension PokemonListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizer.rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemonSummaryViewModel = organizer[indexPath.row]
        let cell = tableView.dequeueReusableCell(with: PokemonTableViewCell.self, for: indexPath)
        cell.configure(with: pokemonSummaryViewModel)
        return cell
    }
}

// MARK: DataOrganizer
extension PokemonListDataSource {
    struct DataOrganizer {
        var pokemonList: [PokemonSummaryViewModel] = []
        
        var rowsCount: Int {
            return pokemonList.count
        }
        subscript(index: Int) -> PokemonSummaryViewModel {
            return pokemonList[index]
        }
        
        mutating func append(page: [PokemonSummaryViewModel]) {
            pokemonList.append(contentsOf: page)
        }
    }
}
