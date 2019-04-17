//
//  User.swift
//  swifty-companion
//
//  Created by Morgane on 09/04/2019.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import Foundation
import UIKit

struct Project:Codable {
    let name: String?
}

struct UserProject:Codable {
    let finalMark: Int?
    let validated: Bool?
    let project: Project?

    private enum CodingKeys : String, CodingKey {
        case finalMark="final_mark", validated="validated?",project
    }
}

struct Skill:Codable {
    let name: String?
    let level: Float?
}

struct Cursus:Codable {
    let cursusId: Int?
    let level: Float?
    let skill: [Skill]?
    
    private enum CodingKeys : String, CodingKey {
        case cursusId="cursus_id", level, skill
    }
}

class User: Codable {
    let email: String?
    let login: String?
    let firstName: String?
    let lastName: String?
    let phone: String?
    let imageURL: String?
    let location: String?
    let cursus: [Cursus]?
    let projects: [UserProject]?
    
    
    
    private enum CodingKeys : String, CodingKey {
        case email, login, firstName="first_name", lastName="last_name", phone, imageURL="image_url", location, cursus="cursus_users", projects="projects_users"
    }
    
    func getFullName(view: UIViewController) -> String? {
        guard let userFirstName = self.firstName, let userLastName = self.lastName else { alert(view:view, message:"no full name found"); return nil}
        return "\(userFirstName) \(userLastName)"
    }
    
    func getProfileImage(view: UIViewController) -> UIImage? {
        guard let profilePicture = self.imageURL, let url = URL(string: profilePicture), let data = try? Data(contentsOf: url), let userImage = UIImage(data: data) else {alert(view:view, message:"no profile picture"); return nil}
        return userImage
    }
}
