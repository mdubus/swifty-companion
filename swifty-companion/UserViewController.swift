//
//  UserViewController.swift
//  swifty-companion
//
//  Created by Morgane on 09/04/2019.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var profileImage: UIView!
    @IBOutlet weak var profileStackView: UIStackView!
    @IBOutlet weak var fullName: UILabel!
    
    let gradientLayer = CAGradientLayer()
    
    var user:User?
    
    func manageError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func setProfileInformations() {
        // Set View
        
        self.view.setGradientBackground(colorOne: sweetPink, colorTwo: sweetViolet, gradientLayer: gradientLayer)
        profileStackView.addBackground(color: .white)
        
        // Set Profile Picture
        
        if let userImage = self.user?.getProfileImage(view: self) {
            let square = CGSize(width: 100, height: 100)
            profileImage.setCornerRadiusWithShadow(square.width/2)
            let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
            imageView.circle(image: userImage, cornerRadius: square.width / 2)
            profileImage.addSubview(imageView)
        }
        
        // Set User Full Name
        
        fullName.text = self.user?.getFullName(view:self)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.layer.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("***********************************************")
        
        self.setProfileInformations()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
