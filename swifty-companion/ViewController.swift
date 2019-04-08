//
//  ViewController.swift
//  swifty-companion
//
//  Created by Morgane DUBUS on 4/7/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//


import UIKit

class ViewController: UIViewController, APIDelegate {
    var token: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let apiController = APIController(delegate: self)
        apiController.getToken()
    }
    
    func retrieveToken(_ token: String) {
        self.token = token
        print(self.token)
    }
    
    func manageError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

