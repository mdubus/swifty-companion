//
//  alert.swift
//  swifty-companion
//
//  Created by Morgane on 17/04/2019.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import UIKit

func alert(view: UIViewController, message: String) {
    let alert = UIAlertController(title: "Error", message: "\(message)", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
    DispatchQueue.main.async {
        view.present(alert, animated: true)
    }
}
