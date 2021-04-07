//
//  CollectionViewCell.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 07/04/2021.
//

import UIKit
import Kingfisher
import Foundation
class GifCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var gifTitle: UILabel!
    @IBOutlet weak var authorUsernameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

    
    func configure(_ gif: GifModel){
        
        if let url = gif.url{
        gifImageView.kf.setImage(with:URL(string: url))
            print(url)
        }

        if gifImageView.image == nil{
            print("empty")
        } else {
            print("full")
        }
    }
}
