//
//  PokemonListDataSourceTests.swift
//  PokemonListerTests
//
//  Created by Adrian Tineo on 20.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import XCTest
@testable import PokemonLister

class PokemonListDataSourceTests: XCTestCase {

    func testLoadingCellIsAlwaysLast() {
        let pokemonList = Array.init(repeating: PokemonSummaryViewModel.dummyViewModel, count: 20)
        var sut = PokemonListDataSource.DataOrganizer()
        
        sut.append(pokemonList: pokemonList)
        XCTAssertEqual(sut.rows.count, 21)
        if case .loading = sut.rows.last! {
        } else {
            XCTFail("Expecting last row to be the loading type")
        }
        
        sut.append(pokemonList: pokemonList)
        XCTAssertEqual(sut.rows.count, 41)
        if case .loading = sut.rows.last! {
        } else {
            XCTFail("Expecting last row to be the loading type")
        }
    }
}
