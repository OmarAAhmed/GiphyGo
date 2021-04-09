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
    var presenter = GifCollectionViewCellPresenter()
    
    fileprivate func configureViewCorners() {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    fileprivate func configureFontSize() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            gifTitleLabel.font = gifTitleLabel.font.withSize(24)
            authorUsernameLabel.font = authorUsernameLabel.font.withSize(20)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViewCorners()
        configureFontSize()
    }

    @IBAction func favoriteButtonWasTapped(_ sender: Any) {
        presenter.handleFavoriteButtonTap(gif)
        favoriteButton.image(for: .normal) == #imageLiteral(resourceName: "heart-empty") ?   favoriteButton.setImage(#imageLiteral(resourceName: "heart-filled") , for: .normal) : favoriteButton.setImage(#imageLiteral(resourceName: "heart-empty"), for: .normal)
        delegate?.reload()
    }
    
    func configureImageView(_ gif: GifModel) {
        if let url = gif.url{
            gifImageView.kf.setImage(with:URL(string: url))
        }
    }
    
    func configureLabels(_ gif: GifModel) {
        self.gif = gif
        configureImageView(gif)
        gifTitleLabel.text = gif.title
        authorUsernameLabel.text =  gif.user?.username!
    }
    
    func configure(_ gif: GifModel){
        configureLabels(gif)
        presenter.configureButtonState(button: &favoriteButton, gif: gif)
    }

}
