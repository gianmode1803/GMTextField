//
//  GMCustomizationProtocol.swift
//  GMTextFiekd
//
//  Created by Gianpiero Mode on 25/07/2020.
//  Copyright © 2020 Gianpiero Mode. All rights reserved.
//

import Foundation
import UIKit

protocol GMCustomization {
    var leftImage: UIImage? { get set }
    var rightImage: UIImage? { get set }
    var placeHolder: String! { get set }
    var color: UIColor! { get set }
    var textColor: UIColor? { get set }
    var textFont: UIFont? { get set }
    var errorTextFont: UIFont? { get set }
    var placeHolderTextFont: UIFont? { get set }
    var errorColor: UIColor? { get set }
    var verificationOnlyAtEnd: Bool? { get set }
    var numberOfCharacters: Int? { get set }
    var numberOfLines: Int? { get set }
}

extension GMCustomization {

    var numberOfCharacters: Int? {
        get {
            return (numberOfCharacters != nil ? numberOfCharacters : 140)
        }
        set {
            numberOfCharacters = newValue
        }
    }
    
    var numberOfLines: Int? {
        get {
            return (numberOfLines != nil ? numberOfLines : 5)
        }
        set {
            numberOfLines = newValue
        }
    }
}


