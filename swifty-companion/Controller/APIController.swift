//
//  APIController.swift
//  swifty-companion
//
//  Created by Morgane on 08/04/2019.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import Alamofire

let AUTHURL = "https://api.intra.42.fr/oauth/token"
let USERURL = "https://api.intra.42.fr/v2/users"

protocol APIDelegate:class {
    func manageError(_ error:String)
    func retrieveToken(_ token: String)
}

class APIController {
    weak var delegate: APIDelegate?
    var token: String?
    
    init(delegate: APIDelegate?) {
        guard let myDelegate = delegate else { print("no gelegate found");return }
        self.delegate = myDelegate
    }
    
    func getToken() {
        guard let uid = ProcessInfo.processInfo.environment["UID"] else {self.delegate?.manageError("No UID provided");return }
        guard let secret = ProcessInfo.processInfo.environment["SECRET"] else {self.delegate?.manageError("No Secret provided"); return }
        
        let params = [
            "grant_type": "client_credentials",
            "client_id": uid,
            "client_secret": secret
        ]
        
        Alamofire.request(AUTHURL, method: .post, parameters: params).response {response in
            guard let data = response.data else { self.delegate?.manageError("No data in response"); return }
            print(String(data: data, encoding: String.Encoding.utf8) as Any)
            do {
                let decoder = JSONDecoder()
                let tokenData = try decoder.decode(Token.self, from: data)
                guard let token = tokenData.accessToken else {self.delegate?.manageError("Unable to retrieve token"); return}
                self.delegate?.retrieveToken(token)
                self.token = token
            } catch let error {
                self.delegate?.manageError(error.localizedDescription)
            }
        }
    }
    
    func getUser(_ login:String) {
        guard let token = self.token else {self.delegate?.manageError("Unable to retrieve token");return}
        let header: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
                                   "Authorization" : "Bearer \(token)"];
        
        print("TOKEN = \(token)")
        
        Alamofire.request("\(USERURL)/\(login)", method: .get, headers: header).response {response in
            guard let data = response.data else { self.delegate?.manageError("Unable to retrieve user by login"); return }
//                        print(String(data: data, encoding: String.Encoding.utf8) as Any)
            do {
                let decoder = JSONDecoder()
                let userData = try decoder.decode(User.self, from: data)
                print(userData)
            } catch let error {
                self.delegate?.manageError(error.localizedDescription)
            }
        }
    }
}
