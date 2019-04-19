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
        
        projectsView.layer.cornerRadius = radius
        projectsView.setShadow(radius)
        projectsTableView.layer.cornerRadius = radius
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.layer.bounds
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set main View
        self.view.setGradientBackground(colorOne: sweetPink, colorTwo: sweetViolet, gradientLayer: gradientLayer)
        scrollView.backgroundColor = UIColor.clear
        mainView.backgroundColor = UIColor.clear

        
        print("***********************************************")
        
        self.setProfileView()
        self.setProjectsView()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let projects = self.user!.projects else {alert(view:self, message: "No project for user"); return 0}
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)
        guard let projects = self.user!.projects else {alert(view:self, message: "No project for user"); return cell}
        cell.textLabel?.text = projects[indexPath.row].project?.name
        
        
        if let finalMark = projects[indexPath.row].finalMark {
            cell.detailTextLabel?.text = String(finalMark)
            if let validated = projects[indexPath.row].validated {
                if (validated) {
                    cell.detailTextLabel?.textColor = UIColor.green
                }
                else if (validated == false) {
                    cell.detailTextLabel?.textColor = UIColor.red
                }
            }
        }
        else {
            cell.detailTextLabel?.text = "No notation yet"
        }
        
        
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
