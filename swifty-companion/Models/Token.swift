//
//  Token.swift
//  swifty-companion
//
//  Created by Morgane on 08/04/2019.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation

struct Token: Codable {
    let accessToken: String?
    
    private enum CodingKeys : String, CodingKey {
        case accessToken="access_token"
    }
}
