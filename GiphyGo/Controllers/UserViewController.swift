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
    @IBOutlet weak var websiteView: UIView!
    @IBOutlet weak var instagramView: UIView!
  
    @IBAction func websiteButtonWasTapped(_ sender: Any) {
        if let url = URL(string: user.websiteUrl!) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func instagramButtonWasTapped(_ sender: Any) {
        if let url = URL(string: user.instagramUrl!) {
            UIApplication.shared.open(url)
        }
    }
    var user: UserModel!
    
    override func viewDidLoad() {
        configureUIComponents()
    }
    

    fileprivate func configureUIComponents() {
        configureLabels()
        configureAvatar()
        configureVerifiedVisibility()
        configureButtons()
    }
    
    fileprivate func configureAvatar() {
        avatarImageView.kf.setImage(with:URL(string: user.avatarUrl ?? ""))
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.borderColor = UIColor.black.cgColor
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        avatarImageView.clipsToBounds = true
    }
    
    fileprivate func configureLabels() {
        usernameLabel.text = user.username
        descriptionLabel.text = user.description
        if UIDevice.current.userInterfaceIdiom == .pad {
            usernameLabel.font = usernameLabel.font.withSize(24)
            descriptionLabel.font = descriptionLabel.font.withSize(20)
        }
    }
    
    func configureButtons(){
        if user.instagramUrl?.isEmpty == true{
            instagramView.isHidden = true
        }  else {
            instagramView.isHidden = false
        }
        if user.websiteUrl?.isEmpty == true{
            websiteView.isHidden = true
        }  else {
            websiteView.isHidden = false
        }
    }
    
    fileprivate func configureVerifiedVisibility() {
        if user.isVerified!{
            verifiedImageView.isHidden = false
        }
    }
}
