//
//  PokemonListDataSource.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import UIKit

// MARK: Types
enum PokemonListRowType: RowType {
    case summary(PokemonSummaryViewModel)
    case loading
    
    var cellType: UITableViewCell.Type {
        switch self {
        case .summary(_): return PokemonTableViewCell.self
        case .loading: return LoadingTableViewCell.self
        }
    }
}

// MARK: Protocols
protocol PokemonListRowConfigurable {
    func configure(with row: PokemonListRowType)
}

// MARK: DataSource
class PokemonListDataSource: NSObject {
    private var organizer: DataOrganizer
    
    override init() {
        organizer = DataOrganizer()
    }
    
    func add(_ pokemonList: [PokemonSummaryViewModel]) {
        organizer.append(pokemonList: pokemonList)
    }
    
    func pokemonViewModel(at indexPath: IndexPath) -> PokemonSummaryViewModel? {
        return organizer.pokemonViewModel(at: indexPath.row)
    }
}

// MARK: RowTypeSourcing
extension PokemonListDataSource: RowTypeSourcing {
    static var rowTypes: [RowType] {
        return [PokemonListRowType.summary(PokemonSummaryViewModel.dummyViewModel),
                PokemonListRowType.loading]
    }
}

// MARK: UITableViewDataSource
extension PokemonListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizer.rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = organizer.row(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(with: row.cellType, for: indexPath)
        if let configurableCell = cell as? PokemonListRowConfigurable {
            configurableCell.configure(with: row)
        }
        return cell
    }
}

// MARK: DataOrganizer
private extension PokemonListDataSource {
    struct DataOrganizer {
        var rows: [PokemonListRowType] = []

        var rowsCount: Int {
            return rows.count
        }
        
        func pokemonViewModel(at index: Int) -> PokemonSummaryViewModel? {
            let row = rows[index]
            if case .summary(let summaryViewModel) = row {
                return summaryViewModel
            } else {
                return nil
            }
        }
        
        func row(at index: Int) -> PokemonListRowType {
            return rows[index]
        }
        
        mutating func append(pokemonList: [PokemonSummaryViewModel]) {
            removeLoadingCell()
            rows += pokemonList.map { PokemonListRowType.summary($0) } + [.loading]
        }
        
        mutating func removeLoadingCell() {
            guard let last = rows.last else { return }
            if case .loading = last {
                rows = rows.dropLast()
            }
        }
        
    }
}
