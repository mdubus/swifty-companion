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
    let parent_id: Int?
}

struct UserProject:Codable {
    let cursusIDs : [Int]
    let finalMark: Int?
    let status: String?
    let validated: Bool?
    let project: Project?
    
    private enum CodingKeys : String, CodingKey {
        case cursusIDs="cursus_ids", finalMark="final_mark", status, validated="validated?", project
    }
}

struct Skill:Codable {
    let name: String?
    let level: Float?
}

struct Cursus:Codable {
    let cursusId: Int?
    let level: Float?
    let skills: [Skill]?
    
    private enum CodingKeys : String, CodingKey {
        case cursusId="cursus_id", level, skills
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
        guard let profilePicture = self.imageURL, let url = URL(string: profilePicture), let data = try? Data(contentsOf: url), let userImage = UIImage(data: data) else {
            return UIImage(named: "default-picture")
            }
        return userImage
    }
    
    func getEmail(view: UIViewController) -> String? {
        guard let email = self.email else { alert(view:view, message:"no email" ) ;return nil}
        return email
    }
    
    func getPhone(view: UIViewController) -> String {
        guard let phone = self.phone else { return "No phone number"}
        return phone
    }
    
    func getLocation(view: UIViewController) -> String {
        guard let location = self.location else { return "Unavailable"}
        return location
    }
    
    func getProjects() -> [UserProject]? {
        guard let projects = self.projects else { return [] }
        
        let userProjects = projects.filter({ ($0.cursusIDs.contains(studentCursus) || $0.cursusIDs.contains(seniorCursus)) && $0.project?.parent_id == nil})
        if (userProjects.count > 0) {return userProjects}
        
        return []
    }
    
    func getSkills() -> [Skill]? {
        guard let cursus = self.cursus else { return [] }
        guard let userCursus = cursus.filter({ $0.cursusId == studentCursus || $0.cursusId == seniorCursus}).first else { return [] }
        return userCursus.skills
    }
    
    func getLevel() -> String {
        guard let cursus = self.cursus else {  return "0"}
        if cursus.count == 0 {return "0"}
        
        // filter cursus
        guard let level = cursus[0].level else {return "0"}
        return level.description
    }
}
