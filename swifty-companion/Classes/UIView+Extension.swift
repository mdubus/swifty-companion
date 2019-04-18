//
//  UIViewExtension.swift
//  swifty-companion
//
//  Created by Morgane on 15/04/2019.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import UIKit

let pink = UIColor.init(red: 253.0/255.0, green: 121.0/255.0, blue: 168.0/255.0, alpha: 1.0)
let sweetPink = UIColor.init(red: 1.0, green: 142.0/255.0, blue: 158.0/255.0, alpha: 1.0)
let sweetViolet = UIColor.init(red: 129.0/255.0, green: 120.0/255.0, blue: 1.0, alpha: 1.0)

extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor, gradientLayer:CAGradientLayer) {
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y:1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setCornerRadiusWithShadow(_ cornerRadius: CGFloat) {
        self.clipsToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = sweetViolet.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
    }
}
