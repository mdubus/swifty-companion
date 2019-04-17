//
//  UserViewController.swift
//  swifty-companion
//
//  Created by Morgane on 09/04/2019.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var profileInfosView: UIView!
    @IBOutlet weak var profileImage: UIView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var location: UILabel!
    
    let gradientLayer = CAGradientLayer()
    
    var user:User?

    
    func setProfileInformations() {
        // Set View
        profileInfosView.setCornerRadiusWithShadow(10.0)
        
        
        // Set Profile Picture
        
        if let userImage = self.user?.getProfileImage(view: self) {
            let square = CGSize(width: 100, height: 100)
            profileImage.setCornerRadiusWithShadow(square.width/2)
            let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
            imageView.circle(image: userImage, cornerRadius: square.width / 2)
            profileImage.addSubview(imageView)
        }
        
        fullName.text = self.user?.getFullName(view:self)
        email.text = self.user?.getEmail(view: self)
        phone.text = self.user?.getPhone(view: self)
        location.text = self.user?.getLocation(view: self)
        
        location.layer.backgroundColor = pink.cgColor
        location.clipsToBounds = true
        location.layer.cornerRadius = 10
        location.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        location.textColor = .white
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.layer.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setGradientBackground(colorOne: pink, colorTwo: sweetViolet, gradientLayer: gradientLayer)
        
        print("***********************************************")
        
        self.setProfileInformations()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
