//
//  ModelTests.swift
//  PokemonListerTests
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import XCTest
@testable import PokemonLister

class ModelTests: XCTestCase {

    func testItemIdIsSuccessfullyExtractedFromURL() {
        // Arrange
        let item = Item(name: "charmander", url: URL(string: "https://pokeapi.co/api/v2/pokemon/4/")!)
        
        // Act
        let id = item.id
        
        // Assert
        XCTAssertEqual(id, "4")
    }

    func testItemDoesNotReturnSummaryViewModelIfNotPokemonDetailURL() {
        // Arrange
        let item = Item(name: "chlorophyll", url: URL(string: "https://pokeapi.co/api/v2/ability/34/")!)
        
        // Act
        let summaryViewModel = item.pokemonSummaryViewModel
        
        // Assert
        XCTAssertNil(summaryViewModel)
    }
    
    func testItemReturnSummaryViewModelIfPokemonDetailURL() {
        // Arrange
        let item = Item(name: "charmander", url: URL(string: "https://pokeapi.co/api/v2/pokemon/4/")!)
        
        // Act
        let summaryViewModel = item.pokemonSummaryViewModel
        
        // Assert
        XCTAssertNotNil(summaryViewModel)
    }
    
}
