//
//  UIImageView+Extension.swift
//  swifty-companion
//
//  Created by Morgane on 17/04/2019.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func circle(image: UIImage, cornerRadius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 4.0
        self.contentMode = .scaleAspectFill
        self.image = image
    }
}
