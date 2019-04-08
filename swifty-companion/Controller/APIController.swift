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

protocol APIDelegate:class {
    func manageError(_ error:String)
    func retrieveToken(_ token: String)
}

class APIController {
    weak var delegate: APIDelegate?
    var uid: String?
    var secret: String?
    var token: String?
    
    init(delegate: APIDelegate?) {
        guard self.delegate = delegate else { print("no gelegate found");return }
        guard self.uid = ProcessInfo.processInfo.environment["UID"] else {self.delegate?.manageError("No UID provided");return }
        guard self.secret = ProcessInfo.processInfo.environment["SECRET"] else {self.delegate?.manageError("No Secret provided"); return }
    }
    
    func getToken() {
        let params = [
            "grant_type": "client_credentials",
            "client_id": self.uid,
            "client_secret": self.secret
        ]
        
        Alamofire.request(AUTHURL, method: .post, parameters: params).response {response in
            guard let data = response.data else { self.delegate?.manageError("Unable to retrieve token"); return }
//            print(String(data: data, encoding: String.Encoding.utf8) as Any)
            do {
                let decoder = JSONDecoder()
                let tokenData = try decoder.decode(Token.self, from: data)
                guard let token = tokenData.access_token else {return}
                self.delegate?.retrieveToken(token)
                self.token = token
            } catch let error {
                self.delegate?.manageError(error.localizedDescription)
            }
        }
    }
}
