//
//  CollectionViewCell.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 07/04/2021.
//

import UIKit
import Kingfisher
import Foundation
import Realm
class GifCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var gifTitleLabel: UILabel!
    @IBOutlet weak var authorUsernameLabel: UILabel!
    
    let relativeFontConstant:CGFloat = 0.046
    var gif: GifModel!
    var saved = UserDefaults.standard.stringArray(forKey: "favoritedGifs") ?? [String]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
   
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        if UIDevice.current.userInterfaceIdiom == .pad {
            gifTitleLabel.font = gifTitleLabel.font.withSize(24)
        authorUsernameLabel.font = authorUsernameLabel.font.withSize(20)
        }
    
    }

    @IBAction func favoriteButtonWasTapped(_ sender: Any) {
        if  favoriteButton.image(for: .normal) == #imageLiteral(resourceName: "heart-empty"){
            favoriteButton.setImage(#imageLiteral(resourceName: "heart-filled") , for: .normal)
            saved.append(gif.id!)
            UserDefaults.standard.removeObject(forKey: "favoritedGifs")
            UserDefaults.standard.setValue(saved, forKey: "favoritedGifs")
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "heart-empty"), for: .normal)
            var index = saved.firstIndex(of: gif.id!)
            saved.remove(at: index!)
            UserDefaults.standard.removeObject(forKey: "favoritedGifs")
            UserDefaults.standard.setValue(saved, forKey: "favoritedGifs")
        }
    }
    
    func configure(_ gif: GifModel){
        self.gif = gif
        if let url = gif.url{
        gifImageView.kf.setImage(with:URL(string: url))
            print(url)
        }
        gifTitleLabel.text = gif.title
        authorUsernameLabel.text =  gif.user?.username!
        if (saved.contains(gif.id!)){
            favoriteButton.setImage(#imageLiteral(resourceName: "heart-filled") , for: .normal)
        } else {
            favoriteButton.setImage(#imageLiteral(resourceName: "heart-empty"), for: .normal)
        }
    }
}
