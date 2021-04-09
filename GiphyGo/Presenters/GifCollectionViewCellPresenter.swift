//
//  GifCollectionViewCellPresenter.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 09/04/2021.
//

import Foundation
import UIKit
import RealmSwift

class GifCollectionViewCellPresenter{
    
    func configureButtonState(button: inout UIButton, gif: GifModel){
        let realm = try? Realm()
        let favoriteGifs = realm?.objects(GifRealmModel.self)
        if ((favoriteGifs?.filter("gifID == '\(gif.id!)'").count)!) > 0 {
            button.setImage(#imageLiteral(resourceName: "heart-filled") , for: .normal)
        } else {
            button.setImage(#imageLiteral(resourceName: "heart-empty"), for: .normal)
        }
    }
    
     func handleFavoriteButtonTap(_ gif: GifModel) {
        let realm = try! Realm()
        let model = GifRealmModel()
        model.mapToModel(gif)
        let gifObject = realm.objects(GifRealmModel.self).filter("gifID == '\(gif.id!)'")
        if gifObject.count != 0{
            do {try? realm.write{
                realm.delete(gifObject)
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
    }
}
