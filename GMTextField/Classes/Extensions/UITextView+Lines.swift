//
//  UITextView+Lines.swift
//  GMTextFiekd
//
//  Created by Gianpiero Mode on 25/07/2020.
//  Copyright © 2020 Gianpiero Mode. All rights reserved.
//
// Extension by Luke Chase from https://stackoverflow.com/questions/31663159/get-number-of-lines-in-uitextview-without-contentsize-height

import Foundation
import UIKit

extension UITextView {
    
    func numberOfLines() -> Int {
        let layoutManager = self.layoutManager
        let numberOfGlyphs = layoutManager.numberOfGlyphs
        var lineRange: NSRange = NSMakeRange(0, 1)
        var index = 0
        var numberOfLines = 0

        while index < numberOfGlyphs {
            layoutManager.lineFragmentRect(
                forGlyphAt: index, effectiveRange: &lineRange
            )
            index = NSMaxRange(lineRange)
            numberOfLines += 1
        }
        return numberOfLines
    }
}
