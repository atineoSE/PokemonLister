//
//  PokemonDetailDataSource.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import UIKit

// MARK: Types
enum PokemonDetailRowType: RowType {
    case name(String)
    case images([UIImage])
    case properties((String, [String]))
    
    var cellType: UITableViewCell.Type {
        switch self {
        case .name(_): return PokemonNameTableViewCell.self
        case .images(_): return PokemonImagesTableViewCell.self
        case .properties(_): return PokemonPropertiesTableViewCell.self
        }
    }
}

// MARK: Protocols
protocol PokemonDetailRowConfigurable {
    func configure(with row: PokemonDetailRowType)
}

// MARK: DataSource
class PokemonDetailDataSource: NSObject {
    private var organizer: DataOrganizer
    
    init(pokemon: PokemonViewModel) {
        organizer = DataOrganizer(pokemon: pokemon)
    }
}

// MARK: RowTypeSourcing
extension PokemonDetailDataSource: RowTypeSourcing {
    static var rowTypes: [RowType] {
        return [PokemonDetailRowType.name(""),
                PokemonDetailRowType.images([])]
    }
}

// MARK: UITableViewDataSource
extension PokemonDetailDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizer.rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = organizer.row(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(with: row.cellType, for: indexPath)
        if let configurableCell = cell as? PokemonDetailRowConfigurable {
            configurableCell.configure(with: row)
        }
        return cell
    }
}

// MARK: DataOrganizer
extension PokemonDetailDataSource {
    struct DataOrganizer {
        var pokemon: PokemonViewModel
        var rows: [PokemonDetailRowType]
        
        var rowsCount: Int {
            return rows.count
        }
        
        init(pokemon: PokemonViewModel) {
            self.pokemon = pokemon
            rows = [.name(pokemon.name)]
        }
        
        func row(at index: Int) -> PokemonDetailRowType {
            return rows[index]
        }
        
    }
}
