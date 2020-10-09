//
//  GMTextFieldAnimation.swift
//  GMTextFiekd
//
//  Created by Gianpiero Mode on 25/07/2020.
//  Copyright © 2020 Gianpiero Mode. All rights reserved.
//

import Foundation
import UIKit

protocol GMTextFieldAnimation {
    
    var animationType: AnimationType? { get set }
    var translationX: CGFloat { get set }
    var translateX: CGFloat { get set }
    var translateY: CGFloat { get set }
    var scaleZoomX: CGFloat { get set }
    var scaleZoomY: CGFloat { get set }
    var scaleMinimizeX: CGFloat { get set }
    var scaleMinimizeY: CGFloat { get set }
    var rotationLeftAngle: CGFloat { get set }
    var rotationRightAngle: CGFloat { get set }
    var shakeValues: [CGFloat] { get set }
}

extension GMTextFieldAnimation {
    
    var animationType: AnimationType? {
        get {
            return animationType != nil ? animationType : .yShake
        }
        set {
            animationType = newValue
        }
    }
    
    var translate: CGAffineTransform {
        return CGAffineTransform(translationX: translationX, y: 0)
    }
    
    var scaleZoom: CGAffineTransform {
        return CGAffineTransform(scaleX: scaleZoomX, y: scaleZoomY)
    }
    
    var scaleMinimize: CGAffineTransform {
        return CGAffineTransform(scaleX: scaleMinimizeX, y: scaleMinimizeY)
    }
    
    var rotationLeft: CGAffineTransform {
        return CGAffineTransform(rotationAngle: rotationLeftAngle)
    }
    
    var rotationRight: CGAffineTransform {
        return CGAffineTransform(rotationAngle: rotationRightAngle)
    }
        
}

struct SingleLineTextFieldAnimation: GMTextFieldAnimation {
    
    var translationX: CGFloat
    var translateX: CGFloat
    var translateY: CGFloat
    var scaleZoomX: CGFloat
    var scaleZoomY: CGFloat
    var scaleMinimizeX: CGFloat
    var scaleMinimizeY: CGFloat
    var rotationLeftAngle: CGFloat
    var rotationRightAngle: CGFloat
    var shakeValues: [CGFloat]
    
    init(separatorWidth: CGFloat) {
        self.translationX = separatorWidth
        self.translateX = translationX
        self.translateY = 0
        self.scaleZoomX = 5
        self.scaleZoomY = 1
        self.scaleMinimizeX = 0.1
        self.scaleMinimizeY = 1
        self.rotationRightAngle = .pi / 40
        self.rotationLeftAngle = -.pi / 40
        self.shakeValues = [-4.0, 4.0, -4.0, 4.0, -4.0, 4.0, -4.0, 4.0, 0.0 ]
    }
}
