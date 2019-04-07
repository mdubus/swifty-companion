//
//  ViewController.swift
//  swifty-companion
//
//  Created by Morgane DUBUS on 4/7/19.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//


import UIKit
import Alamofire

let AUTHURL = "https://api.intra.42.fr/oauth/token"

struct Token: Codable {
    let access_token: String
}


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
//        print("UID", ProcessInfo.processInfo.environment["UID"]!)
//        print("SECRET", ProcessInfo.processInfo.environment["SECRET"]!)
        
        guard let UID = ProcessInfo.processInfo.environment["UID"] else {return }
        guard let SECRET = ProcessInfo.processInfo.environment["SECRET"] else {return }
        
        Alamofire.request(AUTHURL, method: .post, parameters: [
            "grant_type":"client_credentials",
            "client_id":UID,
            "client_secret":SECRET
            ]).response {response in
                guard let data = response.data else { print("Unable to retrieve token"); return }
            do {
                let decoder = JSONDecoder()
                let tokenData = try decoder.decode(Token.self, from: data)
                print(tokenData.access_token)
            } catch let error {
                print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

