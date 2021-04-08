//
//  FeedPresenter.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 08/04/2021.
//

import Foundation


class FeedPresenter{
    var gifs = [GifModel]()
    var offset = 0
    var selectedGif: GifModel!
    
    func fetchGifs(completion:@escaping  ()->()){
        NetworkManager.shared.fetchGifs(endPoint: Endpoints.trending.rawValue, parameters: ["api_key": NetworkManager.shared.getAPIKey(), "rating": UserDefaults.standard.object(forKey: "ContentRating") as! String]){ [weak self] (pics, count) in
            self?.gifs = pics
            completion()
        }
    }
    
    func reload(){
        
    }
}
