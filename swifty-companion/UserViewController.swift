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
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.layer.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("***********************************************")
        //        print(self.user)
        self.view.setGradientBackground(colorOne: sweetPink, colorTwo: sweetViolet, gradientLayer: gradientLayer)
        profileStackView.addBackground(color: .white)
        
        if let profilePicture = self.user?.imageURL, let url = URL(string: profilePicture), let data = try? Data(contentsOf: url), let userImage = UIImage(data: data){
            
            let square = CGSize(width: 100, height: 100)
            
            profileImage.clipsToBounds = false
            profileImage.layer.cornerRadius = square.width/2
            profileImage.layer.shadowColor = UIColor.black.cgColor
            profileImage.layer.shadowOpacity = 1
            profileImage.layer.shadowOffset = CGSize.zero
            profileImage.layer.shadowRadius = 10
            profileImage.layer.shadowPath = UIBezierPath(roundedRect: profileImage.bounds, cornerRadius: square.width/2).cgPath
            
            let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = square.width/2
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.borderWidth = 4.0
            imageView.contentMode = .scaleAspectFill
            imageView.image = userImage
            
            profileImage.addSubview(imageView)
            
        }
        
        guard let userFirstName = self.user?.firstName, let userLastName = self.user?.lastName else {self.manageError("Missing user data : firstName or lastName"); return}
        fullName.text = "\(userFirstName) \(userLastName)"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
