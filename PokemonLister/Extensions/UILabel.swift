//
//  UILabel.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import UIKit

class PaddedLabel: UILabel {
    var verticalPadding: CGFloat = 0
    var horizontalPadding: CGFloat = 24
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + horizontalPadding, height: size.height + verticalPadding)
    }
}
