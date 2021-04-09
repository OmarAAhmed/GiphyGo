//
//  FavoritesPresenter.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 09/04/2021.
//

import Foundation
import RealmSwift

class FavoritesPresenter{
    var gifs = [GifModel]()
    var favoritesString = ""
    var offset = 0
    var selectedGif: GifModel!
    
    func fetchFavorites(completion: @escaping ()->()){
        NetworkManager.shared.fetchGifs(endPoint: "", parameters: ["api_key": NetworkManager.shared.getAPIKey(), "rating": UserDefaults.standard.object(forKey: "ContentRating") as! String, "ids": favoritesString] ){ [weak self] (pics, count) in
            self?.gifs = pics
            completion()
        }
    }
    
}
