//
//  UserViewController.swift
//  swifty-companion
//
//  Created by Morgane on 09/04/2019.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import UIKit

// Get level ?

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
    
    let gradientLayer = CAGradientLayer()
    
    var user:User?
    var userProjects:[UserProject]?
    
    
    func setProfileView() {
        guard let user = user else {alert(view: self, message: "No user provided"); return}
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
    
    func setProjectsView() {
        projectsTableView.delegate = self
        projectsTableView.dataSource = self
        
        projectsLabel.setTopCornerRadius(radius)
        projectsLabel.layer.backgroundColor = sweetPink.cgColor
        projectsLabel.textColor = .white
        projectsLabel.text = "PROJECTS"
        
        projectsView.layer.cornerRadius = radius
        projectsView.setShadow(radius)
        projectsTableView.setBottomCornerRadius(radius)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.layer.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("***********************************************")
        
        // get User Projects
        self.userProjects = self.user?.getProjects()
        
        
        // Set Main View
        self.view.setGradientBackground(colorOne: sweetPink, colorTwo: sweetViolet, gradientLayer: gradientLayer)
        scrollView.backgroundColor = UIColor.clear
        mainView.backgroundColor = UIColor.clear
        
        
        // Set Project View only if there are projects
        self.setProfileView()
        if let projects = self.userProjects, projects.count > 0 {
            self.setProjectsView()
        }
        else {
            projectsView.isHidden = true
        }
    }
    
    
    // Get number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let projects = self.userProjects else { return 0 }
        return projects.count
    }
    
    // Get project Final Mark depending on Project's Status
    func getProjectFinalMark(_ project:UserProject) -> String {
        guard let status = project.status else { return "No status" }
        switch(status) {
        case "parent": return "X"
        case "in_progress": return "In progress"
        case "creating_group": return "Creating group"
        case "searching_a_group": return "Searching a group"
        case "finished":
            guard let finalMark = project.finalMark else { return "No status" }
            return String(finalMark)
        default :
            return project.status ?? "No status"
        }
    }
    
    // Populate Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)
        guard let projects = self.userProjects else { return cell }
        let cellProject = projects[indexPath.row]
        guard let project = cellProject.project else { return cell }
        cell.textLabel?.text = project.name
        
        // Set project's final Mark
        let finalMark = getProjectFinalMark(cellProject)
        cell.detailTextLabel?.text = finalMark
        if (cellProject.status == "finished" && cellProject.validated != nil) {
            cell.detailTextLabel?.textColor = cellProject.validated == true ? sweetGreen : UIColor.red
        }
        else {
            cell.detailTextLabel?.textColor = UIColor.black
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
