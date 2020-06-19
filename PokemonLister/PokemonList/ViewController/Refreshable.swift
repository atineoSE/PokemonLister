//
//  Refreshable.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import UIKit

@objc protocol Refreshable: AnyObject {
    var tableView: UITableView! { get }
    @objc func refresh()
}

extension Refreshable {
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func beginRefreshing() {
        tableView.refreshControl?.beginRefreshing()
    }
    
    func endRefreshing() {
        tableView.refreshControl?.endRefreshing()
    }
}

