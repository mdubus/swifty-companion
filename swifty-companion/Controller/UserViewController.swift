//
//  UserViewController.swift
//  swifty-companion
//
//  Created by Morgane on 09/04/2019.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileInfosView: UIView!
    @IBOutlet weak var profileImage: UIView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var projectsLabel: UILabel!
    @IBOutlet weak var projectsTableView: UITableView!
    @IBOutlet weak var projectsView: UIView!
    @IBOutlet weak var skillsView: UIView!
    @IBOutlet weak var skillsLabel: UILabel!
    @IBOutlet weak var skillsTableView: UITableView!
    
    let gradientLayer = CAGradientLayer()
    var user:User?
    var userProjects:[UserProject]?
    var userSkills:[Skill]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get User Projects and Skills
        self.userProjects = self.user?.getProjects()
        self.userSkills = self.user?.getSkills()
        
        // Set Main View
        self.view.setGradientBackground(colorOne: sweetPink, colorTwo: sweetViolet, gradientLayer: gradientLayer)
        scrollView.backgroundColor = UIColor.clear
        mainView.backgroundColor = UIColor.clear
        
        // Set Project View only if there are projects
        self.setProfileView()
        if let projects = self.userProjects, projects.count > 0 {
            setTableView(tbView: projectsTableView, label: projectsLabel, view: projectsView)
        }
        else {
            projectsView.isHidden = true
        }
        
        // Set Skills View only if there are projects
        if let skills = self.userSkills, skills.count > 0 {
            setTableView(tbView: skillsTableView, label: skillsLabel, view: skillsView)
        }
        else {
            skillsView.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.layer.bounds
    }
    
    func setProfileView() {
        
        guard let user = user else { alert(view: self, message: "No user provided"); return }
        
        // Set View
        profileInfosView.layer.cornerRadius = radius
        profileInfosView.setShadow(radius)
        
        // Set Profile Picture
        if let userImage = user.getProfileImage(view: self) {
            let square = CGSize(width: 100, height: 100)
            profileImage.layer.cornerRadius = radius
            profileImage.setShadow(square.width/2)
            let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
            imageView.circle(image: userImage, cornerRadius: square.width / 2)
            profileImage.addSubview(imageView)
        }
        
        // Set user informations
        fullName.text = user.getFullName(view:self)
        email.text = user.getEmail(view: self)
        phone.text = user.getPhone(view: self)
        location.text = user.getLocation(view: self)
        
        level.text = "Level \(user.getLevel())"
        level.layer.backgroundColor = sweetPink.cgColor
        level.setBottomCornerRadius(radius)
        level.textColor = .white
    }
    
    // Set Table Views
    func setTableView(tbView: UITableView, label: UILabel, view:UIView){
        tbView.delegate = self
        tbView.dataSource = self
        
        label.setTopCornerRadius(radius)
        label.layer.backgroundColor = sweetPink.cgColor
        label.textColor = .white
        
        view.layer.cornerRadius = radius
        view.setShadow(radius)
        tbView.setBottomCornerRadius(radius)
    }
    
    // Get number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if (tableView == projectsTableView) {
            guard let projects = self.userProjects else { return 0 }
            count = projects.count
        }
        if (tableView == skillsTableView) {
            guard let skills = self.userSkills else { return 0 }
            count = skills.count
        }
        return count
    }
    
    // Populate Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if (tableView == projectsTableView) {
            cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)
            guard let projects = self.userProjects else { return cell }
            let cellProject = projects[indexPath.row]
            guard let project = cellProject.project else { return cell }
            cell.textLabel?.text = project.name
            
            // Set project's final Mark
            let finalMark = getProjectFinalMark(cellProject)
            cell.detailTextLabel?.text = finalMark
            if (cellProject.status == "finished" && cellProject.validated != nil) {
                cell.detailTextLabel?.textColor = cellProject.validated == true ? sweetGreen : sweetRed
            }
            else {
                cell.detailTextLabel?.textColor = UIColor.black
            }
        }
        
        if (tableView == skillsTableView) {
            cell = tableView.dequeueReusableCell(withIdentifier: "skillCell", for: indexPath)
            guard let skills = self.userSkills else { return cell }
            let cellSkill = skills[indexPath.row]
            cell.textLabel?.text = cellSkill.name
            let skillLevel = cellSkill.level
            cell.detailTextLabel?.text = String(describing: skillLevel ?? 0.0)
        }
        
        return cell
    }
    
    // Get project Final Mark depending on Project's Status
    func getProjectFinalMark(_ project:UserProject) -> String {
        guard let status = project.status else { return "No mark" }
        switch(status) {
        case "parent": return "X"
        case "in_progress": return "In progress"
        case "creating_group": return "Creating group"
        case "searching_a_group": return "Searching a group"
        case "finished":
            guard let finalMark = project.finalMark else { return "No mark" }
            return String(finalMark)
        default :
            return project.status ?? "No mark"
        }
    }
    
}
