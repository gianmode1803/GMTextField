//
//  GMTextFieldSingularLineDelegate+Implementation.swift
//  GMTextField
//
//  Created by Gianpiero Mode on 09/10/2020.
//

import Foundation

public extension GMTextFieldSingularLineDelegate {
    func GMTextFieldDidEndEditing(_ textField: UITextField) {}
    func GMTextFieldDidChangeSelection(_ textField: UITextField) {}
    func GMTextFieldShouldReturn(_ textField: UITextField) -> Bool { return true }
    func GMTextFieldShouldBeginEditing(_ textField: UITextField) -> Bool { return true }
    func GMTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { return true }
    func GMTextFieldShouldClear(_ textField: UITextField) -> Bool { return true }
}
