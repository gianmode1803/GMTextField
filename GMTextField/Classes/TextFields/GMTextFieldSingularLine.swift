//
//  GMTextField.swift
//  GMTextFiekd
//
//  Created by Gianpiero Mode on 16/07/2020.
//  Copyright © 2020 Gianpiero Mode. All rights reserved.
//

import UIKit

public protocol GMTextFieldSingularLineDelegate{
    func GMTextFieldDidEndEditing(_ textField: UITextField)
    func GMTextFieldDidChangeSelection(_ textField: UITextField)
    func GMTextFieldShouldReturn(_ textField: UITextField) -> Bool
    func GMTextFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    func GMTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    func GMTextFieldShouldClear(_ textField: UITextField) -> Bool
}

@IBDesignable
public class GMTextFieldSingularLine: UIView, GMCustomization {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var mainStack: UIStackView!
    @IBOutlet private weak var mainHorizontalStack: UIStackView!
    @IBOutlet private weak var leftImageView: UIImageView!
    @IBOutlet private weak var labelStackView: UIStackView!
    @IBOutlet private weak var placeHolderLabel: UILabel!
    @IBOutlet private weak var rightImageView: UIImageView!
    @IBOutlet private weak var separatorView: UIView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var errorHorizontalStack: UIStackView!
    @IBOutlet weak var leftStack: UIStackView!
    @IBOutlet weak var rightStack: UIStackView!
    
    @IBOutlet private weak var leftSpaceViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var rightSpaceViewHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet public weak var textField: UITextField!

    //MARK: - Compiled Properties
    
    @IBInspectable
    public var leftImage: UIImage? {
        didSet{
            guard leftImage != nil else {
                leftImageView.removeFromSuperview()
                leftStack.removeFromSuperview()
                return
            }
            leftImageView.image = leftImage
            leftImageView.isHidden = false
        }
    }
    
    @IBInspectable
    public var rightImage: UIImage? {
        didSet{
            guard rightImage != nil else {
                rightImageView.removeFromSuperview()
                rightStack.removeFromSuperview()
                return
            }
            rightImageView.image = rightImage
            rightImageView.isHidden = false
        }
    }
    
    @IBInspectable
    public var placeHolder: String! {
        didSet{
            placeHolderLabel.text = placeHolder
        }
    }
    
    @IBInspectable
    public var color: UIColor! {
        didSet{
            separatorView.backgroundColor = color
            placeHolderLabel.textColor = color
        }
    }

    @IBInspectable
    public var textColor: UIColor? = .black{
        didSet{
            self.textField.textColor = textColor
        }
    }

    @IBInspectable
    public var textFont: UIFont? = .systemFont(ofSize: 17){
        didSet{
            self.textField.font = textFont
        }
    }

    @IBInspectable
    public var errorTextFont: UIFont? = .systemFont(ofSize: 13){
        didSet{
            self.errorLabel.font = errorTextFont
        }
    }

    @IBInspectable
    public var placeHolderTextFont: UIFont? = .systemFont(ofSize: 12){
        didSet{
            self.placeHolderLabel.font = placeHolderTextFont
        }
    }

    @IBInspectable
    public var errorColor: UIColor? = .red{
        didSet{
            self.errorLabel.textColor = errorColor
        }
    }

    public var verificationOnlyAtEnd: Bool? = true
    
    public var numberOfCharacters: Int?

    //MARK: - Properties
    
    @IBInspectable public var animateErrorText: Bool = true

    public var animationType: AnimationType? = .scaleMinimize
    public var errorText: String?
    public var textValidation: ((String) -> Bool)?
    public var animationDuration: TimeInterval = 0.5
    
    public var delegate: GMTextFieldSingularLineDelegate?
    public var actionDelegate: GMTextFieldActionDelegate?
    
    //MARK: - Life cycle
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        viewInitializer()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
        viewInitializer()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
        viewInitializer()
    }

    private func commonInit(){
        
        Bundle.init(for: GMTextFieldSingularLine.self).loadNibNamed("GMTextFieldSingularLine", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo:  leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        viewInitializer()
    }
    
    private func viewInitializer(){
        textField.delegate = self
        errorHorizontalStack.isHidden = true
        
        let leftRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(leftButtonSelected))
        let rightRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightButtonSelected))
        
        leftImageView.addGestureRecognizer(leftRecognizer)
        rightImageView.addGestureRecognizer(rightRecognizer)
        
        validation("")
    }
    
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if self.frame.height < 60 {
            leftSpaceViewHeightConstraint.constant = leftSpaceViewHeightConstraint.constant / 2
            
            rightSpaceViewHeightConstraint.constant = rightSpaceViewHeightConstraint.constant / 2
            
            textField.font = textField.font?.withSize(textField.font!.pointSize / 1.3)
            placeHolderLabel.font = placeHolderLabel.font.withSize(placeHolderLabel.font.pointSize / 1.2)
            errorLabel.font = errorLabel.font.withSize(placeHolderLabel.font.pointSize / 1.2)
        }
    }
    
    //MARK: - Validation
    
    private func validation(_ text: String?){
        
        guard let saveText = text else { return }
        
        let validationResult = self.textValidation?(saveText) ?? true
        
        if validationResult {
            errorLabel.text = ""
            separatorView.backgroundColor = color
        }else{
            animateErrorLabel()
            errorLabel.textColor = errorColor
            errorLabel.text = self.errorText
            separatorView.backgroundColor = errorColor
            animateView()
            animateErrorTextMessage()
        }
    }
}

//MARK: - Actions
extension GMTextFieldSingularLine {
    
    @objc func leftButtonSelected() {
        self.actionDelegate?.GMTextFieldDidTapButton(self, button: .left)
    }
    
    @objc func rightButtonSelected() {
        self.actionDelegate?.GMTextFieldDidTapButton(self, button: .right)
    }
    
}

//MARK: - TextField Delegate
extension GMTextFieldSingularLine: UITextFieldDelegate {
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        validation(textField.text)
        self.delegate?.GMTextFieldDidEndEditing(textField)
    }
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
//        if !(verificationOnlyAtEnd ?? true){
//            validation(textField.text)
//        }
        self.delegate?.GMTextFieldDidChangeSelection(textField)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        validation(textField.text)
        
        let returnValue = self.delegate?.GMTextFieldShouldReturn(textField)
        return returnValue ?? true
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
//        if !(verificationOnlyAtEnd ?? true){
//            validation(textField.text)
//        }
        
        let returnValue = self.delegate?.GMTextFieldShouldBeginEditing(textField)
        return returnValue ?? true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//        if !(verificationOnlyAtEnd ?? true){
//            validation(textField.text)
//        }
        
        let returnValue = self.delegate?.GMTextField(textField, shouldChangeCharactersIn: range, replacementString: string)
        
        var charactersVerification = true
        
        if let maxCharacters = self.numberOfCharacters {
            
            let newString = (textField.text ?? "" + string)
            
            if string == "" {
                charactersVerification = (newString.count - 1) <= maxCharacters
            }else{
                charactersVerification = newString.count <= maxCharacters
            }
        }

        return ((returnValue ?? true) && charactersVerification)
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        if !(verificationOnlyAtEnd!){
            validation(textField.text)
        }
        
        let returnValue = self.delegate?.GMTextFieldShouldClear(textField)
        return returnValue ?? true
    }
}

//MARK: - Animations
extension GMTextFieldSingularLine{
    
    func animateErrorLabel(){
        UIView.animate(withDuration: animationDuration, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 1, options: [], animations: {
            self.errorHorizontalStack.isHidden = false
            self.mainStack.layoutIfNeeded()
         },
        completion: nil)
    }
    
    func animateErrorTextMessage(){
        
        if animateErrorText == false { return }
        
        guard let saveErrorMessage = errorText else { return }
        
        self.errorLabel.text? = ""
        var characterIndex: Double = 0
        let initialDuration = self.animationDuration / 19

        for letter in saveErrorMessage {
            Timer.scheduledTimer(withTimeInterval: initialDuration * characterIndex, repeats: false) { (timer) in

                self.errorLabel.text?.append(letter)
            }
            characterIndex += 1
        }
        
    }
    
    func animateView(){
        
        let animation = SingleLineTextFieldAnimation(separatorWidth: separatorView.frame.width)
        
        let translate = animation.translate
        let scaleZoom = animation.scaleZoom
        let scaleMinimize = animation.scaleMinimize
        let rotateRight = animation.rotationRight
        let rotateLeft = animation.rotationLeft
        
        switch animationType {
        case .xTraslation:
            DispatchQueue.main.async {
                UIView.animate(withDuration: self.animationDuration, delay: 0, options: .autoreverse, animations: {
                    self.separatorView.transform = translate
                }, completion: { _ in
                    self.separatorView.transform = .identity
                })
            }
        case .scaleZoom:
            DispatchQueue.main.async {
                UIView.animate(withDuration: self.animationDuration, delay: 0, options: .autoreverse, animations: {
                    self.separatorView.transform = scaleZoom
                }, completion: { _ in
                    self.separatorView.transform = .identity
                })
            }
        case .scaleMinimize:
            DispatchQueue.main.async {
                UIView.animate(withDuration: self.animationDuration, delay: 0, options: .autoreverse, animations: {
                    self.separatorView.transform = scaleMinimize
                }, completion: { _ in
                    self.separatorView.transform = .identity
                })
            }
        case .xShake:
            shake(translation: "x", values: animation.shakeValues)
            
        case .yShake:
            shake(translation: "y", values: animation.shakeValues)
            
        case .rotationShake:
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: self.animationDuration/4, delay: 0, options: [], animations: {
                    UIView.modifyAnimations(withRepeatCount: 2, autoreverses: true, animations: {
                        self.separatorView.transform = rotateRight
                        self.separatorView.transform = rotateLeft
                    })
                }, completion: { _ in
                    self.separatorView.transform = .identity
                })
            }
            
        default:
            break
        }

    }

    
    func shake(translation: String, values: [CGFloat]){
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.\(translation)")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = values
        self.separatorView.layer.add(animation, forKey: "shake\(translation)")
    }
    
}
