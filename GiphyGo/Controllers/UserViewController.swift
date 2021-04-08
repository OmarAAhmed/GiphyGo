//
//  UserViewController.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 08/04/2021.
//

import Foundation
import UIKit

class UserViewController: UIViewController{
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var verifiedImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var user: UserModel!
    
    override func viewDidLoad() {
        avatarImageView.kf.setImage(with:URL(string: user.avatarUrl ?? ""))
        usernameLabel.text = user.username
        descriptionLabel.text = user.description
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.borderColor = UIColor.black.cgColor
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        avatarImageView.clipsToBounds = true
        if user.isVerified!{
            verifiedImageView.isHidden = false
        }
    }
    
}
