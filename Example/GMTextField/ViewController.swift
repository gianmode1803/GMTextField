//
//  ViewController.swift
//  GMTextFiekd
//
//  Created by Gianpiero Mode on 16/07/2020.
//  Copyright © 2020 Gianpiero Mode. All rights reserved.
//

import UIKit
import GMTextField

class ViewController: UIViewController {

    @IBOutlet weak var textField: GMTextFieldSingularLine!
    @IBOutlet weak var textView: GMTextFieldMultipleLines!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.errorText = "Error, revise los datos"
        textView.errorColor = .red
        textView.textValidation = { text in
            return true
        }
        textView.color = .brown
        textView.leftImage = nil
        textView.rightImage = UIImage(systemName: "location")?.withTintColor(.black)
        textView.numberOfLines = 3
        
        textView.placeHolder = "Prueba1"
        
        
        
        
        
        
        
        
        
        // Do any additional setup after loading the view.
        textField.placeHolder = "Prueba0"
        textField.animationType = .scaleMinimize
        textField.verificationOnlyAtEnd = true
        textField.errorColor = .red
        textField.leftImage = nil
        textField.rightImage = UIImage(systemName: "location")?.withTintColor(.black)
        textField.errorText = "Error, revise los datos"
        
        textField.textValidation = { text in
            return false
        }
        
        
        
        
        
        
        
        
        
        
        textField.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textView.animate()
    }


}

