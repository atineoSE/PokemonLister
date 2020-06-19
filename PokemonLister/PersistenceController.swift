//
//  PersistenceController.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation

class PersistenceController {
    private let networkController: NetworkController
    
    init(networkController: NetworkController) {
        self.networkController = networkController
    }
    
    private func isAvailableLocally(url: URL) -> Bool {
        return false
    }
    
    func fetch<T>(url: URL, completion: @escaping (T?)->()) where T: Decodable {
        if isAvailableLocally(url: url) {
            // TODO: get from file
        } else {
            networkController.get(url: url) { (result: Result<T,Error>) in
                completion(try? result.get())
            }
        }
    }
}
