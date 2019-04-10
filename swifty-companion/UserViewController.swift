//
//  UserViewController.swift
//  swifty-companion
//
//  Created by Morgane on 09/04/2019.
//  Copyright © 2019 Morgane DUBUS. All rights reserved.
//

import UIKit

extension UIImage {
    var circle: UIImage {
        let square = CGSize(width: 150, height: 150)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
}


class UserViewController: UIViewController {
    var user:User?
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mail: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var location: UILabel!
    
    func manageError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("***********************************************")
        print(self.user)
        if let profilePicture = self.user?.imageURL, let url = URL(string: profilePicture), let data = try? Data(contentsOf: url), let userImage = UIImage(data: data){
            image.image = userImage.circle
        }
        guard let userLogin = self.user?.login else {self.manageError("Unable to retrieve user's login"); return}
        login.text = userLogin
        login.font = UIFont(name: "GujaratiSangamMN-Bold", size: 18.0)
        
        guard let firstName = self.user?.firstName, let lastName = self.user?.lastName else {self.manageError("Unable to retrieve user's full name"); return}
        name.text = "\(lastName) \(firstName)"
        
        if let userMail = self.user?.email {
            mail.text = userMail
        } else {
            mail.text = "No email"
        }
        
        if let userPhone = self.user?.phone {
            phone.text = userPhone
        }
        else {
            phone.text = "No phone number"
        }
        
        if let userLocation = self.user?.location {
            location.text = userLocation
        } else {
            location.text = "Unavailable"
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
