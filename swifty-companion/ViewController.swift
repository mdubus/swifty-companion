//
//  ViewController.swift
//  swifty-companion
//
//  Created by Morgane DUBUS on 4/7/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//


import UIKit

class ViewController: UIViewController, APIDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var token: String = ""
    var apiController:APIController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiController = APIController(delegate: self)
        apiController!.getToken()
        searchBar.autocapitalizationType = .none
    }
    
    func retrieveToken(_ token: String) {
        self.token = token
    }
    
    func manageError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func searchForLogin(_ sender: UIButton) {
        guard let login = searchBar.text, login.trimmingCharacters(in: .whitespaces).isEmpty == false else {self.manageError("Please provide a login"); return}
        apiController!.getUser(login)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

