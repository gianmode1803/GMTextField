//
//  GMTextFieldMultipleLinesDelegate+Implementation.swift
//  GMTextField
//
//  Created by Gianpiero Mode on 09/10/2020.
//

import Foundation

public extension GMTextFieldMultipleLinesDelegate {
    func GMTextFieldMultipleLinesDidChange(_ textView: UITextView) {}
    func GMTextFielMultipleLinesDidBeginEditing(_ textView: UITextView) {}
    func GMTextFieldMultipleLinesDidEndEditing(_ textView: UITextView) {}
    func GMTextFieldMultipleLinesDidChangeSelection(_ textView: UITextView) {}
    func GMTextFieldMultipleLines(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool { return true}
    func GMTextFieldMultipleLines(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool { return true}
    func GMTextFieldMultipleLines(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool { return true}
}
