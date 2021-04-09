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
    var limit = 10
    var searchIsActive = false
    var selectedGif: GifModel!
    var query = ""
    func fetchGifs(offset: Int, completion:@escaping  ()->()){
        self.offset = offset
        if !searchIsActive{
            NetworkManager.shared.fetchGifs(endPoint: Endpoints.trending.rawValue, parameters: ["api_key": NetworkManager.shared.getAPIKey(), "rating": UserDefaults.standard.object(forKey: "ContentRating") as! String, "offset": "\(offset)", "limit":"\(limit)"], shouldRefresh: false){ [weak self] (pics, count) in
                self?.gifs.append(contentsOf: pics)
                completion()
            }} else {
                NetworkManager.shared.fetchGifs(endPoint: Endpoints.trending.rawValue, parameters: ["api_key": NetworkManager.shared.getAPIKey(), "rating": UserDefaults.standard.object(forKey: "ContentRating") as! String, "offset": "\(offset)", "limit":"\(limit)", "q": query, "lang" :UserDefaults.standard.object(forKey: "Country") as! String], shouldRefresh: false){[weak self] (pics, count) in
                    self?.gifs.append(contentsOf: pics)
                    completion()
                }
            }
    }
    
    func searchForGifs(keyword: String,completion:@escaping  ()->()){
        searchIsActive = true
        query = keyword
        NetworkManager.shared.fetchGifs(endPoint: Endpoints.search.rawValue, parameters: ["api_key": NetworkManager.shared.getAPIKey(), "rating": UserDefaults.standard.object(forKey: "ContentRating") as! String, "q": keyword]){ [weak self] (pics, count) in
            self?.gifs = pics
            completion()
        }
    }
    
    func reload(){
        gifs.removeAll()
        offset = 0
    }
}
