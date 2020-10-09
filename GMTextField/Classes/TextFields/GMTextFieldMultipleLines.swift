//
//  GMTextFieldMultipleLines.swift
//  GMTextFiekd
//
//  Created by Gianpiero Mode on 17/07/2020.
//  Copyright © 2020 Gianpiero Mode. All rights reserved.
//

import UIKit

public protocol GMTextFieldMultipleLinesDelegate {
    
    func GMTextFieldMultipleLinesDidChange(_ textView: UITextView)
    func GMTextFielMultipleLinesDidBeginEditing(_ textView: UITextView)
    func GMTextFieldMultipleLinesDidEndEditing(_ textView: UITextView)
    func GMTextFieldMultipleLinesDidChangeSelection(_ textView: UITextView)
    func GMTextFieldMultipleLines(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    func GMTextFieldMultipleLines(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
    func GMTextFieldMultipleLines(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
}

@IBDesignable
public class GMTextFieldMultipleLines: UIView, GMCustomization {

    //MARK: - IBOutlets
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var allContentView: UIView!
    @IBOutlet private weak var errorStack: UIStackView!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var placeHolderLabel: UILabel!
    @IBOutlet private weak var viewWithContent: UIView!
    @IBOutlet private weak var horizontalContentStackView: UIStackView!
    @IBOutlet private weak var leftImageView: UIImageView!
    @IBOutlet public weak var textView: UITextView!
    @IBOutlet private weak var rightImageView: UIImageView!
    
    //MARK: - Compiled Properties
    
    @IBInspectable
    public var leftImage: UIImage? {
        didSet{
            guard leftImage != nil else {
                leftImageView.removeFromSuperview()
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
    public var color: UIColor! = .clear {
        didSet {
            backupColor = color
        }
    }
    
    @IBInspectable
    public var textColor: UIColor? = .black {
        didSet{
            self.textView.textColor = textColor
        }
    }
    
    @IBInspectable
    public var textFont: UIFont? = .systemFont(ofSize: 17) {
        didSet{
            self.textView.font = textFont
        }
    }
    
    @IBInspectable
    public var errorTextFont: UIFont? = .systemFont(ofSize: 13) {
        didSet{
            self.errorLabel.font = errorTextFont
        }
    }
    
    @IBInspectable
    public var placeHolderTextFont: UIFont? = .systemFont(ofSize: 12) {
        didSet{
            self.placeHolderLabel.font = placeHolderTextFont
        }
    }
    
    @IBInspectable
    public var errorColor: UIColor? {
        didSet{
            self.errorLabel.textColor = errorColor
        }
    }
    
    public var verificationOnlyAtEnd: Bool? = true
    
    public var numberOfLines: Int? = 5{
        didSet{
            
            guard let saveNumberOfLines = numberOfLines else { return }
            
            textView.textContainer.maximumNumberOfLines = saveNumberOfLines
        }
    }
    
    @IBInspectable public var animateErrorText: Bool = true
    
    //MARK: - Properties
    
    private var storkerLayer: CAShapeLayer?
    private var currentNumberOfLines: Int = 1
    private var backupColor: UIColor?
    
    public var errorText: String?
    public var textValidation: ((String) -> Bool)?
    public var animationDuration: TimeInterval = 0.5
    
    var delegate: GMTextFieldMultipleLinesDelegate?
    var actionDelegate: GMTextFieldActionDelegate?
    
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
        
        Bundle.init(for: GMTextFieldMultipleLines.self).loadNibNamed("GMTextFieldMultipleLines", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo:  leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        viewInitializer()
    }
    
    private func viewInitializer(){
        textView.isScrollEnabled = false
        textView.delegate = self
        
        let leftRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(leftButtonSelected))
        let rightRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(rightButtonSelected))
        
        leftImageView.addGestureRecognizer(leftRecognizer)
        rightImageView.addGestureRecognizer(rightRecognizer)
        
        textView.textContainer.maximumNumberOfLines = 5
        validation("")
    }
    
    //MARK: - Validation
    
    private func validation(_ text: String?){
        
        guard let saveText = text else { return }
        
        let validationResult = self.textValidation?(saveText) ?? true
        
        if validationResult {
            errorLabel.text = ""
            color = backupColor
        }else{
            animateErrorLabel()
            errorLabel.textColor = errorColor
            errorLabel.text = self.errorText
            color = errorColor
            animate()
            animateErrorTextMessage()
        }
    }
}

//MARK: - Animation

extension GMTextFieldMultipleLines {
    
    public func animate(isUpdate: Bool = false) {
        let storkeLayer = CAShapeLayer()
        storkeLayer.fillColor = UIColor.clear.cgColor
        
        let color = self.backupColor ?? UIColor.blue
        
        storkeLayer.strokeColor = color.cgColor
        storkeLayer.lineWidth = 2

        // Create a rounded rect path using button's bounds.
        storkeLayer.path = CGPath.init(roundedRect: viewWithContent.bounds, cornerWidth: 5, cornerHeight: 5, transform: nil) // same path like the empty one ...
        // Add layer to the button
        viewWithContent.layer.addSublayer(storkeLayer)

        // Create animation layer and add it to the stroke layer.
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(0.0)
        animation.toValue = CGFloat(1.0)
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        self.storkerLayer?.removeFromSuperlayer()
        self.storkerLayer = storkeLayer
        
        if isUpdate {
            self.storkerLayer?.frame = storkeLayer.frame

        }else {
            animation.duration = 1
            storkeLayer.add(animation, forKey: "circleAnimation")
        }
    }
    
    func animateErrorLabel(){
        UIView.animate(withDuration: animationDuration, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 1, options: [], animations: {
            self.errorStack.isHidden = false
            self.mainStackView.layoutIfNeeded()
         },
        completion: nil)
    }
    
    func animateErrorTextMessage(){
        
        if animateErrorText == false { return }
        
        guard let saveErrorMessage = errorText else { return }
        
        self.errorLabel.text? = ""
        self.errorLabel.textColor = errorColor ?? .red
        var characterIndex: Double = 0
        let initialDuration = self.animationDuration / 19

        for letter in saveErrorMessage {
            Timer.scheduledTimer(withTimeInterval: initialDuration * characterIndex, repeats: false) { (timer) in

                self.errorLabel.text?.append(letter)
            }
            characterIndex += 1
        }
        
    }
    
}

//MARK: - Actions
extension GMTextFieldMultipleLines {
    
    @objc func leftButtonSelected() {
        self.actionDelegate?.GMTextFieldDidTapButton(self, button: .left)
    }
    
    @objc func rightButtonSelected() {
        self.actionDelegate?.GMTextFieldDidTapButton(self, button: .right)
    }
    
}

//MARK: - UITextViewDelegate
extension GMTextFieldMultipleLines: UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        self.delegate?.GMTextFieldMultipleLinesDidChange(textView)
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        validation(textView.text)
        self.delegate?.GMTextFielMultipleLinesDidBeginEditing(textView)
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        self.delegate?.GMTextFieldMultipleLinesDidEndEditing(textView)
    }
    
    public func textViewDidChangeSelection(_ textView: UITextView) {
        self.delegate?.GMTextFieldMultipleLinesDidChangeSelection(textView)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        verificationOfAnimationSize()
        verificationOfLines()
        
        guard let returnValue = self.delegate?.GMTextFieldMultipleLines(textView, shouldChangeTextIn: range, replacementText: text) else {
            return true
        }
        return returnValue
    }
    
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        verificationOfAnimationSize()
        verificationOfLines()
        
        guard let returnValue = self.delegate?.GMTextFieldMultipleLines(textView, shouldInteractWith: URL, in: characterRange, interaction: interaction) else {
            return true
        }
        return returnValue
    }
    
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        verificationOfAnimationSize()
        verificationOfLines()
        
        guard let returnValue = self.delegate?.GMTextFieldMultipleLines(textView, shouldInteractWith: textAttachment, in: characterRange, interaction: interaction) else {
            return true
        }
        return returnValue
    }
    
    func verificationOfAnimationSize() {
        
        if textView.numberOfLines() != self.currentNumberOfLines {
            self.currentNumberOfLines = textView.numberOfLines()
            
            self.animate(isUpdate: true)
        }
    }
    
    func verificationOfLines() {
        if textView.textContainer.maximumNumberOfLines <= textView.numberOfLines() {
            textView.isScrollEnabled = true
            textView.textContainer.maximumNumberOfLines += 1
        }else {
            
            if textView.textContainer.maximumNumberOfLines > self.numberOfLines! {
                textView.textContainer.maximumNumberOfLines -= 1
            }else{
                textView.isScrollEnabled = false
            }
        }
    }
}
