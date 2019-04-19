//
//  ViewController.swift
//  swifty-companion
//
//  Created by Morgane DUBUS on 4/7/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//


import UIKit

class ViewController: UIViewController, APIDelegate {
    
    @IBOutlet weak var input: UISearchBar!
    @IBOutlet weak var submit: UIButton!
    
    func manageError(_ error: String) {
        alert(view:self, message:error)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    var token: String = ""
    var apiController:APIController?
    let gradientLayer = CAGradientLayer()
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.layer.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input.layer.cornerRadius = 10.0
        submit.layer.cornerRadius = 10.0
        self.view.setGradientBackground(colorOne: sweetPink, colorTwo: sweetViolet, gradientLayer:gradientLayer)
        apiController = APIController(delegate: self)
        apiController!.getToken()
        searchBar.autocapitalizationType = .none
    }
    
    func retrieveToken(_ token: String) {
        self.token = token
    }
    
    func retrieveUserData(_ userData: User) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "userViewController") as? UserViewController else {alert(view:self, message:"No userViewController found !"); return}
        vc.user = userData
        guard userData.login != nil else {alert(view:self, message: "Not a valid login"); return}
        if let navigator = navigationController {
            navigator.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func searchForLogin(_ sender: UIButton) {
        guard let login = searchBar.text, login.trimmingCharacters(in: .whitespaces).isEmpty == false else {alert(view:self, message:"Please provide a login"); return}
        apiController!.getUser(login)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

