//
//  UIImageExtensionTests.swift
//  PokemonListerTests
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import XCTest
@testable import PokemonLister

class UIImageExtensionTests: XCTestCase {

    func testImageWithoutIdReturnsDefaultImage() {
        XCTAssertEqual(UIImage.mainImage(pokemonId: nil).pngData(), UIImage.unknownPokemonImage.pngData())
    }
    
    func testImageForUnknownIdReturnsDefaultImage() {
        XCTAssertEqual(UIImage.mainImage(pokemonId: "blabla").pngData(), UIImage.unknownPokemonImage.pngData())
    }
    
    func testImageForExistingIdReturnsDefaultImage() {
        let imageUrl = Bundle.main.url(forResource: "1", withExtension: "png", subdirectory: "Images", localization: nil)!
        let imageData = try! Data(contentsOf: imageUrl)
        let expectedImage = UIImage(data: imageData)!
        XCTAssertEqual(UIImage.mainImage(pokemonId: "1").pngData(), expectedImage.pngData())
    }
    
    
}
