//
//  CollectionViewCell.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 07/04/2021.
//

import UIKit
import Kingfisher
import Foundation
import RealmSwift
class GifCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var gifTitleLabel: UILabel!
    @IBOutlet weak var authorUsernameLabel: UILabel!

    var gif: GifModel!
    var delegate: ReloadDataProtocol?

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
        let realm = try! Realm()
        let model = GifRealmModel()
        model.mapToModel(gif)
        let recipeObject = realm.objects(GifRealmModel.self).filter("gifID == '\(gif.id!)'")
        if recipeObject.count != 0{
            do {try? realm.write{
                realm.delete(recipeObject)
                }  
            }
        } else {
            do{ try realm.write{
                realm.add(model)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        favoriteButton.image(for: .normal) == #imageLiteral(resourceName: "heart-empty") ?   favoriteButton.setImage(#imageLiteral(resourceName: "heart-filled") , for: .normal) : favoriteButton.setImage(#imageLiteral(resourceName: "heart-empty"), for: .normal)
        delegate?.reload()
    }
    
    func configure(_ gif: GifModel){
        self.gif = gif
        if let url = gif.url{
        gifImageView.kf.setImage(with:URL(string: url))
        }
        gifTitleLabel.text = gif.title
        authorUsernameLabel.text =  gif.user?.username!
        configureButtonState(button: &favoriteButton, recipe: gif)
    }
    
     func configureButtonState(button: inout UIButton, recipe: GifModel){
        let realm = try? Realm()
        let favoriteGifs = realm?.objects(GifRealmModel.self)
        if ((favoriteGifs?.filter("gifID == '\(gif.id!)'").count)!) > 0 {
            button.setImage(#imageLiteral(resourceName: "heart-filled") , for: .normal)
        } else {
            button.setImage(#imageLiteral(resourceName: "heart-empty"), for: .normal)
        }
    }
}
